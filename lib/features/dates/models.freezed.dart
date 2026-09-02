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
mixin _$Evaluation {

 Map<String, dynamic> get criteria;@JsonKey(name: 'date_score') double get dateScore;@JsonKey(name: 'is_partial') bool get isPartial; int? get confidence;@JsonKey(name: 'evidence_note') String get evidenceNote;@JsonKey(name: 'clicked_subjects') List<String> get clickedSubjects; List<Clash> get clashes;@JsonKey(name: 'per_peer_summary') Map<String, dynamic> get perPeerSummary;@JsonKey(name: 'verdict_summary') String get verdictSummary;@JsonKey(name: 'judge_provider') String get judgeProvider;@JsonKey(name: 'judge_model') String get judgeModel;@JsonKey(name: 'rubric_version') String get rubricVersion;
/// Create a copy of Evaluation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvaluationCopyWith<Evaluation> get copyWith => _$EvaluationCopyWithImpl<Evaluation>(this as Evaluation, _$identity);

  /// Serializes this Evaluation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Evaluation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Evaluation&&const DeepCollectionEquality().equals(other.criteria, _this.criteria)&&(identical(other.dateScore, _this.dateScore) || other.dateScore == _this.dateScore)&&(identical(other.isPartial, _this.isPartial) || other.isPartial == _this.isPartial)&&(identical(other.confidence, _this.confidence) || other.confidence == _this.confidence)&&(identical(other.evidenceNote, _this.evidenceNote) || other.evidenceNote == _this.evidenceNote)&&const DeepCollectionEquality().equals(other.clickedSubjects, _this.clickedSubjects)&&const DeepCollectionEquality().equals(other.clashes, _this.clashes)&&const DeepCollectionEquality().equals(other.perPeerSummary, _this.perPeerSummary)&&(identical(other.verdictSummary, _this.verdictSummary) || other.verdictSummary == _this.verdictSummary)&&(identical(other.judgeProvider, _this.judgeProvider) || other.judgeProvider == _this.judgeProvider)&&(identical(other.judgeModel, _this.judgeModel) || other.judgeModel == _this.judgeModel)&&(identical(other.rubricVersion, _this.rubricVersion) || other.rubricVersion == _this.rubricVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Evaluation;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.criteria),_this.dateScore,_this.isPartial,_this.confidence,_this.evidenceNote,const DeepCollectionEquality().hash(_this.clickedSubjects),const DeepCollectionEquality().hash(_this.clashes),const DeepCollectionEquality().hash(_this.perPeerSummary),_this.verdictSummary,_this.judgeProvider,_this.judgeModel,_this.rubricVersion);
}

@override
String toString() {
  final _this = this as Evaluation;
  return 'Evaluation(criteria: ${_this.criteria}, dateScore: ${_this.dateScore}, isPartial: ${_this.isPartial}, confidence: ${_this.confidence}, evidenceNote: ${_this.evidenceNote}, clickedSubjects: ${_this.clickedSubjects}, clashes: ${_this.clashes}, perPeerSummary: ${_this.perPeerSummary}, verdictSummary: ${_this.verdictSummary}, judgeProvider: ${_this.judgeProvider}, judgeModel: ${_this.judgeModel}, rubricVersion: ${_this.rubricVersion})';
}


}

/// @nodoc
abstract mixin class $EvaluationCopyWith<$Res>  {
  factory $EvaluationCopyWith(Evaluation value, $Res Function(Evaluation) _then) = _$EvaluationCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> criteria,@JsonKey(name: 'date_score') double dateScore,@JsonKey(name: 'is_partial') bool isPartial, int? confidence,@JsonKey(name: 'evidence_note') String evidenceNote,@JsonKey(name: 'clicked_subjects') List<String> clickedSubjects, List<Clash> clashes,@JsonKey(name: 'per_peer_summary') Map<String, dynamic> perPeerSummary,@JsonKey(name: 'verdict_summary') String verdictSummary,@JsonKey(name: 'judge_provider') String judgeProvider,@JsonKey(name: 'judge_model') String judgeModel,@JsonKey(name: 'rubric_version') String rubricVersion
});




}
/// @nodoc
class _$EvaluationCopyWithImpl<$Res>
    implements $EvaluationCopyWith<$Res> {
  _$EvaluationCopyWithImpl(this._self, this._then);

  final Evaluation _self;
  final $Res Function(Evaluation) _then;

/// Create a copy of Evaluation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? criteria = null,Object? dateScore = null,Object? isPartial = null,Object? confidence = freezed,Object? evidenceNote = null,Object? clickedSubjects = null,Object? clashes = null,Object? perPeerSummary = null,Object? verdictSummary = null,Object? judgeProvider = null,Object? judgeModel = null,Object? rubricVersion = null,}) {
  return _then(Evaluation(
criteria: null == criteria ? _self.criteria : criteria // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,dateScore: null == dateScore ? _self.dateScore : dateScore // ignore: cast_nullable_to_non_nullable
as double,isPartial: null == isPartial ? _self.isPartial : isPartial // ignore: cast_nullable_to_non_nullable
as bool,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as int?,evidenceNote: null == evidenceNote ? _self.evidenceNote : evidenceNote // ignore: cast_nullable_to_non_nullable
as String,clickedSubjects: null == clickedSubjects ? _self.clickedSubjects : clickedSubjects // ignore: cast_nullable_to_non_nullable
as List<String>,clashes: null == clashes ? _self.clashes : clashes // ignore: cast_nullable_to_non_nullable
as List<Clash>,perPeerSummary: null == perPeerSummary ? _self.perPeerSummary : perPeerSummary // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,verdictSummary: null == verdictSummary ? _self.verdictSummary : verdictSummary // ignore: cast_nullable_to_non_nullable
as String,judgeProvider: null == judgeProvider ? _self.judgeProvider : judgeProvider // ignore: cast_nullable_to_non_nullable
as String,judgeModel: null == judgeModel ? _self.judgeModel : judgeModel // ignore: cast_nullable_to_non_nullable
as String,rubricVersion: null == rubricVersion ? _self.rubricVersion : rubricVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Evaluation].
extension EvaluationPatterns on Evaluation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Evaluation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Evaluation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Evaluation value)  $default,){
final _that = this;
switch (_that) {
case _Evaluation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Evaluation value)?  $default,){
final _that = this;
switch (_that) {
case _Evaluation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic> criteria, @JsonKey(name: 'date_score')  double dateScore, @JsonKey(name: 'is_partial')  bool isPartial,  int? confidence, @JsonKey(name: 'evidence_note')  String evidenceNote, @JsonKey(name: 'clicked_subjects')  List<String> clickedSubjects,  List<Clash> clashes, @JsonKey(name: 'per_peer_summary')  Map<String, dynamic> perPeerSummary, @JsonKey(name: 'verdict_summary')  String verdictSummary, @JsonKey(name: 'judge_provider')  String judgeProvider, @JsonKey(name: 'judge_model')  String judgeModel, @JsonKey(name: 'rubric_version')  String rubricVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Evaluation() when $default != null:
return $default(_that.criteria,_that.dateScore,_that.isPartial,_that.confidence,_that.evidenceNote,_that.clickedSubjects,_that.clashes,_that.perPeerSummary,_that.verdictSummary,_that.judgeProvider,_that.judgeModel,_that.rubricVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic> criteria, @JsonKey(name: 'date_score')  double dateScore, @JsonKey(name: 'is_partial')  bool isPartial,  int? confidence, @JsonKey(name: 'evidence_note')  String evidenceNote, @JsonKey(name: 'clicked_subjects')  List<String> clickedSubjects,  List<Clash> clashes, @JsonKey(name: 'per_peer_summary')  Map<String, dynamic> perPeerSummary, @JsonKey(name: 'verdict_summary')  String verdictSummary, @JsonKey(name: 'judge_provider')  String judgeProvider, @JsonKey(name: 'judge_model')  String judgeModel, @JsonKey(name: 'rubric_version')  String rubricVersion)  $default,) {final _that = this;
switch (_that) {
case _Evaluation():
return $default(_that.criteria,_that.dateScore,_that.isPartial,_that.confidence,_that.evidenceNote,_that.clickedSubjects,_that.clashes,_that.perPeerSummary,_that.verdictSummary,_that.judgeProvider,_that.judgeModel,_that.rubricVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic> criteria, @JsonKey(name: 'date_score')  double dateScore, @JsonKey(name: 'is_partial')  bool isPartial,  int? confidence, @JsonKey(name: 'evidence_note')  String evidenceNote, @JsonKey(name: 'clicked_subjects')  List<String> clickedSubjects,  List<Clash> clashes, @JsonKey(name: 'per_peer_summary')  Map<String, dynamic> perPeerSummary, @JsonKey(name: 'verdict_summary')  String verdictSummary, @JsonKey(name: 'judge_provider')  String judgeProvider, @JsonKey(name: 'judge_model')  String judgeModel, @JsonKey(name: 'rubric_version')  String rubricVersion)?  $default,) {final _that = this;
switch (_that) {
case _Evaluation() when $default != null:
return $default(_that.criteria,_that.dateScore,_that.isPartial,_that.confidence,_that.evidenceNote,_that.clickedSubjects,_that.clashes,_that.perPeerSummary,_that.verdictSummary,_that.judgeProvider,_that.judgeModel,_that.rubricVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Evaluation implements Evaluation {
  const _Evaluation({required  Map<String, dynamic> criteria, @JsonKey(name: 'date_score') required this.dateScore, @JsonKey(name: 'is_partial') required this.isPartial, this.confidence, @JsonKey(name: 'evidence_note') this.evidenceNote = '', @JsonKey(name: 'clicked_subjects')  List<String> clickedSubjects = const <String>[],  List<Clash> clashes = const <Clash>[], @JsonKey(name: 'per_peer_summary')  Map<String, dynamic> perPeerSummary = const <String, dynamic>{}, @JsonKey(name: 'verdict_summary') this.verdictSummary = '', @JsonKey(name: 'judge_provider') this.judgeProvider = '', @JsonKey(name: 'judge_model') this.judgeModel = '', @JsonKey(name: 'rubric_version') this.rubricVersion = ''}): _criteria = criteria,_clickedSubjects = clickedSubjects,_clashes = clashes,_perPeerSummary = perPeerSummary;
  factory _Evaluation.fromJson(Map<String, dynamic> json) => _$EvaluationFromJson(json);

 final  Map<String, dynamic> _criteria;
@override Map<String, dynamic> get criteria {
  if (_criteria is EqualUnmodifiableMapView) return _criteria;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_criteria);
}

@override@JsonKey(name: 'date_score') final  double dateScore;
@override@JsonKey(name: 'is_partial') final  bool isPartial;
@override final  int? confidence;
@override@JsonKey(name: 'evidence_note') final  String evidenceNote;
 final  List<String> _clickedSubjects;
@override@JsonKey(name: 'clicked_subjects') List<String> get clickedSubjects {
  if (_clickedSubjects is EqualUnmodifiableListView) return _clickedSubjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clickedSubjects);
}

 final  List<Clash> _clashes;
@override@JsonKey() List<Clash> get clashes {
  if (_clashes is EqualUnmodifiableListView) return _clashes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clashes);
}

 final  Map<String, dynamic> _perPeerSummary;
@override@JsonKey(name: 'per_peer_summary') Map<String, dynamic> get perPeerSummary {
  if (_perPeerSummary is EqualUnmodifiableMapView) return _perPeerSummary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_perPeerSummary);
}

@override@JsonKey(name: 'verdict_summary') final  String verdictSummary;
@override@JsonKey(name: 'judge_provider') final  String judgeProvider;
@override@JsonKey(name: 'judge_model') final  String judgeModel;
@override@JsonKey(name: 'rubric_version') final  String rubricVersion;

/// Create a copy of Evaluation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvaluationCopyWith<_Evaluation> get copyWith => __$EvaluationCopyWithImpl<_Evaluation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvaluationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Evaluation&&const DeepCollectionEquality().equals(other.criteria, _criteria)&&(identical(other.dateScore, dateScore) || other.dateScore == dateScore)&&(identical(other.isPartial, isPartial) || other.isPartial == isPartial)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.evidenceNote, evidenceNote) || other.evidenceNote == evidenceNote)&&const DeepCollectionEquality().equals(other.clickedSubjects, _clickedSubjects)&&const DeepCollectionEquality().equals(other.clashes, _clashes)&&const DeepCollectionEquality().equals(other.perPeerSummary, _perPeerSummary)&&(identical(other.verdictSummary, verdictSummary) || other.verdictSummary == verdictSummary)&&(identical(other.judgeProvider, judgeProvider) || other.judgeProvider == judgeProvider)&&(identical(other.judgeModel, judgeModel) || other.judgeModel == judgeModel)&&(identical(other.rubricVersion, rubricVersion) || other.rubricVersion == rubricVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_criteria),dateScore,isPartial,confidence,evidenceNote,const DeepCollectionEquality().hash(_clickedSubjects),const DeepCollectionEquality().hash(_clashes),const DeepCollectionEquality().hash(_perPeerSummary),verdictSummary,judgeProvider,judgeModel,rubricVersion);
}

@override
String toString() {
    return 'Evaluation(criteria: $criteria, dateScore: $dateScore, isPartial: $isPartial, confidence: $confidence, evidenceNote: $evidenceNote, clickedSubjects: $clickedSubjects, clashes: $clashes, perPeerSummary: $perPeerSummary, verdictSummary: $verdictSummary, judgeProvider: $judgeProvider, judgeModel: $judgeModel, rubricVersion: $rubricVersion)';
}


}

