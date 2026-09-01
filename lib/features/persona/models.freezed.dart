// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonaSnapshot {

@JsonKey(name: 'snapshot_id') String get snapshotId; int get version; String get status;@JsonKey(name: 'schema_version') String get schemaVersion;@JsonKey(name: 'traits_hash') String get traitsHash;@JsonKey(name: 'source_trait_count') int get sourceTraitCount;@JsonKey(name: 'digest_model') String? get digestModel; String? get error; bool get stale;
/// Create a copy of PersonaSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonaSnapshotCopyWith<PersonaSnapshot> get copyWith => _$PersonaSnapshotCopyWithImpl<PersonaSnapshot>(this as PersonaSnapshot, _$identity);

  /// Serializes this PersonaSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PersonaSnapshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonaSnapshot&&(identical(other.snapshotId, _this.snapshotId) || other.snapshotId == _this.snapshotId)&&(identical(other.version, _this.version) || other.version == _this.version)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.schemaVersion, _this.schemaVersion) || other.schemaVersion == _this.schemaVersion)&&(identical(other.traitsHash, _this.traitsHash) || other.traitsHash == _this.traitsHash)&&(identical(other.sourceTraitCount, _this.sourceTraitCount) || other.sourceTraitCount == _this.sourceTraitCount)&&(identical(other.digestModel, _this.digestModel) || other.digestModel == _this.digestModel)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.stale, _this.stale) || other.stale == _this.stale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PersonaSnapshot;
  return Object.hash(runtimeType,_this.snapshotId,_this.version,_this.status,_this.schemaVersion,_this.traitsHash,_this.sourceTraitCount,_this.digestModel,_this.error,_this.stale);
}

@override
String toString() {
  final _this = this as PersonaSnapshot;
  return 'PersonaSnapshot(snapshotId: ${_this.snapshotId}, version: ${_this.version}, status: ${_this.status}, schemaVersion: ${_this.schemaVersion}, traitsHash: ${_this.traitsHash}, sourceTraitCount: ${_this.sourceTraitCount}, digestModel: ${_this.digestModel}, error: ${_this.error}, stale: ${_this.stale})';
}


}

