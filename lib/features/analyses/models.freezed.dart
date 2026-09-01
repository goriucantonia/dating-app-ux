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
mixin _$Candidate {

@JsonKey(name: 'candidate_user_id') String get candidateUserId;@JsonKey(name: 'display_name') String get displayName; int get age;@JsonKey(name: 'is_demo') bool get isDemo;@JsonKey(name: 'trait_labels') Map<String, List<String>> get traitLabels; int get rank;@JsonKey(name: 'fit_forward') double get fitForward;@JsonKey(name: 'fit_backward') double get fitBackward; double get compatibility;@JsonKey(name: 'shared_interests') List<String> get sharedInterests;@JsonKey(name: 'reason_summary') String get reasonSummary;@JsonKey(name: 'snapshot_id') String get snapshotId;
/// Create a copy of Candidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateCopyWith<Candidate> get copyWith => _$CandidateCopyWithImpl<Candidate>(this as Candidate, _$identity);

  /// Serializes this Candidate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Candidate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Candidate&&(identical(other.candidateUserId, _this.candidateUserId) || other.candidateUserId == _this.candidateUserId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.age, _this.age) || other.age == _this.age)&&(identical(other.isDemo, _this.isDemo) || other.isDemo == _this.isDemo)&&const DeepCollectionEquality().equals(other.traitLabels, _this.traitLabels)&&(identical(other.rank, _this.rank) || other.rank == _this.rank)&&(identical(other.fitForward, _this.fitForward) || other.fitForward == _this.fitForward)&&(identical(other.fitBackward, _this.fitBackward) || other.fitBackward == _this.fitBackward)&&(identical(other.compatibility, _this.compatibility) || other.compatibility == _this.compatibility)&&const DeepCollectionEquality().equals(other.sharedInterests, _this.sharedInterests)&&(identical(other.reasonSummary, _this.reasonSummary) || other.reasonSummary == _this.reasonSummary)&&(identical(other.snapshotId, _this.snapshotId) || other.snapshotId == _this.snapshotId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Candidate;
  return Object.hash(runtimeType,_this.candidateUserId,_this.displayName,_this.age,_this.isDemo,const DeepCollectionEquality().hash(_this.traitLabels),_this.rank,_this.fitForward,_this.fitBackward,_this.compatibility,const DeepCollectionEquality().hash(_this.sharedInterests),_this.reasonSummary,_this.snapshotId);
}

@override
String toString() {
  final _this = this as Candidate;
  return 'Candidate(candidateUserId: ${_this.candidateUserId}, displayName: ${_this.displayName}, age: ${_this.age}, isDemo: ${_this.isDemo}, traitLabels: ${_this.traitLabels}, rank: ${_this.rank}, fitForward: ${_this.fitForward}, fitBackward: ${_this.fitBackward}, compatibility: ${_this.compatibility}, sharedInterests: ${_this.sharedInterests}, reasonSummary: ${_this.reasonSummary}, snapshotId: ${_this.snapshotId})';
}


}