/// @nodoc
abstract mixin class _$EvaluationCopyWith<$Res> implements $EvaluationCopyWith<$Res> {
  factory _$EvaluationCopyWith(_Evaluation value, $Res Function(_Evaluation) _then) = __$EvaluationCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> criteria,@JsonKey(name: 'date_score') double dateScore,@JsonKey(name: 'is_partial') bool isPartial, int? confidence,@JsonKey(name: 'evidence_note') String evidenceNote,@JsonKey(name: 'clicked_subjects') List<String> clickedSubjects, List<Clash> clashes,@JsonKey(name: 'per_peer_summary') Map<String, dynamic> perPeerSummary,@JsonKey(name: 'verdict_summary') String verdictSummary,@JsonKey(name: 'judge_provider') String judgeProvider,@JsonKey(name: 'judge_model') String judgeModel,@JsonKey(name: 'rubric_version') String rubricVersion
});




}
/// @nodoc
class __$EvaluationCopyWithImpl<$Res>
    implements _$EvaluationCopyWith<$Res> {
  __$EvaluationCopyWithImpl(this._self, this._then);

  final _Evaluation _self;
  final $Res Function(_Evaluation) _then;

/// Create a copy of Evaluation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? criteria = null,Object? dateScore = null,Object? isPartial = null,Object? confidence = freezed,Object? evidenceNote = null,Object? clickedSubjects = null,Object? clashes = null,Object? perPeerSummary = null,Object? verdictSummary = null,Object? judgeProvider = null,Object? judgeModel = null,Object? rubricVersion = null,}) {
  return _then(_Evaluation(
criteria: null == criteria ? _self._criteria : criteria // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,dateScore: null == dateScore ? _self.dateScore : dateScore // ignore: cast_nullable_to_non_nullable
as double,isPartial: null == isPartial ? _self.isPartial : isPartial // ignore: cast_nullable_to_non_nullable
as bool,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as int?,evidenceNote: null == evidenceNote ? _self.evidenceNote : evidenceNote // ignore: cast_nullable_to_non_nullable
as String,clickedSubjects: null == clickedSubjects ? _self._clickedSubjects : clickedSubjects // ignore: cast_nullable_to_non_nullable
as List<String>,clashes: null == clashes ? _self._clashes : clashes // ignore: cast_nullable_to_non_nullable
as List<Clash>,perPeerSummary: null == perPeerSummary ? _self._perPeerSummary : perPeerSummary // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,verdictSummary: null == verdictSummary ? _self.verdictSummary : verdictSummary // ignore: cast_nullable_to_non_nullable
as String,judgeProvider: null == judgeProvider ? _self.judgeProvider : judgeProvider // ignore: cast_nullable_to_non_nullable
as String,judgeModel: null == judgeModel ? _self.judgeModel : judgeModel // ignore: cast_nullable_to_non_nullable
as String,rubricVersion: null == rubricVersion ? _self.rubricVersion : rubricVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Clash {

@JsonKey(name: 'user_trait') String get userTrait;@JsonKey(name: 'candidate_trait') String get candidateTrait; String get moment;
/// Create a copy of Clash
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClashCopyWith<Clash> get copyWith => _$ClashCopyWithImpl<Clash>(this as Clash, _$identity);

  /// Serializes this Clash to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Clash;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Clash&&(identical(other.userTrait, _this.userTrait) || other.userTrait == _this.userTrait)&&(identical(other.candidateTrait, _this.candidateTrait) || other.candidateTrait == _this.candidateTrait)&&(identical(other.moment, _this.moment) || other.moment == _this.moment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Clash;
  return Object.hash(runtimeType,_this.userTrait,_this.candidateTrait,_this.moment);
}

@override
String toString() {
  final _this = this as Clash;
  return 'Clash(userTrait: ${_this.userTrait}, candidateTrait: ${_this.candidateTrait}, moment: ${_this.moment})';
}


}

/// @nodoc
abstract mixin class $ClashCopyWith<$Res>  {
  factory $ClashCopyWith(Clash value, $Res Function(Clash) _then) = _$ClashCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_trait') String userTrait,@JsonKey(name: 'candidate_trait') String candidateTrait, String moment
});




}
/// @nodoc
class _$ClashCopyWithImpl<$Res>
    implements $ClashCopyWith<$Res> {
  _$ClashCopyWithImpl(this._self, this._then);

  final Clash _self;
  final $Res Function(Clash) _then;

/// Create a copy of Clash
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userTrait = null,Object? candidateTrait = null,Object? moment = null,}) {
  return _then(Clash(
userTrait: null == userTrait ? _self.userTrait : userTrait // ignore: cast_nullable_to_non_nullable
as String,candidateTrait: null == candidateTrait ? _self.candidateTrait : candidateTrait // ignore: cast_nullable_to_non_nullable
as String,moment: null == moment ? _self.moment : moment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Clash].
extension ClashPatterns on Clash {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Clash value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Clash() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Clash value)  $default,){
final _that = this;
switch (_that) {
case _Clash():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Clash value)?  $default,){
final _that = this;
switch (_that) {
case _Clash() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_trait')  String userTrait, @JsonKey(name: 'candidate_trait')  String candidateTrait,  String moment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Clash() when $default != null:
return $default(_that.userTrait,_that.candidateTrait,_that.moment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_trait')  String userTrait, @JsonKey(name: 'candidate_trait')  String candidateTrait,  String moment)  $default,) {final _that = this;
switch (_that) {
case _Clash():
return $default(_that.userTrait,_that.candidateTrait,_that.moment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_trait')  String userTrait, @JsonKey(name: 'candidate_trait')  String candidateTrait,  String moment)?  $default,) {final _that = this;
switch (_that) {
case _Clash() when $default != null:
return $default(_that.userTrait,_that.candidateTrait,_that.moment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Clash implements Clash {
  const _Clash({@JsonKey(name: 'user_trait') this.userTrait = '', @JsonKey(name: 'candidate_trait') this.candidateTrait = '', this.moment = ''});
  factory _Clash.fromJson(Map<String, dynamic> json) => _$ClashFromJson(json);

@override@JsonKey(name: 'user_trait') final  String userTrait;
@override@JsonKey(name: 'candidate_trait') final  String candidateTrait;
@override@JsonKey() final  String moment;

/// Create a copy of Clash
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClashCopyWith<_Clash> get copyWith => __$ClashCopyWithImpl<_Clash>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClashToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Clash&&(identical(other.userTrait, userTrait) || other.userTrait == userTrait)&&(identical(other.candidateTrait, candidateTrait) || other.candidateTrait == candidateTrait)&&(identical(other.moment, moment) || other.moment == moment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userTrait,candidateTrait,moment);
}

@override
String toString() {
    return 'Clash(userTrait: $userTrait, candidateTrait: $candidateTrait, moment: $moment)';
}


}

/// @nodoc
abstract mixin class _$ClashCopyWith<$Res> implements $ClashCopyWith<$Res> {
  factory _$ClashCopyWith(_Clash value, $Res Function(_Clash) _then) = __$ClashCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_trait') String userTrait,@JsonKey(name: 'candidate_trait') String candidateTrait, String moment
});




}
/// @nodoc
class __$ClashCopyWithImpl<$Res>
    implements _$ClashCopyWith<$Res> {
  __$ClashCopyWithImpl(this._self, this._then);

  final _Clash _self;
  final $Res Function(_Clash) _then;

/// Create a copy of Clash
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userTrait = null,Object? candidateTrait = null,Object? moment = null,}) {
  return _then(_Clash(
userTrait: null == userTrait ? _self.userTrait : userTrait // ignore: cast_nullable_to_non_nullable
as String,candidateTrait: null == candidateTrait ? _self.candidateTrait : candidateTrait // ignore: cast_nullable_to_non_nullable
as String,moment: null == moment ? _self.moment : moment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DateSummary {

@JsonKey(name: 'date_id') String get dateId;@JsonKey(name: 'candidate_user_id') String get candidateUserId;@JsonKey(name: 'candidate_name') String get candidateName; int get ordinal; String get status;@JsonKey(name: 'setting_name') String get settingName; String get description;@JsonKey(name: 'sensory_details') String get sensoryDetails; String get archetype;@JsonKey(name: 'message_count') int get messageCount;@JsonKey(name: 'turn_count') int get turnCount; String? get error;@JsonKey(name: 'ended_by') String? get endedBy; Evaluation? get evaluation;@JsonKey(name: 'excluded_from_score') bool get excludedFromScore;
/// Create a copy of DateSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateSummaryCopyWith<DateSummary> get copyWith => _$DateSummaryCopyWithImpl<DateSummary>(this as DateSummary, _$identity);

  /// Serializes this DateSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DateSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateSummary&&(identical(other.dateId, _this.dateId) || other.dateId == _this.dateId)&&(identical(other.candidateUserId, _this.candidateUserId) || other.candidateUserId == _this.candidateUserId)&&(identical(other.candidateName, _this.candidateName) || other.candidateName == _this.candidateName)&&(identical(other.ordinal, _this.ordinal) || other.ordinal == _this.ordinal)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.settingName, _this.settingName) || other.settingName == _this.settingName)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.sensoryDetails, _this.sensoryDetails) || other.sensoryDetails == _this.sensoryDetails)&&(identical(other.archetype, _this.archetype) || other.archetype == _this.archetype)&&(identical(other.messageCount, _this.messageCount) || other.messageCount == _this.messageCount)&&(identical(other.turnCount, _this.turnCount) || other.turnCount == _this.turnCount)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.endedBy, _this.endedBy) || other.endedBy == _this.endedBy)&&(identical(other.evaluation, _this.evaluation) || other.evaluation == _this.evaluation)&&(identical(other.excludedFromScore, _this.excludedFromScore) || other.excludedFromScore == _this.excludedFromScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DateSummary;
  return Object.hash(runtimeType,_this.dateId,_this.candidateUserId,_this.candidateName,_this.ordinal,_this.status,_this.settingName,_this.description,_this.sensoryDetails,_this.archetype,_this.messageCount,_this.turnCount,_this.error,_this.endedBy,_this.evaluation,_this.excludedFromScore);
}

@override
String toString() {
  final _this = this as DateSummary;
  return 'DateSummary(dateId: ${_this.dateId}, candidateUserId: ${_this.candidateUserId}, candidateName: ${_this.candidateName}, ordinal: ${_this.ordinal}, status: ${_this.status}, settingName: ${_this.settingName}, description: ${_this.description}, sensoryDetails: ${_this.sensoryDetails}, archetype: ${_this.archetype}, messageCount: ${_this.messageCount}, turnCount: ${_this.turnCount}, error: ${_this.error}, endedBy: ${_this.endedBy}, evaluation: ${_this.evaluation}, excludedFromScore: ${_this.excludedFromScore})';
}


}

/// @nodoc
abstract mixin class $DateSummaryCopyWith<$Res>  {
  factory $DateSummaryCopyWith(DateSummary value, $Res Function(DateSummary) _then) = _$DateSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'date_id') String dateId,@JsonKey(name: 'candidate_user_id') String candidateUserId,@JsonKey(name: 'candidate_name') String candidateName, int ordinal, String status,@JsonKey(name: 'setting_name') String settingName, String description,@JsonKey(name: 'sensory_details') String sensoryDetails, String archetype,@JsonKey(name: 'message_count') int messageCount,@JsonKey(name: 'turn_count') int turnCount, String? error,@JsonKey(name: 'ended_by') String? endedBy, Evaluation? evaluation,@JsonKey(name: 'excluded_from_score') bool excludedFromScore
});


$EvaluationCopyWith<$Res>? get evaluation;

}
/// @nodoc
class _$DateSummaryCopyWithImpl<$Res>
    implements $DateSummaryCopyWith<$Res> {
  _$DateSummaryCopyWithImpl(this._self, this._then);

  final DateSummary _self;
  final $Res Function(DateSummary) _then;

/// Create a copy of DateSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateId = null,Object? candidateUserId = null,Object? candidateName = null,Object? ordinal = null,Object? status = null,Object? settingName = null,Object? description = null,Object? sensoryDetails = null,Object? archetype = null,Object? messageCount = null,Object? turnCount = null,Object? error = freezed,Object? endedBy = freezed,Object? evaluation = freezed,Object? excludedFromScore = null,}) {
  return _then(DateSummary(
dateId: null == dateId ? _self.dateId : dateId // ignore: cast_nullable_to_non_nullable
as String,candidateUserId: null == candidateUserId ? _self.candidateUserId : candidateUserId // ignore: cast_nullable_to_non_nullable
as String,candidateName: null == candidateName ? _self.candidateName : candidateName // ignore: cast_nullable_to_non_nullable
as String,ordinal: null == ordinal ? _self.ordinal : ordinal // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,settingName: null == settingName ? _self.settingName : settingName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sensoryDetails: null == sensoryDetails ? _self.sensoryDetails : sensoryDetails // ignore: cast_nullable_to_non_nullable
as String,archetype: null == archetype ? _self.archetype : archetype // ignore: cast_nullable_to_non_nullable
as String,messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,turnCount: null == turnCount ? _self.turnCount : turnCount // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,endedBy: freezed == endedBy ? _self.endedBy : endedBy // ignore: cast_nullable_to_non_nullable
as String?,evaluation: freezed == evaluation ? _self.evaluation : evaluation // ignore: cast_nullable_to_non_nullable
as Evaluation?,excludedFromScore: null == excludedFromScore ? _self.excludedFromScore : excludedFromScore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of DateSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvaluationCopyWith<$Res>? get evaluation {
    if (_self.evaluation == null) {
    return null;
  }

  return $EvaluationCopyWith<$Res>(_self.evaluation!, (value) {
    return _then(_self.copyWith(evaluation: value));
  });
}
}


/// Adds pattern-matching-related methods to [DateSummary].
extension DateSummaryPatterns on DateSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DateSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DateSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DateSummary value)  $default,){
final _that = this;
switch (_that) {
case _DateSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DateSummary value)?  $default,){
final _that = this;
switch (_that) {
case _DateSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'date_id')  String dateId, @JsonKey(name: 'candidate_user_id')  String candidateUserId, @JsonKey(name: 'candidate_name')  String candidateName,  int ordinal,  String status, @JsonKey(name: 'setting_name')  String settingName,  String description, @JsonKey(name: 'sensory_details')  String sensoryDetails,  String archetype, @JsonKey(name: 'message_count')  int messageCount, @JsonKey(name: 'turn_count')  int turnCount,  String? error, @JsonKey(name: 'ended_by')  String? endedBy,  Evaluation? evaluation, @JsonKey(name: 'excluded_from_score')  bool excludedFromScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DateSummary() when $default != null:
return $default(_that.dateId,_that.candidateUserId,_that.candidateName,_that.ordinal,_that.status,_that.settingName,_that.description,_that.sensoryDetails,_that.archetype,_that.messageCount,_that.turnCount,_that.error,_that.endedBy,_that.evaluation,_that.excludedFromScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'date_id')  String dateId, @JsonKey(name: 'candidate_user_id')  String candidateUserId, @JsonKey(name: 'candidate_name')  String candidateName,  int ordinal,  String status, @JsonKey(name: 'setting_name')  String settingName,  String description, @JsonKey(name: 'sensory_details')  String sensoryDetails,  String archetype, @JsonKey(name: 'message_count')  int messageCount, @JsonKey(name: 'turn_count')  int turnCount,  String? error, @JsonKey(name: 'ended_by')  String? endedBy,  Evaluation? evaluation, @JsonKey(name: 'excluded_from_score')  bool excludedFromScore)  $default,) {final _that = this;
switch (_that) {
case _DateSummary():
return $default(_that.dateId,_that.candidateUserId,_that.candidateName,_that.ordinal,_that.status,_that.settingName,_that.description,_that.sensoryDetails,_that.archetype,_that.messageCount,_that.turnCount,_that.error,_that.endedBy,_that.evaluation,_that.excludedFromScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'date_id')  String dateId, @JsonKey(name: 'candidate_user_id')  String candidateUserId, @JsonKey(name: 'candidate_name')  String candidateName,  int ordinal,  String status, @JsonKey(name: 'setting_name')  String settingName,  String description, @JsonKey(name: 'sensory_details')  String sensoryDetails,  String archetype, @JsonKey(name: 'message_count')  int messageCount, @JsonKey(name: 'turn_count')  int turnCount,  String? error, @JsonKey(name: 'ended_by')  String? endedBy,  Evaluation? evaluation, @JsonKey(name: 'excluded_from_score')  bool excludedFromScore)?  $default,) {final _that = this;
switch (_that) {
case _DateSummary() when $default != null:
return $default(_that.dateId,_that.candidateUserId,_that.candidateName,_that.ordinal,_that.status,_that.settingName,_that.description,_that.sensoryDetails,_that.archetype,_that.messageCount,_that.turnCount,_that.error,_that.endedBy,_that.evaluation,_that.excludedFromScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DateSummary implements DateSummary {
  const _DateSummary({@JsonKey(name: 'date_id') required this.dateId, @JsonKey(name: 'candidate_user_id') required this.candidateUserId, @JsonKey(name: 'candidate_name') required this.candidateName, required this.ordinal, required this.status, @JsonKey(name: 'setting_name') this.settingName = '', this.description = '', @JsonKey(name: 'sensory_details') this.sensoryDetails = '', this.archetype = '', @JsonKey(name: 'message_count') this.messageCount = 0, @JsonKey(name: 'turn_count') this.turnCount = 0, this.error, @JsonKey(name: 'ended_by') this.endedBy, this.evaluation, @JsonKey(name: 'excluded_from_score') this.excludedFromScore = false});
  factory _DateSummary.fromJson(Map<String, dynamic> json) => _$DateSummaryFromJson(json);

@override@JsonKey(name: 'date_id') final  String dateId;
@override@JsonKey(name: 'candidate_user_id') final  String candidateUserId;
@override@JsonKey(name: 'candidate_name') final  String candidateName;
@override final  int ordinal;
@override final  String status;
@override@JsonKey(name: 'setting_name') final  String settingName;
@override@JsonKey() final  String description;
@override@JsonKey(name: 'sensory_details') final  String sensoryDetails;
@override@JsonKey() final  String archetype;
@override@JsonKey(name: 'message_count') final  int messageCount;
@override@JsonKey(name: 'turn_count') final  int turnCount;
@override final  String? error;
@override@JsonKey(name: 'ended_by') final  String? endedBy;
@override final  Evaluation? evaluation;
@override@JsonKey(name: 'excluded_from_score') final  bool excludedFromScore;

/// Create a copy of DateSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DateSummaryCopyWith<_DateSummary> get copyWith => __$DateSummaryCopyWithImpl<_DateSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DateSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DateSummary&&(identical(other.dateId, dateId) || other.dateId == dateId)&&(identical(other.candidateUserId, candidateUserId) || other.candidateUserId == candidateUserId)&&(identical(other.candidateName, candidateName) || other.candidateName == candidateName)&&(identical(other.ordinal, ordinal) || other.ordinal == ordinal)&&(identical(other.status, status) || other.status == status)&&(identical(other.settingName, settingName) || other.settingName == settingName)&&(identical(other.description, description) || other.description == description)&&(identical(other.sensoryDetails, sensoryDetails) || other.sensoryDetails == sensoryDetails)&&(identical(other.archetype, archetype) || other.archetype == archetype)&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount)&&(identical(other.turnCount, turnCount) || other.turnCount == turnCount)&&(identical(other.error, error) || other.error == error)&&(identical(other.endedBy, endedBy) || other.endedBy == endedBy)&&(identical(other.evaluation, evaluation) || other.evaluation == evaluation)&&(identical(other.excludedFromScore, excludedFromScore) || other.excludedFromScore == excludedFromScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dateId,candidateUserId,candidateName,ordinal,status,settingName,description,sensoryDetails,archetype,messageCount,turnCount,error,endedBy,evaluation,excludedFromScore);
}

@override
String toString() {
    return 'DateSummary(dateId: $dateId, candidateUserId: $candidateUserId, candidateName: $candidateName, ordinal: $ordinal, status: $status, settingName: $settingName, description: $description, sensoryDetails: $sensoryDetails, archetype: $archetype, messageCount: $messageCount, turnCount: $turnCount, error: $error, endedBy: $endedBy, evaluation: $evaluation, excludedFromScore: $excludedFromScore)';
}


}

/// @nodoc
abstract mixin class _$DateSummaryCopyWith<$Res> implements $DateSummaryCopyWith<$Res> {
  factory _$DateSummaryCopyWith(_DateSummary value, $Res Function(_DateSummary) _then) = __$DateSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'date_id') String dateId,@JsonKey(name: 'candidate_user_id') String candidateUserId,@JsonKey(name: 'candidate_name') String candidateName, int ordinal, String status,@JsonKey(name: 'setting_name') String settingName, String description,@JsonKey(name: 'sensory_details') String sensoryDetails, String archetype,@JsonKey(name: 'message_count') int messageCount,@JsonKey(name: 'turn_count') int turnCount, String? error,@JsonKey(name: 'ended_by') String? endedBy, Evaluation? evaluation,@JsonKey(name: 'excluded_from_score') bool excludedFromScore
});


@override $EvaluationCopyWith<$Res>? get evaluation;

}
/// @nodoc
class __$DateSummaryCopyWithImpl<$Res>
    implements _$DateSummaryCopyWith<$Res> {
  __$DateSummaryCopyWithImpl(this._self, this._then);

  final _DateSummary _self;
  final $Res Function(_DateSummary) _then;

/// Create a copy of DateSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateId = null,Object? candidateUserId = null,Object? candidateName = null,Object? ordinal = null,Object? status = null,Object? settingName = null,Object? description = null,Object? sensoryDetails = null,Object? archetype = null,Object? messageCount = null,Object? turnCount = null,Object? error = freezed,Object? endedBy = freezed,Object? evaluation = freezed,Object? excludedFromScore = null,}) {
  return _then(_DateSummary(
dateId: null == dateId ? _self.dateId : dateId // ignore: cast_nullable_to_non_nullable
as String,candidateUserId: null == candidateUserId ? _self.candidateUserId : candidateUserId // ignore: cast_nullable_to_non_nullable
as String,candidateName: null == candidateName ? _self.candidateName : candidateName // ignore: cast_nullable_to_non_nullable
as String,ordinal: null == ordinal ? _self.ordinal : ordinal // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,settingName: null == settingName ? _self.settingName : settingName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sensoryDetails: null == sensoryDetails ? _self.sensoryDetails : sensoryDetails // ignore: cast_nullable_to_non_nullable
as String,archetype: null == archetype ? _self.archetype : archetype // ignore: cast_nullable_to_non_nullable
as String,messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,turnCount: null == turnCount ? _self.turnCount : turnCount // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,endedBy: freezed == endedBy ? _self.endedBy : endedBy // ignore: cast_nullable_to_non_nullable
as String?,evaluation: freezed == evaluation ? _self.evaluation : evaluation // ignore: cast_nullable_to_non_nullable
as Evaluation?,excludedFromScore: null == excludedFromScore ? _self.excludedFromScore : excludedFromScore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of DateSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EvaluationCopyWith<$Res>? get evaluation {
    if (_self.evaluation == null) {
    return null;
  }

  return $EvaluationCopyWith<$Res>(_self.evaluation!, (value) {
    return _then(_self.copyWith(evaluation: value));
  });
}
}


/// @nodoc
mixin _$Fixture {

@JsonKey(name: 'setting_name') String get settingName; String get archetype;@JsonKey(name: 'dates_per_candidate') int get datesPerCandidate;
/// Create a copy of Fixture
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FixtureCopyWith<Fixture> get copyWith => _$FixtureCopyWithImpl<Fixture>(this as Fixture, _$identity);

  /// Serializes this Fixture to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Fixture;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Fixture&&(identical(other.settingName, _this.settingName) || other.settingName == _this.settingName)&&(identical(other.archetype, _this.archetype) || other.archetype == _this.archetype)&&(identical(other.datesPerCandidate, _this.datesPerCandidate) || other.datesPerCandidate == _this.datesPerCandidate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Fixture;
  return Object.hash(runtimeType,_this.settingName,_this.archetype,_this.datesPerCandidate);
}

@override
String toString() {
  final _this = this as Fixture;
  return 'Fixture(settingName: ${_this.settingName}, archetype: ${_this.archetype}, datesPerCandidate: ${_this.datesPerCandidate})';
}


}

/// @nodoc
abstract mixin class $FixtureCopyWith<$Res>  {
  factory $FixtureCopyWith(Fixture value, $Res Function(Fixture) _then) = _$FixtureCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'setting_name') String settingName, String archetype,@JsonKey(name: 'dates_per_candidate') int datesPerCandidate
});




}
/// @nodoc
class _$FixtureCopyWithImpl<$Res>
    implements $FixtureCopyWith<$Res> {
  _$FixtureCopyWithImpl(this._self, this._then);

  final Fixture _self;
  final $Res Function(Fixture) _then;

/// Create a copy of Fixture
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settingName = null,Object? archetype = null,Object? datesPerCandidate = null,}) {
  return _then(Fixture(
settingName: null == settingName ? _self.settingName : settingName // ignore: cast_nullable_to_non_nullable
as String,archetype: null == archetype ? _self.archetype : archetype // ignore: cast_nullable_to_non_nullable
as String,datesPerCandidate: null == datesPerCandidate ? _self.datesPerCandidate : datesPerCandidate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Fixture].
extension FixturePatterns on Fixture {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Fixture value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Fixture() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Fixture value)  $default,){
final _that = this;
switch (_that) {
case _Fixture():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Fixture value)?  $default,){
final _that = this;
switch (_that) {
case _Fixture() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'setting_name')  String settingName,  String archetype, @JsonKey(name: 'dates_per_candidate')  int datesPerCandidate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Fixture() when $default != null:
return $default(_that.settingName,_that.archetype,_that.datesPerCandidate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'setting_name')  String settingName,  String archetype, @JsonKey(name: 'dates_per_candidate')  int datesPerCandidate)  $default,) {final _that = this;
switch (_that) {
case _Fixture():
return $default(_that.settingName,_that.archetype,_that.datesPerCandidate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'setting_name')  String settingName,  String archetype, @JsonKey(name: 'dates_per_candidate')  int datesPerCandidate)?  $default,) {final _that = this;
switch (_that) {
case _Fixture() when $default != null:
return $default(_that.settingName,_that.archetype,_that.datesPerCandidate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Fixture implements Fixture {
  const _Fixture({@JsonKey(name: 'setting_name') this.settingName = '', this.archetype = '', @JsonKey(name: 'dates_per_candidate') this.datesPerCandidate = 1});
  factory _Fixture.fromJson(Map<String, dynamic> json) => _$FixtureFromJson(json);

@override@JsonKey(name: 'setting_name') final  String settingName;
@override@JsonKey() final  String archetype;
@override@JsonKey(name: 'dates_per_candidate') final  int datesPerCandidate;

/// Create a copy of Fixture
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FixtureCopyWith<_Fixture> get copyWith => __$FixtureCopyWithImpl<_Fixture>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FixtureToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Fixture&&(identical(other.settingName, settingName) || other.settingName == settingName)&&(identical(other.archetype, archetype) || other.archetype == archetype)&&(identical(other.datesPerCandidate, datesPerCandidate) || other.datesPerCandidate == datesPerCandidate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,settingName,archetype,datesPerCandidate);
}

@override
String toString() {
    return 'Fixture(settingName: $settingName, archetype: $archetype, datesPerCandidate: $datesPerCandidate)';
}


}

/// @nodoc
abstract mixin class _$FixtureCopyWith<$Res> implements $FixtureCopyWith<$Res> {
  factory _$FixtureCopyWith(_Fixture value, $Res Function(_Fixture) _then) = __$FixtureCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'setting_name') String settingName, String archetype,@JsonKey(name: 'dates_per_candidate') int datesPerCandidate
});




}
/// @nodoc
class __$FixtureCopyWithImpl<$Res>
    implements _$FixtureCopyWith<$Res> {
  __$FixtureCopyWithImpl(this._self, this._then);

  final _Fixture _self;
  final $Res Function(_Fixture) _then;

/// Create a copy of Fixture
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settingName = null,Object? archetype = null,Object? datesPerCandidate = null,}) {
  return _then(_Fixture(
settingName: null == settingName ? _self.settingName : settingName // ignore: cast_nullable_to_non_nullable
as String,archetype: null == archetype ? _self.archetype : archetype // ignore: cast_nullable_to_non_nullable
as String,datesPerCandidate: null == datesPerCandidate ? _self.datesPerCandidate : datesPerCandidate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DatesPayload {

@JsonKey(name: 'analysis_id') String get analysisId; String get status; Map<String, dynamic>? get progress; Fixture? get fixture; List<DateSummary> get dates;
/// Create a copy of DatesPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatesPayloadCopyWith<DatesPayload> get copyWith => _$DatesPayloadCopyWithImpl<DatesPayload>(this as DatesPayload, _$identity);

  /// Serializes this DatesPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DatesPayload;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatesPayload&&(identical(other.analysisId, _this.analysisId) || other.analysisId == _this.analysisId)&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.progress, _this.progress)&&(identical(other.fixture, _this.fixture) || other.fixture == _this.fixture)&&const DeepCollectionEquality().equals(other.dates, _this.dates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DatesPayload;
  return Object.hash(runtimeType,_this.analysisId,_this.status,const DeepCollectionEquality().hash(_this.progress),_this.fixture,const DeepCollectionEquality().hash(_this.dates));
}

@override
String toString() {
  final _this = this as DatesPayload;
  return 'DatesPayload(analysisId: ${_this.analysisId}, status: ${_this.status}, progress: ${_this.progress}, fixture: ${_this.fixture}, dates: ${_this.dates})';
}


}

/// @nodoc
abstract mixin class $DatesPayloadCopyWith<$Res>  {
  factory $DatesPayloadCopyWith(DatesPayload value, $Res Function(DatesPayload) _then) = _$DatesPayloadCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'analysis_id') String analysisId, String status, Map<String, dynamic>? progress, Fixture? fixture, List<DateSummary> dates
});


