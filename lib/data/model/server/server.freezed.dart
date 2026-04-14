// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServerStatus {

 Cpus get cpu; Memory get mem; Swap get swap; List<Disk> get disk; Conn get tcp; NetSpeed get netSpeed; Temperatures get temps; SystemType get system; DiskIO get diskIO; List<DiskSmart> get diskSmart; Err? get err; List<NvidiaSmiItem>? get nvidia; List<AmdSmiItem>? get amd; DiskUsage? get diskUsage; List<Battery> get batteries; Map<StatusCmdType, String> get more; List<SensorItem> get sensors; Map<String, String> get customCmds;
/// Create a copy of ServerStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerStatusCopyWith<ServerStatus> get copyWith => _$ServerStatusCopyWithImpl<ServerStatus>(this as ServerStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerStatus&&const DeepCollectionEquality().equals(other.cpu, cpu)&&(identical(other.mem, mem) || other.mem == mem)&&(identical(other.swap, swap) || other.swap == swap)&&const DeepCollectionEquality().equals(other.disk, disk)&&(identical(other.tcp, tcp) || other.tcp == tcp)&&const DeepCollectionEquality().equals(other.netSpeed, netSpeed)&&(identical(other.temps, temps) || other.temps == temps)&&(identical(other.system, system) || other.system == system)&&const DeepCollectionEquality().equals(other.diskIO, diskIO)&&const DeepCollectionEquality().equals(other.diskSmart, diskSmart)&&(identical(other.err, err) || other.err == err)&&const DeepCollectionEquality().equals(other.nvidia, nvidia)&&const DeepCollectionEquality().equals(other.amd, amd)&&(identical(other.diskUsage, diskUsage) || other.diskUsage == diskUsage)&&const DeepCollectionEquality().equals(other.batteries, batteries)&&const DeepCollectionEquality().equals(other.more, more)&&const DeepCollectionEquality().equals(other.sensors, sensors)&&const DeepCollectionEquality().equals(other.customCmds, customCmds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cpu),mem,swap,const DeepCollectionEquality().hash(disk),tcp,const DeepCollectionEquality().hash(netSpeed),temps,system,const DeepCollectionEquality().hash(diskIO),const DeepCollectionEquality().hash(diskSmart),err,const DeepCollectionEquality().hash(nvidia),const DeepCollectionEquality().hash(amd),diskUsage,const DeepCollectionEquality().hash(batteries),const DeepCollectionEquality().hash(more),const DeepCollectionEquality().hash(sensors),const DeepCollectionEquality().hash(customCmds));

@override
String toString() {
  return 'ServerStatus(cpu: $cpu, mem: $mem, swap: $swap, disk: $disk, tcp: $tcp, netSpeed: $netSpeed, temps: $temps, system: $system, diskIO: $diskIO, diskSmart: $diskSmart, err: $err, nvidia: $nvidia, amd: $amd, diskUsage: $diskUsage, batteries: $batteries, more: $more, sensors: $sensors, customCmds: $customCmds)';
}


}