/// @nodoc
abstract mixin class $PersonaSnapshotCopyWith<$Res>  {
  factory $PersonaSnapshotCopyWith(PersonaSnapshot value, $Res Function(PersonaSnapshot) _then) = _$PersonaSnapshotCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'snapshot_id') String snapshotId, int version, String status,@JsonKey(name: 'schema_version') String schemaVersion,@JsonKey(name: 'traits_hash') String traitsHash,@JsonKey(name: 'source_trait_count') int sourceTraitCount,@JsonKey(name: 'digest_model') String? digestModel, String? error, bool stale
});




}
/// @nodoc
class _$PersonaSnapshotCopyWithImpl<$Res>
    implements $PersonaSnapshotCopyWith<$Res> {
  _$PersonaSnapshotCopyWithImpl(this._self, this._then);

  final PersonaSnapshot _self;
  final $Res Function(PersonaSnapshot) _then;

/// Create a copy of PersonaSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? snapshotId = null,Object? version = null,Object? status = null,Object? schemaVersion = null,Object? traitsHash = null,Object? sourceTraitCount = null,Object? digestModel = freezed,Object? error = freezed,Object? stale = null,}) {
  return _then(PersonaSnapshot(
snapshotId: null == snapshotId ? _self.snapshotId : snapshotId // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as String,traitsHash: null == traitsHash ? _self.traitsHash : traitsHash // ignore: cast_nullable_to_non_nullable
as String,sourceTraitCount: null == sourceTraitCount ? _self.sourceTraitCount : sourceTraitCount // ignore: cast_nullable_to_non_nullable
as int,digestModel: freezed == digestModel ? _self.digestModel : digestModel // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,stale: null == stale ? _self.stale : stale // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonaSnapshot].
extension PersonaSnapshotPatterns on PersonaSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonaSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonaSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonaSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _PersonaSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonaSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _PersonaSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'snapshot_id')  String snapshotId,  int version,  String status, @JsonKey(name: 'schema_version')  String schemaVersion, @JsonKey(name: 'traits_hash')  String traitsHash, @JsonKey(name: 'source_trait_count')  int sourceTraitCount, @JsonKey(name: 'digest_model')  String? digestModel,  String? error,  bool stale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonaSnapshot() when $default != null:
return $default(_that.snapshotId,_that.version,_that.status,_that.schemaVersion,_that.traitsHash,_that.sourceTraitCount,_that.digestModel,_that.error,_that.stale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'snapshot_id')  String snapshotId,  int version,  String status, @JsonKey(name: 'schema_version')  String schemaVersion, @JsonKey(name: 'traits_hash')  String traitsHash, @JsonKey(name: 'source_trait_count')  int sourceTraitCount, @JsonKey(name: 'digest_model')  String? digestModel,  String? error,  bool stale)  $default,) {final _that = this;
switch (_that) {
case _PersonaSnapshot():
return $default(_that.snapshotId,_that.version,_that.status,_that.schemaVersion,_that.traitsHash,_that.sourceTraitCount,_that.digestModel,_that.error,_that.stale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'snapshot_id')  String snapshotId,  int version,  String status, @JsonKey(name: 'schema_version')  String schemaVersion, @JsonKey(name: 'traits_hash')  String traitsHash, @JsonKey(name: 'source_trait_count')  int sourceTraitCount, @JsonKey(name: 'digest_model')  String? digestModel,  String? error,  bool stale)?  $default,) {final _that = this;
switch (_that) {
case _PersonaSnapshot() when $default != null:
return $default(_that.snapshotId,_that.version,_that.status,_that.schemaVersion,_that.traitsHash,_that.sourceTraitCount,_that.digestModel,_that.error,_that.stale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonaSnapshot implements PersonaSnapshot {
  const _PersonaSnapshot({@JsonKey(name: 'snapshot_id') required this.snapshotId, required this.version, required this.status, @JsonKey(name: 'schema_version') required this.schemaVersion, @JsonKey(name: 'traits_hash') required this.traitsHash, @JsonKey(name: 'source_trait_count') required this.sourceTraitCount, @JsonKey(name: 'digest_model') this.digestModel, this.error, this.stale = false});
  factory _PersonaSnapshot.fromJson(Map<String, dynamic> json) => _$PersonaSnapshotFromJson(json);

@override@JsonKey(name: 'snapshot_id') final  String snapshotId;
@override final  int version;
@override final  String status;
@override@JsonKey(name: 'schema_version') final  String schemaVersion;
@override@JsonKey(name: 'traits_hash') final  String traitsHash;
@override@JsonKey(name: 'source_trait_count') final  int sourceTraitCount;
@override@JsonKey(name: 'digest_model') final  String? digestModel;
@override final  String? error;
@override@JsonKey() final  bool stale;

/// Create a copy of PersonaSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonaSnapshotCopyWith<_PersonaSnapshot> get copyWith => __$PersonaSnapshotCopyWithImpl<_PersonaSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonaSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonaSnapshot&&(identical(other.snapshotId, snapshotId) || other.snapshotId == snapshotId)&&(identical(other.version, version) || other.version == version)&&(identical(other.status, status) || other.status == status)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.traitsHash, traitsHash) || other.traitsHash == traitsHash)&&(identical(other.sourceTraitCount, sourceTraitCount) || other.sourceTraitCount == sourceTraitCount)&&(identical(other.digestModel, digestModel) || other.digestModel == digestModel)&&(identical(other.error, error) || other.error == error)&&(identical(other.stale, stale) || other.stale == stale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,snapshotId,version,status,schemaVersion,traitsHash,sourceTraitCount,digestModel,error,stale);
}

@override
String toString() {
    return 'PersonaSnapshot(snapshotId: $snapshotId, version: $version, status: $status, schemaVersion: $schemaVersion, traitsHash: $traitsHash, sourceTraitCount: $sourceTraitCount, digestModel: $digestModel, error: $error, stale: $stale)';
}


}

/// @nodoc
abstract mixin class _$PersonaSnapshotCopyWith<$Res> implements $PersonaSnapshotCopyWith<$Res> {
  factory _$PersonaSnapshotCopyWith(_PersonaSnapshot value, $Res Function(_PersonaSnapshot) _then) = __$PersonaSnapshotCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'snapshot_id') String snapshotId, int version, String status,@JsonKey(name: 'schema_version') String schemaVersion,@JsonKey(name: 'traits_hash') String traitsHash,@JsonKey(name: 'source_trait_count') int sourceTraitCount,@JsonKey(name: 'digest_model') String? digestModel, String? error, bool stale
});




}
/// @nodoc
class __$PersonaSnapshotCopyWithImpl<$Res>
    implements _$PersonaSnapshotCopyWith<$Res> {
  __$PersonaSnapshotCopyWithImpl(this._self, this._then);

  final _PersonaSnapshot _self;
  final $Res Function(_PersonaSnapshot) _then;

/// Create a copy of PersonaSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? snapshotId = null,Object? version = null,Object? status = null,Object? schemaVersion = null,Object? traitsHash = null,Object? sourceTraitCount = null,Object? digestModel = freezed,Object? error = freezed,Object? stale = null,}) {
  return _then(_PersonaSnapshot(
snapshotId: null == snapshotId ? _self.snapshotId : snapshotId // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as String,traitsHash: null == traitsHash ? _self.traitsHash : traitsHash // ignore: cast_nullable_to_non_nullable
as String,sourceTraitCount: null == sourceTraitCount ? _self.sourceTraitCount : sourceTraitCount // ignore: cast_nullable_to_non_nullable
as int,digestModel: freezed == digestModel ? _self.digestModel : digestModel // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,stale: null == stale ? _self.stale : stale // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PersonaState {

 PersonaSnapshot? get snapshot; bool get simulatable;
/// Create a copy of PersonaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonaStateCopyWith<PersonaState> get copyWith => _$PersonaStateCopyWithImpl<PersonaState>(this as PersonaState, _$identity);

  /// Serializes this PersonaState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PersonaState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonaState&&(identical(other.snapshot, _this.snapshot) || other.snapshot == _this.snapshot)&&(identical(other.simulatable, _this.simulatable) || other.simulatable == _this.simulatable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PersonaState;
  return Object.hash(runtimeType,_this.snapshot,_this.simulatable);
}

@override
String toString() {
  final _this = this as PersonaState;
  return 'PersonaState(snapshot: ${_this.snapshot}, simulatable: ${_this.simulatable})';
}


}

/// @nodoc
abstract mixin class $PersonaStateCopyWith<$Res>  {
  factory $PersonaStateCopyWith(PersonaState value, $Res Function(PersonaState) _then) = _$PersonaStateCopyWithImpl;
@useResult
$Res call({
 PersonaSnapshot? snapshot, bool simulatable
});


$PersonaSnapshotCopyWith<$Res>? get snapshot;

}
/// @nodoc
class _$PersonaStateCopyWithImpl<$Res>
    implements $PersonaStateCopyWith<$Res> {
  _$PersonaStateCopyWithImpl(this._self, this._then);

  final PersonaState _self;
  final $Res Function(PersonaState) _then;

/// Create a copy of PersonaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? snapshot = freezed,Object? simulatable = null,}) {
  return _then(PersonaState(
snapshot: freezed == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as PersonaSnapshot?,simulatable: null == simulatable ? _self.simulatable : simulatable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PersonaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonaSnapshotCopyWith<$Res>? get snapshot {
    if (_self.snapshot == null) {
    return null;
  }

  return $PersonaSnapshotCopyWith<$Res>(_self.snapshot!, (value) {
    return _then(_self.copyWith(snapshot: value));
  });
}
}


/// Adds pattern-matching-related methods to [PersonaState].
extension PersonaStatePatterns on PersonaState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonaState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonaState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonaState value)  $default,){
final _that = this;
switch (_that) {
case _PersonaState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonaState value)?  $default,){
final _that = this;
switch (_that) {
case _PersonaState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PersonaSnapshot? snapshot,  bool simulatable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonaState() when $default != null:
return $default(_that.snapshot,_that.simulatable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PersonaSnapshot? snapshot,  bool simulatable)  $default,) {final _that = this;
switch (_that) {
case _PersonaState():
return $default(_that.snapshot,_that.simulatable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PersonaSnapshot? snapshot,  bool simulatable)?  $default,) {final _that = this;
switch (_that) {
case _PersonaState() when $default != null:
return $default(_that.snapshot,_that.simulatable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonaState implements PersonaState {
  const _PersonaState({this.snapshot, required this.simulatable});
  factory _PersonaState.fromJson(Map<String, dynamic> json) => _$PersonaStateFromJson(json);

@override final  PersonaSnapshot? snapshot;
@override final  bool simulatable;

/// Create a copy of PersonaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonaStateCopyWith<_PersonaState> get copyWith => __$PersonaStateCopyWithImpl<_PersonaState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonaStateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonaState&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot)&&(identical(other.simulatable, simulatable) || other.simulatable == simulatable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,snapshot,simulatable);
}

@override
String toString() {
    return 'PersonaState(snapshot: $snapshot, simulatable: $simulatable)';
}


}

/// @nodoc
abstract mixin class _$PersonaStateCopyWith<$Res> implements $PersonaStateCopyWith<$Res> {
  factory _$PersonaStateCopyWith(_PersonaState value, $Res Function(_PersonaState) _then) = __$PersonaStateCopyWithImpl;
@override @useResult
$Res call({
 PersonaSnapshot? snapshot, bool simulatable
});


@override $PersonaSnapshotCopyWith<$Res>? get snapshot;

}
/// @nodoc
class __$PersonaStateCopyWithImpl<$Res>
    implements _$PersonaStateCopyWith<$Res> {
  __$PersonaStateCopyWithImpl(this._self, this._then);

  final _PersonaState _self;
  final $Res Function(_PersonaState) _then;

/// Create a copy of PersonaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? snapshot = freezed,Object? simulatable = null,}) {
  return _then(_PersonaState(
snapshot: freezed == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as PersonaSnapshot?,simulatable: null == simulatable ? _self.simulatable : simulatable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PersonaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonaSnapshotCopyWith<$Res>? get snapshot {
    if (_self.snapshot == null) {
    return null;
  }

  return $PersonaSnapshotCopyWith<$Res>(_self.snapshot!, (value) {
    return _then(_self.copyWith(snapshot: value));
  });
}
}

// dart format on