$FixtureCopyWith<$Res>? get fixture;

}
/// @nodoc
class _$DatesPayloadCopyWithImpl<$Res>
    implements $DatesPayloadCopyWith<$Res> {
  _$DatesPayloadCopyWithImpl(this._self, this._then);

  final DatesPayload _self;
  final $Res Function(DatesPayload) _then;

/// Create a copy of DatesPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? analysisId = null,Object? status = null,Object? progress = freezed,Object? fixture = freezed,Object? dates = null,}) {
  return _then(DatesPayload(
analysisId: null == analysisId ? _self.analysisId : analysisId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,fixture: freezed == fixture ? _self.fixture : fixture // ignore: cast_nullable_to_non_nullable
as Fixture?,dates: null == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as List<DateSummary>,
  ));
}
/// Create a copy of DatesPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FixtureCopyWith<$Res>? get fixture {
    if (_self.fixture == null) {
    return null;
  }

  return $FixtureCopyWith<$Res>(_self.fixture!, (value) {
    return _then(_self.copyWith(fixture: value));
  });
}
}


/// Adds pattern-matching-related methods to [DatesPayload].
extension DatesPayloadPatterns on DatesPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DatesPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DatesPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DatesPayload value)  $default,){
final _that = this;
switch (_that) {
case _DatesPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DatesPayload value)?  $default,){
final _that = this;
switch (_that) {
case _DatesPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'analysis_id')  String analysisId,  String status,  Map<String, dynamic>? progress,  Fixture? fixture,  List<DateSummary> dates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DatesPayload() when $default != null:
return $default(_that.analysisId,_that.status,_that.progress,_that.fixture,_that.dates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'analysis_id')  String analysisId,  String status,  Map<String, dynamic>? progress,  Fixture? fixture,  List<DateSummary> dates)  $default,) {final _that = this;
switch (_that) {
case _DatesPayload():
return $default(_that.analysisId,_that.status,_that.progress,_that.fixture,_that.dates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'analysis_id')  String analysisId,  String status,  Map<String, dynamic>? progress,  Fixture? fixture,  List<DateSummary> dates)?  $default,) {final _that = this;
switch (_that) {
case _DatesPayload() when $default != null:
return $default(_that.analysisId,_that.status,_that.progress,_that.fixture,_that.dates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DatesPayload implements DatesPayload {
  const _DatesPayload({@JsonKey(name: 'analysis_id') required this.analysisId, required this.status,  Map<String, dynamic>? progress, this.fixture,  List<DateSummary> dates = const <DateSummary>[]}): _progress = progress,_dates = dates;
  factory _DatesPayload.fromJson(Map<String, dynamic> json) => _$DatesPayloadFromJson(json);

@override@JsonKey(name: 'analysis_id') final  String analysisId;
@override final  String status;
 final  Map<String, dynamic>? _progress;
@override Map<String, dynamic>? get progress {
  final value = _progress;
  if (value == null) return null;
  if (_progress is EqualUnmodifiableMapView) return _progress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  Fixture? fixture;
 final  List<DateSummary> _dates;
@override@JsonKey() List<DateSummary> get dates {
  if (_dates is EqualUnmodifiableListView) return _dates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dates);
}


/// Create a copy of DatesPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DatesPayloadCopyWith<_DatesPayload> get copyWith => __$DatesPayloadCopyWithImpl<_DatesPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DatesPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DatesPayload&&(identical(other.analysisId, analysisId) || other.analysisId == analysisId)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.progress, _progress)&&(identical(other.fixture, fixture) || other.fixture == fixture)&&const DeepCollectionEquality().equals(other.dates, _dates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,analysisId,status,const DeepCollectionEquality().hash(_progress),fixture,const DeepCollectionEquality().hash(_dates));
}

@override
String toString() {
    return 'DatesPayload(analysisId: $analysisId, status: $status, progress: $progress, fixture: $fixture, dates: $dates)';
}


}

/// @nodoc
abstract mixin class _$DatesPayloadCopyWith<$Res> implements $DatesPayloadCopyWith<$Res> {
  factory _$DatesPayloadCopyWith(_DatesPayload value, $Res Function(_DatesPayload) _then) = __$DatesPayloadCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'analysis_id') String analysisId, String status, Map<String, dynamic>? progress, Fixture? fixture, List<DateSummary> dates
});