/// @nodoc
abstract mixin class $CandidateCopyWith<$Res>  {
  factory $CandidateCopyWith(Candidate value, $Res Function(Candidate) _then) = _$CandidateCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'candidate_user_id') String candidateUserId,@JsonKey(name: 'display_name') String displayName, int age,@JsonKey(name: 'is_demo') bool isDemo,@JsonKey(name: 'trait_labels') Map<String, List<String>> traitLabels, int rank,@JsonKey(name: 'fit_forward') double fitForward,@JsonKey(name: 'fit_backward') double fitBackward, double compatibility,@JsonKey(name: 'shared_interests') List<String> sharedInterests,@JsonKey(name: 'reason_summary') String reasonSummary,@JsonKey(name: 'snapshot_id') String snapshotId
});




}
/// @nodoc
class _$CandidateCopyWithImpl<$Res>
    implements $CandidateCopyWith<$Res> {
  _$CandidateCopyWithImpl(this._self, this._then);

  final Candidate _self;
  final $Res Function(Candidate) _then;

/// Create a copy of Candidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? candidateUserId = null,Object? displayName = null,Object? age = null,Object? isDemo = null,Object? traitLabels = null,Object? rank = null,Object? fitForward = null,Object? fitBackward = null,Object? compatibility = null,Object? sharedInterests = null,Object? reasonSummary = null,Object? snapshotId = null,}) {
  return _then(Candidate(
candidateUserId: null == candidateUserId ? _self.candidateUserId : candidateUserId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,isDemo: null == isDemo ? _self.isDemo : isDemo // ignore: cast_nullable_to_non_nullable
as bool,traitLabels: null == traitLabels ? _self.traitLabels : traitLabels // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,fitForward: null == fitForward ? _self.fitForward : fitForward // ignore: cast_nullable_to_non_nullable
as double,fitBackward: null == fitBackward ? _self.fitBackward : fitBackward // ignore: cast_nullable_to_non_nullable
as double,compatibility: null == compatibility ? _self.compatibility : compatibility // ignore: cast_nullable_to_non_nullable
as double,sharedInterests: null == sharedInterests ? _self.sharedInterests : sharedInterests // ignore: cast_nullable_to_non_nullable
as List<String>,reasonSummary: null == reasonSummary ? _self.reasonSummary : reasonSummary // ignore: cast_nullable_to_non_nullable
as String,snapshotId: null == snapshotId ? _self.snapshotId : snapshotId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Candidate].
extension CandidatePatterns on Candidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Candidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Candidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Candidate value)  $default,){
final _that = this;
switch (_that) {
case _Candidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Candidate value)?  $default,){
final _that = this;
switch (_that) {
case _Candidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'candidate_user_id')  String candidateUserId, @JsonKey(name: 'display_name')  String displayName,  int age, @JsonKey(name: 'is_demo')  bool isDemo, @JsonKey(name: 'trait_labels')  Map<String, List<String>> traitLabels,  int rank, @JsonKey(name: 'fit_forward')  double fitForward, @JsonKey(name: 'fit_backward')  double fitBackward,  double compatibility, @JsonKey(name: 'shared_interests')  List<String> sharedInterests, @JsonKey(name: 'reason_summary')  String reasonSummary, @JsonKey(name: 'snapshot_id')  String snapshotId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Candidate() when $default != null:
return $default(_that.candidateUserId,_that.displayName,_that.age,_that.isDemo,_that.traitLabels,_that.rank,_that.fitForward,_that.fitBackward,_that.compatibility,_that.sharedInterests,_that.reasonSummary,_that.snapshotId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'candidate_user_id')  String candidateUserId, @JsonKey(name: 'display_name')  String displayName,  int age, @JsonKey(name: 'is_demo')  bool isDemo, @JsonKey(name: 'trait_labels')  Map<String, List<String>> traitLabels,  int rank, @JsonKey(name: 'fit_forward')  double fitForward, @JsonKey(name: 'fit_backward')  double fitBackward,  double compatibility, @JsonKey(name: 'shared_interests')  List<String> sharedInterests, @JsonKey(name: 'reason_summary')  String reasonSummary, @JsonKey(name: 'snapshot_id')  String snapshotId)  $default,) {final _that = this;
switch (_that) {
case _Candidate():
return $default(_that.candidateUserId,_that.displayName,_that.age,_that.isDemo,_that.traitLabels,_that.rank,_that.fitForward,_that.fitBackward,_that.compatibility,_that.sharedInterests,_that.reasonSummary,_that.snapshotId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'candidate_user_id')  String candidateUserId, @JsonKey(name: 'display_name')  String displayName,  int age, @JsonKey(name: 'is_demo')  bool isDemo, @JsonKey(name: 'trait_labels')  Map<String, List<String>> traitLabels,  int rank, @JsonKey(name: 'fit_forward')  double fitForward, @JsonKey(name: 'fit_backward')  double fitBackward,  double compatibility, @JsonKey(name: 'shared_interests')  List<String> sharedInterests, @JsonKey(name: 'reason_summary')  String reasonSummary, @JsonKey(name: 'snapshot_id')  String snapshotId)?  $default,) {final _that = this;
switch (_that) {
case _Candidate() when $default != null:
return $default(_that.candidateUserId,_that.displayName,_that.age,_that.isDemo,_that.traitLabels,_that.rank,_that.fitForward,_that.fitBackward,_that.compatibility,_that.sharedInterests,_that.reasonSummary,_that.snapshotId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Candidate implements Candidate {
  const _Candidate({@JsonKey(name: 'candidate_user_id') required this.candidateUserId, @JsonKey(name: 'display_name') required this.displayName, required this.age, @JsonKey(name: 'is_demo') required this.isDemo, @JsonKey(name: 'trait_labels') required  Map<String, List<String>> traitLabels, required this.rank, @JsonKey(name: 'fit_forward') required this.fitForward, @JsonKey(name: 'fit_backward') required this.fitBackward, required this.compatibility, @JsonKey(name: 'shared_interests') required  List<String> sharedInterests, @JsonKey(name: 'reason_summary') required this.reasonSummary, @JsonKey(name: 'snapshot_id') required this.snapshotId}): _traitLabels = traitLabels,_sharedInterests = sharedInterests;
  factory _Candidate.fromJson(Map<String, dynamic> json) => _$CandidateFromJson(json);

@override@JsonKey(name: 'candidate_user_id') final  String candidateUserId;
@override@JsonKey(name: 'display_name') final  String displayName;
@override final  int age;
@override@JsonKey(name: 'is_demo') final  bool isDemo;
 final  Map<String, List<String>> _traitLabels;
@override@JsonKey(name: 'trait_labels') Map<String, List<String>> get traitLabels {
  if (_traitLabels is EqualUnmodifiableMapView) return _traitLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_traitLabels);
}

@override final  int rank;
@override@JsonKey(name: 'fit_forward') final  double fitForward;
@override@JsonKey(name: 'fit_backward') final  double fitBackward;
@override final  double compatibility;
 final  List<String> _sharedInterests;
@override@JsonKey(name: 'shared_interests') List<String> get sharedInterests {
  if (_sharedInterests is EqualUnmodifiableListView) return _sharedInterests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sharedInterests);
}

@override@JsonKey(name: 'reason_summary') final  String reasonSummary;
@override@JsonKey(name: 'snapshot_id') final  String snapshotId;

/// Create a copy of Candidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidateCopyWith<_Candidate> get copyWith => __$CandidateCopyWithImpl<_Candidate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CandidateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Candidate&&(identical(other.candidateUserId, candidateUserId) || other.candidateUserId == candidateUserId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.age, age) || other.age == age)&&(identical(other.isDemo, isDemo) || other.isDemo == isDemo)&&const DeepCollectionEquality().equals(other.traitLabels, _traitLabels)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.fitForward, fitForward) || other.fitForward == fitForward)&&(identical(other.fitBackward, fitBackward) || other.fitBackward == fitBackward)&&(identical(other.compatibility, compatibility) || other.compatibility == compatibility)&&const DeepCollectionEquality().equals(other.sharedInterests, _sharedInterests)&&(identical(other.reasonSummary, reasonSummary) || other.reasonSummary == reasonSummary)&&(identical(other.snapshotId, snapshotId) || other.snapshotId == snapshotId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,candidateUserId,displayName,age,isDemo,const DeepCollectionEquality().hash(_traitLabels),rank,fitForward,fitBackward,compatibility,const DeepCollectionEquality().hash(_sharedInterests),reasonSummary,snapshotId);
}

@override
String toString() {
    return 'Candidate(candidateUserId: $candidateUserId, displayName: $displayName, age: $age, isDemo: $isDemo, traitLabels: $traitLabels, rank: $rank, fitForward: $fitForward, fitBackward: $fitBackward, compatibility: $compatibility, sharedInterests: $sharedInterests, reasonSummary: $reasonSummary, snapshotId: $snapshotId)';
}


}