/// @nodoc
abstract mixin class $ServerStatusCopyWith<$Res>  {
  factory $ServerStatusCopyWith(ServerStatus value, $Res Function(ServerStatus) _then) = _$ServerStatusCopyWithImpl;
@useResult
$Res call({
 Cpus cpu, Memory mem, Swap swap, List<Disk> disk, Conn tcp, NetSpeed netSpeed, Temperatures temps, SystemType system, DiskIO diskIO, List<DiskSmart> diskSmart, Err? err, List<NvidiaSmiItem>? nvidia, List<AmdSmiItem>? amd, DiskUsage? diskUsage, List<Battery> batteries, Map<StatusCmdType, String> more, List<SensorItem> sensors, Map<String, String> customCmds
});




}
/// @nodoc
class _$ServerStatusCopyWithImpl<$Res>
    implements $ServerStatusCopyWith<$Res> {
  _$ServerStatusCopyWithImpl(this._self, this._then);

  final ServerStatus _self;
  final $Res Function(ServerStatus) _then;

/// Create a copy of ServerStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cpu = null,Object? mem = null,Object? swap = null,Object? disk = null,Object? tcp = null,Object? netSpeed = null,Object? temps = null,Object? system = null,Object? diskIO = null,Object? diskSmart = null,Object? err = freezed,Object? nvidia = freezed,Object? amd = freezed,Object? diskUsage = freezed,Object? batteries = null,Object? more = null,Object? sensors = null,Object? customCmds = null,}) {
  return _then(_self.copyWith(
cpu: null == cpu ? _self.cpu : cpu // ignore: cast_nullable_to_non_nullable
as Cpus,mem: null == mem ? _self.mem : mem // ignore: cast_nullable_to_non_nullable
as Memory,swap: null == swap ? _self.swap : swap // ignore: cast_nullable_to_non_nullable
as Swap,disk: null == disk ? _self.disk : disk // ignore: cast_nullable_to_non_nullable
as List<Disk>,tcp: null == tcp ? _self.tcp : tcp // ignore: cast_nullable_to_non_nullable
as Conn,netSpeed: null == netSpeed ? _self.netSpeed : netSpeed // ignore: cast_nullable_to_non_nullable
as NetSpeed,temps: null == temps ? _self.temps : temps // ignore: cast_nullable_to_non_nullable
as Temperatures,system: null == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as SystemType,diskIO: null == diskIO ? _self.diskIO : diskIO // ignore: cast_nullable_to_non_nullable
as DiskIO,diskSmart: null == diskSmart ? _self.diskSmart : diskSmart // ignore: cast_nullable_to_non_nullable
as List<DiskSmart>,err: freezed == err ? _self.err : err // ignore: cast_nullable_to_non_nullable
as Err?,nvidia: freezed == nvidia ? _self.nvidia : nvidia // ignore: cast_nullable_to_non_nullable
as List<NvidiaSmiItem>?,amd: freezed == amd ? _self.amd : amd // ignore: cast_nullable_to_non_nullable
as List<AmdSmiItem>?,diskUsage: freezed == diskUsage ? _self.diskUsage : diskUsage // ignore: cast_nullable_to_non_nullable
as DiskUsage?,batteries: null == batteries ? _self.batteries : batteries // ignore: cast_nullable_to_non_nullable
as List<Battery>,more: null == more ? _self.more : more // ignore: cast_nullable_to_non_nullable
as Map<StatusCmdType, String>,sensors: null == sensors ? _self.sensors : sensors // ignore: cast_nullable_to_non_nullable
as List<SensorItem>,customCmds: null == customCmds ? _self.customCmds : customCmds // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerStatus].
extension ServerStatusPatterns on ServerStatus {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerStatus() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerStatus value)  $default,){
final _that = this;
switch (_that) {
case _ServerStatus():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerStatus value)?  $default,){
final _that = this;
switch (_that) {
case _ServerStatus() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Cpus cpu,  Memory mem,  Swap swap,  List<Disk> disk,  Conn tcp,  NetSpeed netSpeed,  Temperatures temps,  SystemType system,  DiskIO diskIO,  List<DiskSmart> diskSmart,  Err? err,  List<NvidiaSmiItem>? nvidia,  List<AmdSmiItem>? amd,  DiskUsage? diskUsage,  List<Battery> batteries,  Map<StatusCmdType, String> more,  List<SensorItem> sensors,  Map<String, String> customCmds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerStatus() when $default != null:
return $default(_that.cpu,_that.mem,_that.swap,_that.disk,_that.tcp,_that.netSpeed,_that.temps,_that.system,_that.diskIO,_that.diskSmart,_that.err,_that.nvidia,_that.amd,_that.diskUsage,_that.batteries,_that.more,_that.sensors,_that.customCmds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Cpus cpu,  Memory mem,  Swap swap,  List<Disk> disk,  Conn tcp,  NetSpeed netSpeed,  Temperatures temps,  SystemType system,  DiskIO diskIO,  List<DiskSmart> diskSmart,  Err? err,  List<NvidiaSmiItem>? nvidia,  List<AmdSmiItem>? amd,  DiskUsage? diskUsage,  List<Battery> batteries,  Map<StatusCmdType, String> more,  List<SensorItem> sensors,  Map<String, String> customCmds)  $default,) {final _that = this;
switch (_that) {
case _ServerStatus():
return $default(_that.cpu,_that.mem,_that.swap,_that.disk,_that.tcp,_that.netSpeed,_that.temps,_that.system,_that.diskIO,_that.diskSmart,_that.err,_that.nvidia,_that.amd,_that.diskUsage,_that.batteries,_that.more,_that.sensors,_that.customCmds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Cpus cpu,  Memory mem,  Swap swap,  List<Disk> disk,  Conn tcp,  NetSpeed netSpeed,  Temperatures temps,  SystemType system,  DiskIO diskIO,  List<DiskSmart> diskSmart,  Err? err,  List<NvidiaSmiItem>? nvidia,  List<AmdSmiItem>? amd,  DiskUsage? diskUsage,  List<Battery> batteries,  Map<StatusCmdType, String> more,  List<SensorItem> sensors,  Map<String, String> customCmds)?  $default,) {final _that = this;
switch (_that) {
case _ServerStatus() when $default != null:
return $default(_that.cpu,_that.mem,_that.swap,_that.disk,_that.tcp,_that.netSpeed,_that.temps,_that.system,_that.diskIO,_that.diskSmart,_that.err,_that.nvidia,_that.amd,_that.diskUsage,_that.batteries,_that.more,_that.sensors,_that.customCmds);case _:
  return null;

}
}

}

/// @nodoc


class _ServerStatus extends ServerStatus {
  const _ServerStatus({required this.cpu, required this.mem, required this.swap, required final  List<Disk> disk, required this.tcp, required this.netSpeed, required this.temps, required this.system, required this.diskIO, final  List<DiskSmart> diskSmart = const [], this.err, final  List<NvidiaSmiItem>? nvidia, final  List<AmdSmiItem>? amd, this.diskUsage, final  List<Battery> batteries = const [], final  Map<StatusCmdType, String> more = const <StatusCmdType, String>{}, final  List<SensorItem> sensors = const [], final  Map<String, String> customCmds = const <String, String>{}}): _disk = disk,_diskSmart = diskSmart,_nvidia = nvidia,_amd = amd,_batteries = batteries,_more = more,_sensors = sensors,_customCmds = customCmds,super._();
  

@override final  Cpus cpu;
@override final  Memory mem;
@override final  Swap swap;
 final  List<Disk> _disk;
@override List<Disk> get disk {
  if (_disk is EqualUnmodifiableListView) return _disk;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_disk);
}

@override final  Conn tcp;
@override final  NetSpeed netSpeed;
@override final  Temperatures temps;
@override final  SystemType system;
@override final  DiskIO diskIO;
 final  List<DiskSmart> _diskSmart;
@override@JsonKey() List<DiskSmart> get diskSmart {
  if (_diskSmart is EqualUnmodifiableListView) return _diskSmart;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_diskSmart);
}

@override final  Err? err;
 final  List<NvidiaSmiItem>? _nvidia;
@override List<NvidiaSmiItem>? get nvidia {
  final value = _nvidia;
  if (value == null) return null;
  if (_nvidia is EqualUnmodifiableListView) return _nvidia;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<AmdSmiItem>? _amd;
@override List<AmdSmiItem>? get amd {
  final value = _amd;
  if (value == null) return null;
  if (_amd is EqualUnmodifiableListView) return _amd;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DiskUsage? diskUsage;
 final  List<Battery> _batteries;
@override@JsonKey() List<Battery> get batteries {
  if (_batteries is EqualUnmodifiableListView) return _batteries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_batteries);
}

 final  Map<StatusCmdType, String> _more;
@override@JsonKey() Map<StatusCmdType, String> get more {
  if (_more is EqualUnmodifiableMapView) return _more;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_more);
}

 final  List<SensorItem> _sensors;
@override@JsonKey() List<SensorItem> get sensors {
  if (_sensors is EqualUnmodifiableListView) return _sensors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sensors);
}

 final  Map<String, String> _customCmds;
@override@JsonKey() Map<String, String> get customCmds {
  if (_customCmds is EqualUnmodifiableMapView) return _customCmds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_customCmds);
}