@override $FixtureCopyWith<$Res>? get fixture;

}
/// @nodoc
class __$DatesPayloadCopyWithImpl<$Res>
    implements _$DatesPayloadCopyWith<$Res> {
  __$DatesPayloadCopyWithImpl(this._self, this._then);

  final _DatesPayload _self;
  final $Res Function(_DatesPayload) _then;

/// Create a copy of DatesPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? analysisId = null,Object? status = null,Object? progress = freezed,Object? fixture = freezed,Object? dates = null,}) {
  return _then(_DatesPayload(
analysisId: null == analysisId ? _self.analysisId : analysisId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,progress: freezed == progress ? _self._progress : progress // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,fixture: freezed == fixture ? _self.fixture : fixture // ignore: cast_nullable_to_non_nullable
as Fixture?,dates: null == dates ? _self._dates : dates // ignore: cast_nullable_to_non_nullable
as List<DateSummary>,
  ));
}

/// Create a copy of DatesPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FixtureCopyWith<$Res>? get fixture {
    if (_self.fixture == null) {
    return null;
  }

  return $FixtureCopyWith<$Res>(_self.fixture!, (value) {
    return _then(_self.copyWith(fixture: value));
  });
}
}


/// @nodoc
mixin _$TranscriptMessage {

 int get seq; String get speaker; String get reply; Map<String, dynamic>? get state; String? get provider;@JsonKey(name: 'model_id') String? get modelId;
/// Create a copy of TranscriptMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptMessageCopyWith<TranscriptMessage> get copyWith => _$TranscriptMessageCopyWithImpl<TranscriptMessage>(this as TranscriptMessage, _$identity);

  /// Serializes this TranscriptMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TranscriptMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranscriptMessage&&(identical(other.seq, _this.seq) || other.seq == _this.seq)&&(identical(other.speaker, _this.speaker) || other.speaker == _this.speaker)&&(identical(other.reply, _this.reply) || other.reply == _this.reply)&&const DeepCollectionEquality().equals(other.state, _this.state)&&(identical(other.provider, _this.provider) || other.provider == _this.provider)&&(identical(other.modelId, _this.modelId) || other.modelId == _this.modelId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TranscriptMessage;
  return Object.hash(runtimeType,_this.seq,_this.speaker,_this.reply,const DeepCollectionEquality().hash(_this.state),_this.provider,_this.modelId);
}

