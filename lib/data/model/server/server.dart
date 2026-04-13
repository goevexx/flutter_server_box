import 'package:fl_lib/fl_lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:server_box/data/model/app/scripts/cmd_types.dart';
import 'package:server_box/data/model/server/amd.dart';
import 'package:server_box/data/model/server/battery.dart';
import 'package:server_box/data/model/server/conn.dart';
import 'package:server_box/data/model/server/cpu.dart';
import 'package:server_box/data/model/server/disk.dart';
import 'package:server_box/data/model/server/disk_smart.dart';
import 'package:server_box/data/model/server/memory.dart';
import 'package:server_box/data/model/server/net_speed.dart';
import 'package:server_box/data/model/server/nvdia.dart';
import 'package:server_box/data/model/server/sensors.dart';
import 'package:server_box/data/model/server/system.dart';
import 'package:server_box/data/model/server/temp.dart';

part 'server.freezed.dart';

@freezed
abstract class ServerStatus with _$ServerStatus {
  const ServerStatus._();

  const factory ServerStatus({
    required Cpus cpu,
    required Memory mem,
    required Swap swap,
    required List<Disk> disk,
    required Conn tcp,
    required NetSpeed netSpeed,
    required Temperatures temps,
    required SystemType system,
    required DiskIO diskIO,
    @Default([]) List<DiskSmart> diskSmart,
    Err? err,
    List<NvidiaSmiItem>? nvidia,
    List<AmdSmiItem>? amd,
    DiskUsage? diskUsage,
    @Default([]) List<Battery> batteries,
    @Default(<StatusCmdType, String>{}) Map<StatusCmdType, String> more,
    @Default([]) List<SensorItem> sensors,
    @Default(<String, String>{}) Map<String, String> customCmds,
  }) = _ServerStatus;
}

enum ServerConn {
  failed,
  disconnected,
  connecting,

  /// Connected to server
  connected,

  /// Status parsing
  loading,

  /// Status parsing finished
  finished;

  bool operator <(ServerConn other) => index < other.index;
}