/// Create a copy of ServerStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerStatusCopyWith<_ServerStatus> get copyWith => __$ServerStatusCopyWithImpl<_ServerStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerStatus&&const DeepCollectionEquality().equals(other.cpu, cpu)&&(identical(other.mem, mem) || other.mem == mem)&&(identical(other.swap, swap) || other.swap == swap)&&const DeepCollectionEquality().equals(other._disk, _disk)&&(identical(other.tcp, tcp) || other.tcp == tcp)&&const DeepCollectionEquality().equals(other.netSpeed, netSpeed)&&(identical(other.temps, temps) || other.temps == temps)&&(identical(other.system, system) || other.system == system)&&const DeepCollectionEquality().equals(other.diskIO, diskIO)&&const DeepCollectionEquality().equals(other._diskSmart, _diskSmart)&&(identical(other.err, err) || other.err == err)&&const DeepCollectionEquality().equals(other._nvidia, _nvidia)&&const DeepCollectionEquality().equals(other._amd, _amd)&&(identical(other.diskUsage, diskUsage) || other.diskUsage == diskUsage)&&const DeepCollectionEquality().equals(other._batteries, _batteries)&&const DeepCollectionEquality().equals(other._more, _more)&&const DeepCollectionEquality().equals(other._sensors, _sensors)&&const DeepCollectionEquality().equals(other._customCmds, _customCmds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cpu),mem,swap,const DeepCollectionEquality().hash(_disk),tcp,const DeepCollectionEquality().hash(netSpeed),temps,system,const DeepCollectionEquality().hash(diskIO),const DeepCollectionEquality().hash(_diskSmart),err,const DeepCollectionEquality().hash(_nvidia),const DeepCollectionEquality().hash(_amd),diskUsage,const DeepCollectionEquality().hash(_batteries),const DeepCollectionEquality().hash(_more),const DeepCollectionEquality().hash(_sensors),const DeepCollectionEquality().hash(_customCmds));

