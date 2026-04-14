import 'dart:async';
import 'dart:io';

import 'package:computer/computer.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:fl_lib/fl_lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:server_box/core/extension/ssh_client.dart';
import 'package:server_box/core/utils/server.dart';
import 'package:server_box/core/utils/ssh_auth.dart';
import 'package:server_box/data/helper/ssh_decoder.dart';
import 'package:server_box/data/helper/system_detector.dart';
import 'package:server_box/data/model/app/error.dart';
import 'package:server_box/data/model/app/scripts/script_consts.dart';
import 'package:server_box/data/model/app/scripts/shell_func.dart';
import 'package:server_box/data/model/server/connection_stat.dart';
import 'package:server_box/data/model/server/server.dart';
import 'package:server_box/data/model/server/server_private_info.dart';
import 'package:server_box/data/model/server/server_status_update_req.dart';
import 'package:server_box/data/model/server/system.dart';
import 'package:server_box/data/model/server/try_limiter.dart';
import 'package:server_box/data/provider/server/all.dart';
import 'package:server_box/data/res/status.dart';
import 'package:server_box/data/res/store.dart';
import 'package:server_box/data/ssh/persistent_shell.dart';
import 'package:server_box/data/ssh/session_manager.dart';

part 'single.g.dart';
part 'single.freezed.dart';

// Individual server state, including connection and status information
@freezed
abstract class ServerState with _$ServerState {
  const factory ServerState({
    required Spi spi,
    required ServerStatus status,
    @Default(ServerConn.disconnected) ServerConn conn,
    SSHClient? client,
  }) = _ServerState;
}

// Individual server state management
@Riverpod(keepAlive: true)
class ServerNotifier extends _$ServerNotifier {
  PersistentShell? _persistentShell;

  @override
  ServerState build(String serverId) {
    ref.onDispose(() {
      unawaited(_disposePersistentShell());
    });

    final serverNotifier = ref.read(serversProvider);
    final spi = serverNotifier.servers[serverId];
    if (spi == null) {
      throw StateError('Server $serverId not found');
    }

    return ServerState(spi: spi, status: InitStatus.status);
  }

  void updateConnection(ServerConn conn) {
    state = state.copyWith(conn: conn);
  }

  void updateStatus(ServerStatus status) {
    state = state.copyWith(status: status);
  }

  void updateClient(SSHClient? client) {
    if (!identical(state.client, client)) {
      unawaited(_disposePersistentShell());
    }
    state = state.copyWith(client: client);
  }

  void updateSpi(Spi spi) {
    state = state.copyWith(spi: spi);
  }

  void _setFailedState(ServerStatus status, {bool closeClient = false}) {
    final client = state.client;
    unawaited(_disposePersistentShell());
    if (closeClient) {
      client?.close();
    }
    state = state.copyWith(
      status: status,
      client: closeClient ? null : client,
      conn: ServerConn.failed,
    );
  }

  /// Consolidated error handler for all _getData phases.
  void _handleDataError(
    String sid,
    String sessionId,
    ServerStatus newStatus, {
    bool closeClient = false,
  }) {
    TryLimiter.inc(sid);
    _setFailedState(newStatus, closeClient: closeClient);
    TermSessionManager.updateStatus(sessionId, TermSessionStatus.disconnected);
  }

  /// Classify connection errors using typed checks first, string matching as fallback.
  ConnectionResult _classifyConnectionError(Object e) {
    if (e is TimeoutException) return ConnectionResult.timeout;
    if (e is SocketException) return ConnectionResult.networkError;

    final msg = e.toString().toLowerCase();
    if (msg.contains('timed out') || msg.contains('timeout')) {
      return ConnectionResult.timeout;
    }
    if (msg.contains('auth') ||
        msg.contains('authentication') ||
        msg.contains('permission denied') ||
        msg.contains('access denied')) {
      return ConnectionResult.authFailed;
    }
    if (msg.contains('connection refused') ||
        msg.contains('no route to host') ||
        msg.contains('network') ||
        msg.contains('socket')) {
      return ConnectionResult.networkError;
    }
    return ConnectionResult.unknownError;
  }