/// @nodoc
abstract mixin class _$CandidateCopyWith<$Res> implements $CandidateCopyWith<$Res> {
  factory _$CandidateCopyWith(_Candidate value, $Res Function(_Candidate) _then) = __$CandidateCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'candidate_user_id') String candidateUserId,@JsonKey(name: 'display_name') String displayName, int age,@JsonKey(name: 'is_demo') bool isDemo,@JsonKey(name: 'trait_labels') Map<String, List<String>> traitLabels, int rank,@JsonKey(name: 'fit_forward') double fitForward,@JsonKey(name: 'fit_backward') double fitBackward, double compatibility,@JsonKey(name: 'shared_interests') List<String> sharedInterests,@JsonKey(name: 'reason_summary') String reasonSummary,@JsonKey(name: 'snapshot_id') String snapshotId
});




}
/// @nodoc
class __$CandidateCopyWithImpl<$Res>
    implements _$CandidateCopyWith<$Res> {
  __$CandidateCopyWithImpl(this._self, this._then);

  final _Candidate _self;
  final $Res Function(_Candidate) _then;

/// Create a copy of Candidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? candidateUserId = null,Object? displayName = null,Object? age = null,Object? isDemo = null,Object? traitLabels = null,Object? rank = null,Object? fitForward = null,Object? fitBackward = null,Object? compatibility = null,Object? sharedInterests = null,Object? reasonSummary = null,Object? snapshotId = null,}) {
  return _then(_Candidate(
candidateUserId: null == candidateUserId ? _self.candidateUserId : candidateUserId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,isDemo: null == isDemo ? _self.isDemo : isDemo // ignore: cast_nullable_to_non_nullable
as bool,traitLabels: null == traitLabels ? _self._traitLabels : traitLabels // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,fitForward: null == fitForward ? _self.fitForward : fitForward // ignore: cast_nullable_to_non_nullable
as double,fitBackward: null == fitBackward ? _self.fitBackward : fitBackward // ignore: cast_nullable_to_non_nullable
as double,compatibility: null == compatibility ? _self.compatibility : compatibility // ignore: cast_nullable_to_non_nullable
as double,sharedInterests: null == sharedInterests ? _self._sharedInterests : sharedInterests // ignore: cast_nullable_to_non_nullable
as List<String>,reasonSummary: null == reasonSummary ? _self.reasonSummary : reasonSummary // ignore: cast_nullable_to_non_nullable
as String,snapshotId: null == snapshotId ? _self.snapshotId : snapshotId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Analysis {

 String get id; String get status;@JsonKey(name: 'pool_status') String? get poolStatus; String? get error;@JsonKey(name: 'created_at') String get createdAt; List<Candidate> get candidates; String? get message;
/// Create a copy of Analysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalysisCopyWith<Analysis> get copyWith => _$AnalysisCopyWithImpl<Analysis>(this as Analysis, _$identity);

  /// Serializes this Analysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Analysis;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Analysis&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.poolStatus, _this.poolStatus) || other.poolStatus == _this.poolStatus)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&const DeepCollectionEquality().equals(other.candidates, _this.candidates)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Analysis;
  return Object.hash(runtimeType,_this.id,_this.status,_this.poolStatus,_this.error,_this.createdAt,const DeepCollectionEquality().hash(_this.candidates),_this.message);
}

@override
String toString() {
  final _this = this as Analysis;
  return 'Analysis(id: ${_this.id}, status: ${_this.status}, poolStatus: ${_this.poolStatus}, error: ${_this.error}, createdAt: ${_this.createdAt}, candidates: ${_this.candidates}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $AnalysisCopyWith<$Res>  {
  factory $AnalysisCopyWith(Analysis value, $Res Function(Analysis) _then) = _$AnalysisCopyWithImpl;
@useResult
$Res call({
 String id, String status,@JsonKey(name: 'pool_status') String? poolStatus, String? error,@JsonKey(name: 'created_at') String createdAt, List<Candidate> candidates, String? message
});




}
/// @nodoc
class _$AnalysisCopyWithImpl<$Res>
    implements $AnalysisCopyWith<$Res> {
  _$AnalysisCopyWithImpl(this._self, this._then);

  final Analysis _self;
  final $Res Function(Analysis) _then;

/// Create a copy of Analysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? poolStatus = freezed,Object? error = freezed,Object? createdAt = null,Object? candidates = null,Object? message = freezed,}) {
  return _then(Analysis(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,poolStatus: freezed == poolStatus ? _self.poolStatus : poolStatus // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,candidates: null == candidates ? _self.candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<Candidate>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Analysis].
extension AnalysisPatterns on Analysis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Analysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Analysis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Analysis value)  $default,){
final _that = this;
switch (_that) {
case _Analysis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Analysis value)?  $default,){
final _that = this;
switch (_that) {
case _Analysis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String status, @JsonKey(name: 'pool_status')  String? poolStatus,  String? error, @JsonKey(name: 'created_at')  String createdAt,  List<Candidate> candidates,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Analysis() when $default != null:
return $default(_that.id,_that.status,_that.poolStatus,_that.error,_that.createdAt,_that.candidates,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String status, @JsonKey(name: 'pool_status')  String? poolStatus,  String? error, @JsonKey(name: 'created_at')  String createdAt,  List<Candidate> candidates,  String? message)  $default,) {final _that = this;
switch (_that) {
case _Analysis():
return $default(_that.id,_that.status,_that.poolStatus,_that.error,_that.createdAt,_that.candidates,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String status, @JsonKey(name: 'pool_status')  String? poolStatus,  String? error, @JsonKey(name: 'created_at')  String createdAt,  List<Candidate> candidates,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _Analysis() when $default != null:
return $default(_that.id,_that.status,_that.poolStatus,_that.error,_that.createdAt,_that.candidates,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Analysis implements Analysis {
  const _Analysis({required this.id, required this.status, @JsonKey(name: 'pool_status') this.poolStatus, this.error, @JsonKey(name: 'created_at') required this.createdAt,  List<Candidate> candidates = const <Candidate>[], this.message}): _candidates = candidates;
  factory _Analysis.fromJson(Map<String, dynamic> json) => _$AnalysisFromJson(json);

@override final  String id;
@override final  String status;
@override@JsonKey(name: 'pool_status') final  String? poolStatus;
@override final  String? error;
@override@JsonKey(name: 'created_at') final  String createdAt;
 final  List<Candidate> _candidates;
@override@JsonKey() List<Candidate> get candidates {
  if (_candidates is EqualUnmodifiableListView) return _candidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidates);
}

@override final  String? message;

/// Create a copy of Analysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalysisCopyWith<_Analysis> get copyWith => __$AnalysisCopyWithImpl<_Analysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Analysis&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.poolStatus, poolStatus) || other.poolStatus == poolStatus)&&(identical(other.error, error) || other.error == error)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.candidates, _candidates)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,status,poolStatus,error,createdAt,const DeepCollectionEquality().hash(_candidates),message);
}

@override
String toString() {
    return 'Analysis(id: $id, status: $status, poolStatus: $poolStatus, error: $error, createdAt: $createdAt, candidates: $candidates, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AnalysisCopyWith<$Res> implements $AnalysisCopyWith<$Res> {
  factory _$AnalysisCopyWith(_Analysis value, $Res Function(_Analysis) _then) = __$AnalysisCopyWithImpl;
@override @useResult
$Res call({
 String id, String status,@JsonKey(name: 'pool_status') String? poolStatus, String? error,@JsonKey(name: 'created_at') String createdAt, List<Candidate> candidates, String? message
});




}
/// @nodoc
class __$AnalysisCopyWithImpl<$Res>
    implements _$AnalysisCopyWith<$Res> {
  __$AnalysisCopyWithImpl(this._self, this._then);

  final _Analysis _self;
  final $Res Function(_Analysis) _then;

/// Create a copy of Analysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? poolStatus = freezed,Object? error = freezed,Object? createdAt = null,Object? candidates = null,Object? message = freezed,}) {
  return _then(_Analysis(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,poolStatus: freezed == poolStatus ? _self.poolStatus : poolStatus // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,candidates: null == candidates ? _self._candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<Candidate>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