@override
String toString() {
  final _this = this as TranscriptMessage;
  return 'TranscriptMessage(seq: ${_this.seq}, speaker: ${_this.speaker}, reply: ${_this.reply}, state: ${_this.state}, provider: ${_this.provider}, modelId: ${_this.modelId})';
}


}

/// @nodoc
abstract mixin class $TranscriptMessageCopyWith<$Res>  {
  factory $TranscriptMessageCopyWith(TranscriptMessage value, $Res Function(TranscriptMessage) _then) = _$TranscriptMessageCopyWithImpl;
@useResult
$Res call({
 int seq, String speaker, String reply, Map<String, dynamic>? state, String? provider,@JsonKey(name: 'model_id') String? modelId
});




}
/// @nodoc
class _$TranscriptMessageCopyWithImpl<$Res>
    implements $TranscriptMessageCopyWith<$Res> {
  _$TranscriptMessageCopyWithImpl(this._self, this._then);

  final TranscriptMessage _self;
  final $Res Function(TranscriptMessage) _then;

/// Create a copy of TranscriptMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seq = null,Object? speaker = null,Object? reply = null,Object? state = freezed,Object? provider = freezed,Object? modelId = freezed,}) {
  return _then(TranscriptMessage(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,modelId: freezed == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TranscriptMessage].
extension TranscriptMessagePatterns on TranscriptMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranscriptMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranscriptMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranscriptMessage value)  $default,){
final _that = this;
switch (_that) {
case _TranscriptMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranscriptMessage value)?  $default,){
final _that = this;
switch (_that) {
case _TranscriptMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seq,  String speaker,  String reply,  Map<String, dynamic>? state,  String? provider, @JsonKey(name: 'model_id')  String? modelId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranscriptMessage() when $default != null:
return $default(_that.seq,_that.speaker,_that.reply,_that.state,_that.provider,_that.modelId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seq,  String speaker,  String reply,  Map<String, dynamic>? state,  String? provider, @JsonKey(name: 'model_id')  String? modelId)  $default,) {final _that = this;
switch (_that) {
case _TranscriptMessage():
return $default(_that.seq,_that.speaker,_that.reply,_that.state,_that.provider,_that.modelId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seq,  String speaker,  String reply,  Map<String, dynamic>? state,  String? provider, @JsonKey(name: 'model_id')  String? modelId)?  $default,) {final _that = this;
switch (_that) {
case _TranscriptMessage() when $default != null:
return $default(_that.seq,_that.speaker,_that.reply,_that.state,_that.provider,_that.modelId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranscriptMessage implements TranscriptMessage {
  const _TranscriptMessage({required this.seq, required this.speaker, required this.reply,  Map<String, dynamic>? state, this.provider, @JsonKey(name: 'model_id') this.modelId}): _state = state;
  factory _TranscriptMessage.fromJson(Map<String, dynamic> json) => _$TranscriptMessageFromJson(json);

@override final  int seq;
@override final  String speaker;
@override final  String reply;
 final  Map<String, dynamic>? _state;
@override Map<String, dynamic>? get state {
  final value = _state;
  if (value == null) return null;
  if (_state is EqualUnmodifiableMapView) return _state;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? provider;
@override@JsonKey(name: 'model_id') final  String? modelId;

/// Create a copy of TranscriptMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptMessageCopyWith<_TranscriptMessage> get copyWith => __$TranscriptMessageCopyWithImpl<_TranscriptMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranscriptMessageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranscriptMessage&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.speaker, speaker) || other.speaker == speaker)&&(identical(other.reply, reply) || other.reply == reply)&&const DeepCollectionEquality().equals(other.state, _state)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.modelId, modelId) || other.modelId == modelId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,seq,speaker,reply,const DeepCollectionEquality().hash(_state),provider,modelId);
}

@override
String toString() {
    return 'TranscriptMessage(seq: $seq, speaker: $speaker, reply: $reply, state: $state, provider: $provider, modelId: $modelId)';
}


}

/// @nodoc
abstract mixin class _$TranscriptMessageCopyWith<$Res> implements $TranscriptMessageCopyWith<$Res> {
  factory _$TranscriptMessageCopyWith(_TranscriptMessage value, $Res Function(_TranscriptMessage) _then) = __$TranscriptMessageCopyWithImpl;
@override @useResult
$Res call({
 int seq, String speaker, String reply, Map<String, dynamic>? state, String? provider,@JsonKey(name: 'model_id') String? modelId
});




}
/// @nodoc
class __$TranscriptMessageCopyWithImpl<$Res>
    implements _$TranscriptMessageCopyWith<$Res> {
  __$TranscriptMessageCopyWithImpl(this._self, this._then);

  final _TranscriptMessage _self;
  final $Res Function(_TranscriptMessage) _then;

/// Create a copy of TranscriptMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seq = null,Object? speaker = null,Object? reply = null,Object? state = freezed,Object? provider = freezed,Object? modelId = freezed,}) {
  return _then(_TranscriptMessage(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,speaker: null == speaker ? _self.speaker : speaker // ignore: cast_nullable_to_non_nullable
as String,reply: null == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String,state: freezed == state ? _self._state : state // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,modelId: freezed == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Transcript {

@JsonKey(name: 'date_id') String get dateId;@JsonKey(name: 'analysis_id') String get analysisId; String get status;@JsonKey(name: 'setting_name') String get settingName; String get description;@JsonKey(name: 'sensory_details') String get sensoryDetails;@JsonKey(name: 'user_display_name') String get userDisplayName;@JsonKey(name: 'candidate_display_name') String get candidateDisplayName;@JsonKey(name: 'schema_version') String get schemaVersion;@JsonKey(name: 'ended_by') String? get endedBy; List<TranscriptMessage> get messages;
/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptCopyWith<Transcript> get copyWith => _$TranscriptCopyWithImpl<Transcript>(this as Transcript, _$identity);

  /// Serializes this Transcript to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Transcript;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transcript&&(identical(other.dateId, _this.dateId) || other.dateId == _this.dateId)&&(identical(other.analysisId, _this.analysisId) || other.analysisId == _this.analysisId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.settingName, _this.settingName) || other.settingName == _this.settingName)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.sensoryDetails, _this.sensoryDetails) || other.sensoryDetails == _this.sensoryDetails)&&(identical(other.userDisplayName, _this.userDisplayName) || other.userDisplayName == _this.userDisplayName)&&(identical(other.candidateDisplayName, _this.candidateDisplayName) || other.candidateDisplayName == _this.candidateDisplayName)&&(identical(other.schemaVersion, _this.schemaVersion) || other.schemaVersion == _this.schemaVersion)&&(identical(other.endedBy, _this.endedBy) || other.endedBy == _this.endedBy)&&const DeepCollectionEquality().equals(other.messages, _this.messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Transcript;
  return Object.hash(runtimeType,_this.dateId,_this.analysisId,_this.status,_this.settingName,_this.description,_this.sensoryDetails,_this.userDisplayName,_this.candidateDisplayName,_this.schemaVersion,_this.endedBy,const DeepCollectionEquality().hash(_this.messages));
}

@override
String toString() {
  final _this = this as Transcript;
  return 'Transcript(dateId: ${_this.dateId}, analysisId: ${_this.analysisId}, status: ${_this.status}, settingName: ${_this.settingName}, description: ${_this.description}, sensoryDetails: ${_this.sensoryDetails}, userDisplayName: ${_this.userDisplayName}, candidateDisplayName: ${_this.candidateDisplayName}, schemaVersion: ${_this.schemaVersion}, endedBy: ${_this.endedBy}, messages: ${_this.messages})';
}


}

/// @nodoc
abstract mixin class $TranscriptCopyWith<$Res>  {
  factory $TranscriptCopyWith(Transcript value, $Res Function(Transcript) _then) = _$TranscriptCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'date_id') String dateId,@JsonKey(name: 'analysis_id') String analysisId, String status,@JsonKey(name: 'setting_name') String settingName, String description,@JsonKey(name: 'sensory_details') String sensoryDetails,@JsonKey(name: 'user_display_name') String userDisplayName,@JsonKey(name: 'candidate_display_name') String candidateDisplayName,@JsonKey(name: 'schema_version') String schemaVersion,@JsonKey(name: 'ended_by') String? endedBy, List<TranscriptMessage> messages
});




}
/// @nodoc
class _$TranscriptCopyWithImpl<$Res>
    implements $TranscriptCopyWith<$Res> {
  _$TranscriptCopyWithImpl(this._self, this._then);

  final Transcript _self;
  final $Res Function(Transcript) _then;

/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateId = null,Object? analysisId = null,Object? status = null,Object? settingName = null,Object? description = null,Object? sensoryDetails = null,Object? userDisplayName = null,Object? candidateDisplayName = null,Object? schemaVersion = null,Object? endedBy = freezed,Object? messages = null,}) {
  return _then(Transcript(
dateId: null == dateId ? _self.dateId : dateId // ignore: cast_nullable_to_non_nullable
as String,analysisId: null == analysisId ? _self.analysisId : analysisId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,settingName: null == settingName ? _self.settingName : settingName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sensoryDetails: null == sensoryDetails ? _self.sensoryDetails : sensoryDetails // ignore: cast_nullable_to_non_nullable
as String,userDisplayName: null == userDisplayName ? _self.userDisplayName : userDisplayName // ignore: cast_nullable_to_non_nullable
as String,candidateDisplayName: null == candidateDisplayName ? _self.candidateDisplayName : candidateDisplayName // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as String,endedBy: freezed == endedBy ? _self.endedBy : endedBy // ignore: cast_nullable_to_non_nullable
as String?,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<TranscriptMessage>,
  ));
}

}


/// Adds pattern-matching-related methods to [Transcript].
extension TranscriptPatterns on Transcript {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transcript value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transcript() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transcript value)  $default,){
final _that = this;
switch (_that) {
case _Transcript():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transcript value)?  $default,){
final _that = this;
switch (_that) {
case _Transcript() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'date_id')  String dateId, @JsonKey(name: 'analysis_id')  String analysisId,  String status, @JsonKey(name: 'setting_name')  String settingName,  String description, @JsonKey(name: 'sensory_details')  String sensoryDetails, @JsonKey(name: 'user_display_name')  String userDisplayName, @JsonKey(name: 'candidate_display_name')  String candidateDisplayName, @JsonKey(name: 'schema_version')  String schemaVersion, @JsonKey(name: 'ended_by')  String? endedBy,  List<TranscriptMessage> messages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transcript() when $default != null:
return $default(_that.dateId,_that.analysisId,_that.status,_that.settingName,_that.description,_that.sensoryDetails,_that.userDisplayName,_that.candidateDisplayName,_that.schemaVersion,_that.endedBy,_that.messages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'date_id')  String dateId, @JsonKey(name: 'analysis_id')  String analysisId,  String status, @JsonKey(name: 'setting_name')  String settingName,  String description, @JsonKey(name: 'sensory_details')  String sensoryDetails, @JsonKey(name: 'user_display_name')  String userDisplayName, @JsonKey(name: 'candidate_display_name')  String candidateDisplayName, @JsonKey(name: 'schema_version')  String schemaVersion, @JsonKey(name: 'ended_by')  String? endedBy,  List<TranscriptMessage> messages)  $default,) {final _that = this;
switch (_that) {
case _Transcript():
return $default(_that.dateId,_that.analysisId,_that.status,_that.settingName,_that.description,_that.sensoryDetails,_that.userDisplayName,_that.candidateDisplayName,_that.schemaVersion,_that.endedBy,_that.messages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'date_id')  String dateId, @JsonKey(name: 'analysis_id')  String analysisId,  String status, @JsonKey(name: 'setting_name')  String settingName,  String description, @JsonKey(name: 'sensory_details')  String sensoryDetails, @JsonKey(name: 'user_display_name')  String userDisplayName, @JsonKey(name: 'candidate_display_name')  String candidateDisplayName, @JsonKey(name: 'schema_version')  String schemaVersion, @JsonKey(name: 'ended_by')  String? endedBy,  List<TranscriptMessage> messages)?  $default,) {final _that = this;
switch (_that) {
case _Transcript() when $default != null:
return $default(_that.dateId,_that.analysisId,_that.status,_that.settingName,_that.description,_that.sensoryDetails,_that.userDisplayName,_that.candidateDisplayName,_that.schemaVersion,_that.endedBy,_that.messages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Transcript implements Transcript {
  const _Transcript({@JsonKey(name: 'date_id') required this.dateId, @JsonKey(name: 'analysis_id') required this.analysisId, required this.status, @JsonKey(name: 'setting_name') this.settingName = '', this.description = '', @JsonKey(name: 'sensory_details') this.sensoryDetails = '', @JsonKey(name: 'user_display_name') this.userDisplayName = 'You', @JsonKey(name: 'candidate_display_name') this.candidateDisplayName = '', @JsonKey(name: 'schema_version') this.schemaVersion = '', @JsonKey(name: 'ended_by') this.endedBy,  List<TranscriptMessage> messages = const <TranscriptMessage>[]}): _messages = messages;
  factory _Transcript.fromJson(Map<String, dynamic> json) => _$TranscriptFromJson(json);

@override@JsonKey(name: 'date_id') final  String dateId;
@override@JsonKey(name: 'analysis_id') final  String analysisId;
@override final  String status;
@override@JsonKey(name: 'setting_name') final  String settingName;
@override@JsonKey() final  String description;
@override@JsonKey(name: 'sensory_details') final  String sensoryDetails;
@override@JsonKey(name: 'user_display_name') final  String userDisplayName;
@override@JsonKey(name: 'candidate_display_name') final  String candidateDisplayName;
@override@JsonKey(name: 'schema_version') final  String schemaVersion;
@override@JsonKey(name: 'ended_by') final  String? endedBy;
 final  List<TranscriptMessage> _messages;
@override@JsonKey() List<TranscriptMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptCopyWith<_Transcript> get copyWith => __$TranscriptCopyWithImpl<_Transcript>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranscriptToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transcript&&(identical(other.dateId, dateId) || other.dateId == dateId)&&(identical(other.analysisId, analysisId) || other.analysisId == analysisId)&&(identical(other.status, status) || other.status == status)&&(identical(other.settingName, settingName) || other.settingName == settingName)&&(identical(other.description, description) || other.description == description)&&(identical(other.sensoryDetails, sensoryDetails) || other.sensoryDetails == sensoryDetails)&&(identical(other.userDisplayName, userDisplayName) || other.userDisplayName == userDisplayName)&&(identical(other.candidateDisplayName, candidateDisplayName) || other.candidateDisplayName == candidateDisplayName)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.endedBy, endedBy) || other.endedBy == endedBy)&&const DeepCollectionEquality().equals(other.messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dateId,analysisId,status,settingName,description,sensoryDetails,userDisplayName,candidateDisplayName,schemaVersion,endedBy,const DeepCollectionEquality().hash(_messages));
}

@override
String toString() {
    return 'Transcript(dateId: $dateId, analysisId: $analysisId, status: $status, settingName: $settingName, description: $description, sensoryDetails: $sensoryDetails, userDisplayName: $userDisplayName, candidateDisplayName: $candidateDisplayName, schemaVersion: $schemaVersion, endedBy: $endedBy, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$TranscriptCopyWith<$Res> implements $TranscriptCopyWith<$Res> {
  factory _$TranscriptCopyWith(_Transcript value, $Res Function(_Transcript) _then) = __$TranscriptCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'date_id') String dateId,@JsonKey(name: 'analysis_id') String analysisId, String status,@JsonKey(name: 'setting_name') String settingName, String description,@JsonKey(name: 'sensory_details') String sensoryDetails,@JsonKey(name: 'user_display_name') String userDisplayName,@JsonKey(name: 'candidate_display_name') String candidateDisplayName,@JsonKey(name: 'schema_version') String schemaVersion,@JsonKey(name: 'ended_by') String? endedBy, List<TranscriptMessage> messages
});




}
/// @nodoc
class __$TranscriptCopyWithImpl<$Res>
    implements _$TranscriptCopyWith<$Res> {
  __$TranscriptCopyWithImpl(this._self, this._then);

  final _Transcript _self;
  final $Res Function(_Transcript) _then;

/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateId = null,Object? analysisId = null,Object? status = null,Object? settingName = null,Object? description = null,Object? sensoryDetails = null,Object? userDisplayName = null,Object? candidateDisplayName = null,Object? schemaVersion = null,Object? endedBy = freezed,Object? messages = null,}) {
  return _then(_Transcript(
dateId: null == dateId ? _self.dateId : dateId // ignore: cast_nullable_to_non_nullable
as String,analysisId: null == analysisId ? _self.analysisId : analysisId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,settingName: null == settingName ? _self.settingName : settingName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sensoryDetails: null == sensoryDetails ? _self.sensoryDetails : sensoryDetails // ignore: cast_nullable_to_non_nullable
as String,userDisplayName: null == userDisplayName ? _self.userDisplayName : userDisplayName // ignore: cast_nullable_to_non_nullable
as String,candidateDisplayName: null == candidateDisplayName ? _self.candidateDisplayName : candidateDisplayName // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as String,endedBy: freezed == endedBy ? _self.endedBy : endedBy // ignore: cast_nullable_to_non_nullable
as String?,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<TranscriptMessage>,
  ));
}


}

// dart format on