  void closeConnection() {
    unawaited(_disposePersistentShell());
    state.client?.close();
    state = state.copyWith(client: null, conn: ServerConn.disconnected);
  }

  bool _isRefreshing = false;

  Future<void> refresh() async {
    if (_isRefreshing) return;

    _isRefreshing = true;
    try {
      await _updateServer();
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _updateServer() async {
    await _getData();
  }

  /// Connect to the server. Returns true on success, false on failure.
  Future<bool> _connectPhase(Spi spi, String sid) async {
    // Wake on LAN
    final wol = spi.wolCfg;
    if (wol != null) {
      try {
        await wol.wake();
      } catch (e) {
        Loggers.app.warning('Wake on lan failed', e);
      }
    }

    final time1 = DateTime.now();
    try {
      final client = await genClient(
        spi,
        timeout: Duration(seconds: Stores.setting.timeout.fetch()),
        onKeyboardInteractive: (_) => KeybordInteractive.defaultHandle(spi),
      );
      updateClient(client);

      final time2 = DateTime.now();
      final spentTime = time2.difference(time1).inMilliseconds;
      if (spi.jumpId == null) {
        Loggers.app.info('Connected to ${spi.name} in $spentTime ms.');
      } else {
        Loggers.app.info('Jump to ${spi.name} in $spentTime ms.');
      }

      try {
        await Stores.connectionStats.recordConnection(
          ConnectionStat(
            serverId: spi.id,
            serverName: spi.name,
            timestamp: time1,
            result: ConnectionResult.success,
            durationMs: spentTime,
          ),
        );
      } catch (e) {
        Loggers.app.warning('Failed to record connection success', e);
      }

      final sessionId = 'ssh_${spi.id}';
      TermSessionManager.add(
        id: sessionId,
        spi: spi,
        startTimeMs: time1.millisecondsSinceEpoch,
        disconnect: () =>
            ref.read(serversProvider.notifier).closeOneServer(spi.id),
        status: TermSessionStatus.connecting,
        setAsActive: false,
      );
      TermSessionManager.setActive(sessionId, hasTerminal: false);
      return true;
    } catch (e) {
      final durationMs = DateTime.now().difference(time1).inMilliseconds;
      final failureResult = _classifyConnectionError(e);

      try {
        await Stores.connectionStats.recordConnection(
          ConnectionStat(
            serverId: spi.id,
            serverName: spi.name,
            timestamp: time1,
            result: failureResult,
            errorMessage: e.toString(),
            durationMs: durationMs,
          ),
        );
      } catch (recErr) {
        Loggers.app.warning('Failed to record connection failure', recErr);
      }

      final newStatus = state.status.copyWith(
        err: SSHErr(type: SSHErrType.connect, message: e.toString()),
      );
      _handleDataError(sid, 'ssh_${spi.id}', newStatus, closeClient: true);

      // Remove SSH session when connection fails
      TermSessionManager.remove('ssh_${spi.id}');

      Loggers.app.warning('Connect to ${spi.name} failed', e);
      return false;
    }
  }

  /// Write the status script to the server. Returns the detected [SystemType],
  /// or null if the phase failed.
  Future<SystemType?> _writeScriptPhase(Spi spi, String sid) async {
    final sessionId = 'ssh_${spi.id}';
    try {
      // Detect system type
      final detectedSystemType = await SystemDetector.detect(
        state.client!,
        spi,
      );
      final newStatus = state.status.copyWith(system: detectedSystemType);
      updateStatus(newStatus);

      Loggers.app.info(
        'Writing script for ${spi.name} (${detectedSystemType.name})',
      );

      final (stdoutResult, writeScriptResult) = await state.client!.execSafe(
        (session) async {
          final scriptRaw = ShellFuncManager.allScript(
            spi.custom?.cmds,
            systemType: detectedSystemType,
            disabledCmdTypes: spi.disabledCmdTypes,
          ).uint8List;
          session.stdin.add(scriptRaw);
          session.stdin.close();
        },
        entry: ShellFuncManager.getInstallShellCmd(
          spi.id,
          systemType: detectedSystemType,
          customDir: spi.custom?.scriptDir,
        ),
        systemType: detectedSystemType,
        context: 'WriteScript<${spi.name}>',
      );

      if (stdoutResult.isNotEmpty) {
        Loggers.app.info('Script write stdout for ${spi.name}: $stdoutResult');
      }

      if (writeScriptResult.isNotEmpty) {
        Loggers.app.warning(
          'Script write stderr for ${spi.name}: $writeScriptResult',
        );
        if (detectedSystemType != SystemType.windows) {
          ShellFuncManager.switchScriptDir(
            spi.id,
            systemType: detectedSystemType,
          );
          throw Exception(writeScriptResult);
        }
      } else {
        Loggers.app.info('Script written successfully for ${spi.name}');
      }

      return detectedSystemType;
    } on SSHAuthAbortError catch (e) {
      final err = SSHErr(type: SSHErrType.auth, message: e.toString());
      final newStatus = state.status.copyWith(err: err);
      Loggers.app.warning(err);
      _handleDataError(sid, sessionId, newStatus, closeClient: true);
      return null;
    } on SSHAuthFailError catch (e) {
      final err = SSHErr(type: SSHErrType.auth, message: e.toString());
      final newStatus = state.status.copyWith(err: err);
      Loggers.app.warning(err);
      _handleDataError(sid, sessionId, newStatus, closeClient: true);
      return null;
    } catch (e) {
      final err = SSHErr(type: SSHErrType.writeScript, message: e.toString());
      final newStatus = state.status.copyWith(err: err);
      Loggers.app.warning(err);
      _handleDataError(sid, sessionId, newStatus, closeClient: true);
      return null;
    }
  }

  /// Fetch raw status output from the server. Returns `(raw, segments)` or
  /// null if the phase failed.
  Future<(String, List<String>)?> _fetchStatusPhase(Spi spi, String sid) async {
    final sessionId = 'ssh_${spi.id}';
    try {
      final statusCmd = ShellFunc.status.exec(
        spi.id,
        systemType: state.status.system,
        customDir: spi.custom?.scriptDir,
      );
      String raw;
      if (state.status.system == SystemType.windows) {
        final execResult = await state.client?.run(statusCmd);
        if (execResult != null) {
          raw = SSHDecoder.decode(
            execResult,
            isWindows: true,
            context: 'GetStatus<${spi.name}>',
          );
        } else {
          raw = '';
          Loggers.app.warning('No status result from ${spi.name}');
        }
      } else {
        final shell = await _getPersistentShell();
        final statusTimeoutSeconds = Stores.setting.timeout.fetch();
        final statusTimeout = Duration(
          seconds: statusTimeoutSeconds <= 0 ? 5 : statusTimeoutSeconds,
        );
        final result = await shell.run(statusCmd, timeout: statusTimeout);
        raw = result.output;
      }

      if (raw.isEmpty) {
        final newStatus = state.status.copyWith(
          err: SSHErr(
            type: SSHErrType.segements,
            message: 'Empty response from server',
          ),
        );
        _handleDataError(sid, sessionId, newStatus);
        return null;
      }

      final segments = raw
          .split(ScriptConstants.separator)
          .map((e) => e.trim())
          .toList();
      if (segments.isEmpty) {
        if (Stores.setting.keepStatusWhenErr.fetch()) {
          // Keep previous server status when error occurs
          if (state.conn != ServerConn.failed && state.status.more.isNotEmpty) {
            return null;
          }
        }
        final newStatus = state.status.copyWith(
          err: SSHErr(
            type: SSHErrType.segements,
            message: 'Separate segments failed, raw:\n$raw',
          ),
        );
        _handleDataError(sid, sessionId, newStatus);
        return null;
      }

      return (raw, segments);
    } catch (e) {
      final newStatus = state.status.copyWith(
        err: SSHErr(type: SSHErrType.getStatus, message: e.toString()),
      );
      _handleDataError(sid, sessionId, newStatus);
      Loggers.app.warning('Get status from ${spi.name} failed', e);
      return null;
    }
  }

  /// Parse the raw status output into a [ServerStatus]. Returns true on success.
  Future<bool> _parseStatusPhase(
    Spi spi,
    String sid,
    String raw,
  ) async {
    final sessionId = 'ssh_${spi.id}';
    try {
      // Parse script output into command-specific mappings
      final parsedOutput = ScriptConstants.parseScriptOutput(raw);

      final req = ServerStatusUpdateReq(
        ss: state.status,
        parsedOutput: parsedOutput,
        system: state.status.system,
        customCmds: spi.custom?.cmds ?? {},
        tempDivisor: spi.custom?.tempIsCelsius == true ? 1.0 : 1000.0,
      );
      final newStatus = await Computer.shared.start(
        getStatus,
        req,
        taskName: 'StatusUpdateReq<${spi.id}>',
      );
      updateStatus(newStatus);
      return true;
    } catch (e, trace) {
      final newStatus = state.status.copyWith(
        err: SSHErr(
          type: SSHErrType.getStatus,
          message: 'Parse failed: $e\n\n$raw',
        ),
      );
      _handleDataError(sid, sessionId, newStatus);
      Loggers.app.warning('Server status', e, trace);
      return false;
    }
  }

  Future<void> _getData() async {
    final spi = state.spi;
    final sid = spi.id;

    if (!TryLimiter.canTry(sid)) {
      if (state.conn != ServerConn.failed) {
        updateConnection(ServerConn.failed);
      }
      return;
    }

    updateStatus(state.status.copyWith(err: null));

    if (state.conn < ServerConn.connecting ||
        (state.client?.isClosed ?? true)) {
      updateConnection(ServerConn.connecting);

      final connected = await _connectPhase(spi, sid);
      if (!connected) return;

      updateConnection(ServerConn.connected);

      // Update SSH session status to connected
      final sessionId = 'ssh_${spi.id}';
      TermSessionManager.updateStatus(sessionId, TermSessionStatus.connected);

      final systemType = await _writeScriptPhase(spi, sid);
      if (systemType == null) return;
    }

    if (state.conn == ServerConn.connecting) return;

    // Keep finished status to prevent UI from refreshing to loading state
    if (state.conn != ServerConn.finished) {
      updateConnection(ServerConn.loading);
    }

    final result = await _fetchStatusPhase(spi, sid);
    if (result == null) return;
    final (raw, segments) = result;

    final ok = await _parseStatusPhase(spi, sid, raw);
    if (!ok) return;

    // Transition to finished — server is no longer busy/loading
    updateConnection(ServerConn.finished);
    // Reset retry count only after successful preparation
    TryLimiter.reset(sid);
  }

  Future<PersistentShell> _getPersistentShell() async {
    final client = state.client;
    if (client == null) {
      throw StateError('SSH client is not connected');
    }

    final shell = _persistentShell;
    if (shell != null) {
      return shell;
    }

    final newShell = PersistentShell(client);
    _persistentShell = newShell;
    return newShell;
  }

  Future<void> _disposePersistentShell() async {
    final shell = _persistentShell;
    _persistentShell = null;
    await shell?.close();
  }
}

extension IndividualServerStateExtension on ServerState {
  bool get needGenClient => conn < ServerConn.connecting;

  bool get canViewDetails => conn == ServerConn.finished;

  String get id => spi.id;
}