@override
String toString() {
  return 'ServerStatus(cpu: $cpu, mem: $mem, swap: $swap, disk: $disk, tcp: $tcp, netSpeed: $netSpeed, temps: $temps, system: $system, diskIO: $diskIO, diskSmart: $diskSmart, err: $err, nvidia: $nvidia, amd: $amd, diskUsage: $diskUsage, batteries: $batteries, more: $more, sensors: $sensors, customCmds: $customCmds)';
}


}

/// @nodoc
abstract mixin class _$ServerStatusCopyWith<$Res> implements $ServerStatusCopyWith<$Res> {
  factory _$ServerStatusCopyWith(_ServerStatus value, $Res Function(_ServerStatus) _then) = __$ServerStatusCopyWithImpl;
@override @useResult
$Res call({
 Cpus cpu, Memory mem, Swap swap, List<Disk> disk, Conn tcp, NetSpeed netSpeed, Temperatures temps, SystemType system, DiskIO diskIO, List<DiskSmart> diskSmart, Err? err, List<NvidiaSmiItem>? nvidia, List<AmdSmiItem>? amd, DiskUsage? diskUsage, List<Battery> batteries, Map<StatusCmdType, String> more, List<SensorItem> sensors, Map<String, String> customCmds
});




}
/// @nodoc
class __$ServerStatusCopyWithImpl<$Res>
    implements _$ServerStatusCopyWith<$Res> {
  __$ServerStatusCopyWithImpl(this._self, this._then);

  final _ServerStatus _self;
  final $Res Function(_ServerStatus) _then;

/// Create a copy of ServerStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cpu = null,Object? mem = null,Object? swap = null,Object? disk = null,Object? tcp = null,Object? netSpeed = null,Object? temps = null,Object? system = null,Object? diskIO = null,Object? diskSmart = null,Object? err = freezed,Object? nvidia = freezed,Object? amd = freezed,Object? diskUsage = freezed,Object? batteries = null,Object? more = null,Object? sensors = null,Object? customCmds = null,}) {
  return _then(_ServerStatus(
cpu: null == cpu ? _self.cpu : cpu // ignore: cast_nullable_to_non_nullable
as Cpus,mem: null == mem ? _self.mem : mem // ignore: cast_nullable_to_non_nullable
as Memory,swap: null == swap ? _self.swap : swap // ignore: cast_nullable_to_non_nullable
as Swap,disk: null == disk ? _self._disk : disk // ignore: cast_nullable_to_non_nullable
as List<Disk>,tcp: null == tcp ? _self.tcp : tcp // ignore: cast_nullable_to_non_nullable
as Conn,netSpeed: null == netSpeed ? _self.netSpeed : netSpeed // ignore: cast_nullable_to_non_nullable
as NetSpeed,temps: null == temps ? _self.temps : temps // ignore: cast_nullable_to_non_nullable
as Temperatures,system: null == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as SystemType,diskIO: null == diskIO ? _self.diskIO : diskIO // ignore: cast_nullable_to_non_nullable
as DiskIO,diskSmart: null == diskSmart ? _self._diskSmart : diskSmart // ignore: cast_nullable_to_non_nullable
as List<DiskSmart>,err: freezed == err ? _self.err : err // ignore: cast_nullable_to_non_nullable
as Err?,nvidia: freezed == nvidia ? _self._nvidia : nvidia // ignore: cast_nullable_to_non_nullable
as List<NvidiaSmiItem>?,amd: freezed == amd ? _self._amd : amd // ignore: cast_nullable_to_non_nullable
as List<AmdSmiItem>?,diskUsage: freezed == diskUsage ? _self.diskUsage : diskUsage // ignore: cast_nullable_to_non_nullable
as DiskUsage?,batteries: null == batteries ? _self._batteries : batteries // ignore: cast_nullable_to_non_nullable
as List<Battery>,more: null == more ? _self._more : more // ignore: cast_nullable_to_non_nullable
as Map<StatusCmdType, String>,sensors: null == sensors ? _self._sensors : sensors // ignore: cast_nullable_to_non_nullable
as List<SensorItem>,customCmds: null == customCmds ? _self._customCmds : customCmds // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
