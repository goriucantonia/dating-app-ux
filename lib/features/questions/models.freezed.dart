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
mixin _$Question {

 String get id; String get origin; String? get code;@JsonKey(name: 'pool_order') int? get poolOrder;@JsonKey(name: 'probe_area') String get probeArea; String get text; bool get answered;@JsonKey(name: 'answer_text') String? get answerText;@JsonKey(name: 'answer_updated_at') String? get answerUpdatedAt;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Question;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.origin, _this.origin) || other.origin == _this.origin)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.poolOrder, _this.poolOrder) || other.poolOrder == _this.poolOrder)&&(identical(other.probeArea, _this.probeArea) || other.probeArea == _this.probeArea)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.answered, _this.answered) || other.answered == _this.answered)&&(identical(other.answerText, _this.answerText) || other.answerText == _this.answerText)&&(identical(other.answerUpdatedAt, _this.answerUpdatedAt) || other.answerUpdatedAt == _this.answerUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Question;
  return Object.hash(runtimeType,_this.id,_this.origin,_this.code,_this.poolOrder,_this.probeArea,_this.text,_this.answered,_this.answerText,_this.answerUpdatedAt);
}

@override
String toString() {
  final _this = this as Question;
  return 'Question(id: ${_this.id}, origin: ${_this.origin}, code: ${_this.code}, poolOrder: ${_this.poolOrder}, probeArea: ${_this.probeArea}, text: ${_this.text}, answered: ${_this.answered}, answerText: ${_this.answerText}, answerUpdatedAt: ${_this.answerUpdatedAt})';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 String id, String origin, String? code,@JsonKey(name: 'pool_order') int? poolOrder,@JsonKey(name: 'probe_area') String probeArea, String text, bool answered,@JsonKey(name: 'answer_text') String? answerText,@JsonKey(name: 'answer_updated_at') String? answerUpdatedAt
});




}
/// @nodoc
class _$QuestionCopyWithImpl<$Res>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._self, this._then);

  final Question _self;
  final $Res Function(Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? origin = null,Object? code = freezed,Object? poolOrder = freezed,Object? probeArea = null,Object? text = null,Object? answered = null,Object? answerText = freezed,Object? answerUpdatedAt = freezed,}) {
  return _then(Question(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,poolOrder: freezed == poolOrder ? _self.poolOrder : poolOrder // ignore: cast_nullable_to_non_nullable
as int?,probeArea: null == probeArea ? _self.probeArea : probeArea // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,answered: null == answered ? _self.answered : answered // ignore: cast_nullable_to_non_nullable
as bool,answerText: freezed == answerText ? _self.answerText : answerText // ignore: cast_nullable_to_non_nullable
as String?,answerUpdatedAt: freezed == answerUpdatedAt ? _self.answerUpdatedAt : answerUpdatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Question].
extension QuestionPatterns on Question {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Question value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Question value)  $default,){
final _that = this;
switch (_that) {
case _Question():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Question value)?  $default,){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String origin,  String? code, @JsonKey(name: 'pool_order')  int? poolOrder, @JsonKey(name: 'probe_area')  String probeArea,  String text,  bool answered, @JsonKey(name: 'answer_text')  String? answerText, @JsonKey(name: 'answer_updated_at')  String? answerUpdatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.origin,_that.code,_that.poolOrder,_that.probeArea,_that.text,_that.answered,_that.answerText,_that.answerUpdatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String origin,  String? code, @JsonKey(name: 'pool_order')  int? poolOrder, @JsonKey(name: 'probe_area')  String probeArea,  String text,  bool answered, @JsonKey(name: 'answer_text')  String? answerText, @JsonKey(name: 'answer_updated_at')  String? answerUpdatedAt)  $default,) {final _that = this;
switch (_that) {
case _Question():
return $default(_that.id,_that.origin,_that.code,_that.poolOrder,_that.probeArea,_that.text,_that.answered,_that.answerText,_that.answerUpdatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String origin,  String? code, @JsonKey(name: 'pool_order')  int? poolOrder, @JsonKey(name: 'probe_area')  String probeArea,  String text,  bool answered, @JsonKey(name: 'answer_text')  String? answerText, @JsonKey(name: 'answer_updated_at')  String? answerUpdatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.origin,_that.code,_that.poolOrder,_that.probeArea,_that.text,_that.answered,_that.answerText,_that.answerUpdatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Question implements Question {
  const _Question({required this.id, required this.origin, this.code, @JsonKey(name: 'pool_order') this.poolOrder, @JsonKey(name: 'probe_area') required this.probeArea, required this.text, required this.answered, @JsonKey(name: 'answer_text') this.answerText, @JsonKey(name: 'answer_updated_at') this.answerUpdatedAt});
  factory _Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

@override final  String id;
@override final  String origin;
@override final  String? code;
@override@JsonKey(name: 'pool_order') final  int? poolOrder;
@override@JsonKey(name: 'probe_area') final  String probeArea;
@override final  String text;
@override final  bool answered;
@override@JsonKey(name: 'answer_text') final  String? answerText;
@override@JsonKey(name: 'answer_updated_at') final  String? answerUpdatedAt;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionCopyWith<_Question> get copyWith => __$QuestionCopyWithImpl<_Question>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Question&&(identical(other.id, id) || other.id == id)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.code, code) || other.code == code)&&(identical(other.poolOrder, poolOrder) || other.poolOrder == poolOrder)&&(identical(other.probeArea, probeArea) || other.probeArea == probeArea)&&(identical(other.text, text) || other.text == text)&&(identical(other.answered, answered) || other.answered == answered)&&(identical(other.answerText, answerText) || other.answerText == answerText)&&(identical(other.answerUpdatedAt, answerUpdatedAt) || other.answerUpdatedAt == answerUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,origin,code,poolOrder,probeArea,text,answered,answerText,answerUpdatedAt);
}

@override
String toString() {
    return 'Question(id: $id, origin: $origin, code: $code, poolOrder: $poolOrder, probeArea: $probeArea, text: $text, answered: $answered, answerText: $answerText, answerUpdatedAt: $answerUpdatedAt)';
}


}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) = __$QuestionCopyWithImpl;
@override @useResult
$Res call({
 String id, String origin, String? code,@JsonKey(name: 'pool_order') int? poolOrder,@JsonKey(name: 'probe_area') String probeArea, String text, bool answered,@JsonKey(name: 'answer_text') String? answerText,@JsonKey(name: 'answer_updated_at') String? answerUpdatedAt
});




}
/// @nodoc
class __$QuestionCopyWithImpl<$Res>
    implements _$QuestionCopyWith<$Res> {
  __$QuestionCopyWithImpl(this._self, this._then);

  final _Question _self;
  final $Res Function(_Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? origin = null,Object? code = freezed,Object? poolOrder = freezed,Object? probeArea = null,Object? text = null,Object? answered = null,Object? answerText = freezed,Object? answerUpdatedAt = freezed,}) {
  return _then(_Question(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,poolOrder: freezed == poolOrder ? _self.poolOrder : poolOrder // ignore: cast_nullable_to_non_nullable
as int?,probeArea: null == probeArea ? _self.probeArea : probeArea // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,answered: null == answered ? _self.answered : answered // ignore: cast_nullable_to_non_nullable
as bool,answerText: freezed == answerText ? _self.answerText : answerText // ignore: cast_nullable_to_non_nullable
as String?,answerUpdatedAt: freezed == answerUpdatedAt ? _self.answerUpdatedAt : answerUpdatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PoolProgress {

@JsonKey(name: 'answered_pool') int get answeredPool;@JsonKey(name: 'total_pool') int get totalPool;
/// Create a copy of PoolProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PoolProgressCopyWith<PoolProgress> get copyWith => _$PoolProgressCopyWithImpl<PoolProgress>(this as PoolProgress, _$identity);

  /// Serializes this PoolProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PoolProgress;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PoolProgress&&(identical(other.answeredPool, _this.answeredPool) || other.answeredPool == _this.answeredPool)&&(identical(other.totalPool, _this.totalPool) || other.totalPool == _this.totalPool));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PoolProgress;
  return Object.hash(runtimeType,_this.answeredPool,_this.totalPool);
}

@override
String toString() {
  final _this = this as PoolProgress;
  return 'PoolProgress(answeredPool: ${_this.answeredPool}, totalPool: ${_this.totalPool})';
}


}

/// @nodoc
abstract mixin class $PoolProgressCopyWith<$Res>  {
  factory $PoolProgressCopyWith(PoolProgress value, $Res Function(PoolProgress) _then) = _$PoolProgressCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'answered_pool') int answeredPool,@JsonKey(name: 'total_pool') int totalPool
});




}
/// @nodoc
class _$PoolProgressCopyWithImpl<$Res>
    implements $PoolProgressCopyWith<$Res> {
  _$PoolProgressCopyWithImpl(this._self, this._then);

  final PoolProgress _self;
  final $Res Function(PoolProgress) _then;

/// Create a copy of PoolProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? answeredPool = null,Object? totalPool = null,}) {
  return _then(PoolProgress(
answeredPool: null == answeredPool ? _self.answeredPool : answeredPool // ignore: cast_nullable_to_non_nullable
as int,totalPool: null == totalPool ? _self.totalPool : totalPool // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PoolProgress].
extension PoolProgressPatterns on PoolProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PoolProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PoolProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PoolProgress value)  $default,){
final _that = this;
switch (_that) {
case _PoolProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PoolProgress value)?  $default,){
final _that = this;
switch (_that) {
case _PoolProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'answered_pool')  int answeredPool, @JsonKey(name: 'total_pool')  int totalPool)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PoolProgress() when $default != null:
return $default(_that.answeredPool,_that.totalPool);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'answered_pool')  int answeredPool, @JsonKey(name: 'total_pool')  int totalPool)  $default,) {final _that = this;
switch (_that) {
case _PoolProgress():
return $default(_that.answeredPool,_that.totalPool);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'answered_pool')  int answeredPool, @JsonKey(name: 'total_pool')  int totalPool)?  $default,) {final _that = this;
switch (_that) {
case _PoolProgress() when $default != null:
return $default(_that.answeredPool,_that.totalPool);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PoolProgress implements PoolProgress {
  const _PoolProgress({@JsonKey(name: 'answered_pool') required this.answeredPool, @JsonKey(name: 'total_pool') required this.totalPool});
  factory _PoolProgress.fromJson(Map<String, dynamic> json) => _$PoolProgressFromJson(json);

@override@JsonKey(name: 'answered_pool') final  int answeredPool;
@override@JsonKey(name: 'total_pool') final  int totalPool;

/// Create a copy of PoolProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PoolProgressCopyWith<_PoolProgress> get copyWith => __$PoolProgressCopyWithImpl<_PoolProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PoolProgressToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PoolProgress&&(identical(other.answeredPool, answeredPool) || other.answeredPool == answeredPool)&&(identical(other.totalPool, totalPool) || other.totalPool == totalPool));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,answeredPool,totalPool);
}

@override
String toString() {
    return 'PoolProgress(answeredPool: $answeredPool, totalPool: $totalPool)';
}


}

/// @nodoc
abstract mixin class _$PoolProgressCopyWith<$Res> implements $PoolProgressCopyWith<$Res> {
  factory _$PoolProgressCopyWith(_PoolProgress value, $Res Function(_PoolProgress) _then) = __$PoolProgressCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'answered_pool') int answeredPool,@JsonKey(name: 'total_pool') int totalPool
});




}
/// @nodoc
class __$PoolProgressCopyWithImpl<$Res>
    implements _$PoolProgressCopyWith<$Res> {
  __$PoolProgressCopyWithImpl(this._self, this._then);

  final _PoolProgress _self;
  final $Res Function(_PoolProgress) _then;

/// Create a copy of PoolProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? answeredPool = null,Object? totalPool = null,}) {
  return _then(_PoolProgress(
answeredPool: null == answeredPool ? _self.answeredPool : answeredPool // ignore: cast_nullable_to_non_nullable
as int,totalPool: null == totalPool ? _self.totalPool : totalPool // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$NextBatch {

 String get status; List<Question> get questions; PoolProgress get progress;
/// Create a copy of NextBatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NextBatchCopyWith<NextBatch> get copyWith => _$NextBatchCopyWithImpl<NextBatch>(this as NextBatch, _$identity);

  /// Serializes this NextBatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NextBatch;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NextBatch&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.questions, _this.questions)&&(identical(other.progress, _this.progress) || other.progress == _this.progress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NextBatch;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.questions),_this.progress);
}

@override
String toString() {
  final _this = this as NextBatch;
  return 'NextBatch(status: ${_this.status}, questions: ${_this.questions}, progress: ${_this.progress})';
}


}

/// @nodoc
abstract mixin class $NextBatchCopyWith<$Res>  {
  factory $NextBatchCopyWith(NextBatch value, $Res Function(NextBatch) _then) = _$NextBatchCopyWithImpl;
@useResult
$Res call({
 String status, List<Question> questions, PoolProgress progress
});


$PoolProgressCopyWith<$Res> get progress;

}
/// @nodoc
class _$NextBatchCopyWithImpl<$Res>
    implements $NextBatchCopyWith<$Res> {
  _$NextBatchCopyWithImpl(this._self, this._then);

  final NextBatch _self;
  final $Res Function(NextBatch) _then;

/// Create a copy of NextBatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? questions = null,Object? progress = null,}) {
  return _then(NextBatch(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as PoolProgress,
  ));
}
/// Create a copy of NextBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PoolProgressCopyWith<$Res> get progress {
  
  return $PoolProgressCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// Adds pattern-matching-related methods to [NextBatch].
extension NextBatchPatterns on NextBatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NextBatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NextBatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NextBatch value)  $default,){
final _that = this;
switch (_that) {
case _NextBatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NextBatch value)?  $default,){
final _that = this;
switch (_that) {
case _NextBatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  List<Question> questions,  PoolProgress progress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NextBatch() when $default != null:
return $default(_that.status,_that.questions,_that.progress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  List<Question> questions,  PoolProgress progress)  $default,) {final _that = this;
switch (_that) {
case _NextBatch():
return $default(_that.status,_that.questions,_that.progress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  List<Question> questions,  PoolProgress progress)?  $default,) {final _that = this;
switch (_that) {
case _NextBatch() when $default != null:
return $default(_that.status,_that.questions,_that.progress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NextBatch implements NextBatch {
  const _NextBatch({required this.status, required  List<Question> questions, required this.progress}): _questions = questions;
  factory _NextBatch.fromJson(Map<String, dynamic> json) => _$NextBatchFromJson(json);

@override final  String status;
 final  List<Question> _questions;
@override List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

@override final  PoolProgress progress;

/// Create a copy of NextBatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NextBatchCopyWith<_NextBatch> get copyWith => __$NextBatchCopyWithImpl<_NextBatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NextBatchToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NextBatch&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.questions, _questions)&&(identical(other.progress, progress) || other.progress == progress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_questions),progress);
}

@override
String toString() {
    return 'NextBatch(status: $status, questions: $questions, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$NextBatchCopyWith<$Res> implements $NextBatchCopyWith<$Res> {
  factory _$NextBatchCopyWith(_NextBatch value, $Res Function(_NextBatch) _then) = __$NextBatchCopyWithImpl;
@override @useResult
$Res call({
 String status, List<Question> questions, PoolProgress progress
});


@override $PoolProgressCopyWith<$Res> get progress;

}
/// @nodoc
class __$NextBatchCopyWithImpl<$Res>
    implements _$NextBatchCopyWith<$Res> {
  __$NextBatchCopyWithImpl(this._self, this._then);

  final _NextBatch _self;
  final $Res Function(_NextBatch) _then;

/// Create a copy of NextBatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? questions = null,Object? progress = null,}) {
  return _then(_NextBatch(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as PoolProgress,
  ));
}

/// Create a copy of NextBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PoolProgressCopyWith<$Res> get progress {
  
  return $PoolProgressCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}

// dart format on
