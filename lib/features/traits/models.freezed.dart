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
mixin _$Trait {

 String get id; String get category; String get label; String get description; double get confidence; String get status;@JsonKey(name: 'source_answer_ids') List<String> get sourceAnswerIds;@JsonKey(name: 'extracted_by') String get extractedBy;
/// Create a copy of Trait
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TraitCopyWith<Trait> get copyWith => _$TraitCopyWithImpl<Trait>(this as Trait, _$identity);

  /// Serializes this Trait to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Trait;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Trait&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.confidence, _this.confidence) || other.confidence == _this.confidence)&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.sourceAnswerIds, _this.sourceAnswerIds)&&(identical(other.extractedBy, _this.extractedBy) || other.extractedBy == _this.extractedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Trait;
  return Object.hash(runtimeType,_this.id,_this.category,_this.label,_this.description,_this.confidence,_this.status,const DeepCollectionEquality().hash(_this.sourceAnswerIds),_this.extractedBy);
}

@override
String toString() {
  final _this = this as Trait;
  return 'Trait(id: ${_this.id}, category: ${_this.category}, label: ${_this.label}, description: ${_this.description}, confidence: ${_this.confidence}, status: ${_this.status}, sourceAnswerIds: ${_this.sourceAnswerIds}, extractedBy: ${_this.extractedBy})';
}


}

/// @nodoc
abstract mixin class $TraitCopyWith<$Res>  {
  factory $TraitCopyWith(Trait value, $Res Function(Trait) _then) = _$TraitCopyWithImpl;
@useResult
$Res call({
 String id, String category, String label, String description, double confidence, String status,@JsonKey(name: 'source_answer_ids') List<String> sourceAnswerIds,@JsonKey(name: 'extracted_by') String extractedBy
});




}
/// @nodoc
class _$TraitCopyWithImpl<$Res>
    implements $TraitCopyWith<$Res> {
  _$TraitCopyWithImpl(this._self, this._then);

  final Trait _self;
  final $Res Function(Trait) _then;

/// Create a copy of Trait
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? label = null,Object? description = null,Object? confidence = null,Object? status = null,Object? sourceAnswerIds = null,Object? extractedBy = null,}) {
  return _then(Trait(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,sourceAnswerIds: null == sourceAnswerIds ? _self.sourceAnswerIds : sourceAnswerIds // ignore: cast_nullable_to_non_nullable
as List<String>,extractedBy: null == extractedBy ? _self.extractedBy : extractedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Trait].
extension TraitPatterns on Trait {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Trait value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Trait() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Trait value)  $default,){
final _that = this;
switch (_that) {
case _Trait():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Trait value)?  $default,){
final _that = this;
switch (_that) {
case _Trait() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String category,  String label,  String description,  double confidence,  String status, @JsonKey(name: 'source_answer_ids')  List<String> sourceAnswerIds, @JsonKey(name: 'extracted_by')  String extractedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Trait() when $default != null:
return $default(_that.id,_that.category,_that.label,_that.description,_that.confidence,_that.status,_that.sourceAnswerIds,_that.extractedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String category,  String label,  String description,  double confidence,  String status, @JsonKey(name: 'source_answer_ids')  List<String> sourceAnswerIds, @JsonKey(name: 'extracted_by')  String extractedBy)  $default,) {final _that = this;
switch (_that) {
case _Trait():
return $default(_that.id,_that.category,_that.label,_that.description,_that.confidence,_that.status,_that.sourceAnswerIds,_that.extractedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String category,  String label,  String description,  double confidence,  String status, @JsonKey(name: 'source_answer_ids')  List<String> sourceAnswerIds, @JsonKey(name: 'extracted_by')  String extractedBy)?  $default,) {final _that = this;
switch (_that) {
case _Trait() when $default != null:
return $default(_that.id,_that.category,_that.label,_that.description,_that.confidence,_that.status,_that.sourceAnswerIds,_that.extractedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Trait implements Trait {
  const _Trait({required this.id, required this.category, required this.label, required this.description, required this.confidence, required this.status, @JsonKey(name: 'source_answer_ids') required  List<String> sourceAnswerIds, @JsonKey(name: 'extracted_by') required this.extractedBy}): _sourceAnswerIds = sourceAnswerIds;
  factory _Trait.fromJson(Map<String, dynamic> json) => _$TraitFromJson(json);

@override final  String id;
@override final  String category;
@override final  String label;
@override final  String description;
@override final  double confidence;
@override final  String status;
 final  List<String> _sourceAnswerIds;
@override@JsonKey(name: 'source_answer_ids') List<String> get sourceAnswerIds {
  if (_sourceAnswerIds is EqualUnmodifiableListView) return _sourceAnswerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sourceAnswerIds);
}

@override@JsonKey(name: 'extracted_by') final  String extractedBy;

/// Create a copy of Trait
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TraitCopyWith<_Trait> get copyWith => __$TraitCopyWithImpl<_Trait>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TraitToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Trait&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.sourceAnswerIds, _sourceAnswerIds)&&(identical(other.extractedBy, extractedBy) || other.extractedBy == extractedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,category,label,description,confidence,status,const DeepCollectionEquality().hash(_sourceAnswerIds),extractedBy);
}

@override
String toString() {
    return 'Trait(id: $id, category: $category, label: $label, description: $description, confidence: $confidence, status: $status, sourceAnswerIds: $sourceAnswerIds, extractedBy: $extractedBy)';
}


}

/// @nodoc
abstract mixin class _$TraitCopyWith<$Res> implements $TraitCopyWith<$Res> {
  factory _$TraitCopyWith(_Trait value, $Res Function(_Trait) _then) = __$TraitCopyWithImpl;
@override @useResult
$Res call({
 String id, String category, String label, String description, double confidence, String status,@JsonKey(name: 'source_answer_ids') List<String> sourceAnswerIds,@JsonKey(name: 'extracted_by') String extractedBy
});




}
/// @nodoc
class __$TraitCopyWithImpl<$Res>
    implements _$TraitCopyWith<$Res> {
  __$TraitCopyWithImpl(this._self, this._then);

  final _Trait _self;
  final $Res Function(_Trait) _then;

/// Create a copy of Trait
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? label = null,Object? description = null,Object? confidence = null,Object? status = null,Object? sourceAnswerIds = null,Object? extractedBy = null,}) {
  return _then(_Trait(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,sourceAnswerIds: null == sourceAnswerIds ? _self._sourceAnswerIds : sourceAnswerIds // ignore: cast_nullable_to_non_nullable
as List<String>,extractedBy: null == extractedBy ? _self.extractedBy : extractedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TraitsPayload {

 List<Trait> get traits;@JsonKey(name: 'traits_hash') String get traitsHash;
/// Create a copy of TraitsPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TraitsPayloadCopyWith<TraitsPayload> get copyWith => _$TraitsPayloadCopyWithImpl<TraitsPayload>(this as TraitsPayload, _$identity);

  /// Serializes this TraitsPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TraitsPayload;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraitsPayload&&const DeepCollectionEquality().equals(other.traits, _this.traits)&&(identical(other.traitsHash, _this.traitsHash) || other.traitsHash == _this.traitsHash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TraitsPayload;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.traits),_this.traitsHash);
}

@override
String toString() {
  final _this = this as TraitsPayload;
  return 'TraitsPayload(traits: ${_this.traits}, traitsHash: ${_this.traitsHash})';
}


}

/// @nodoc
abstract mixin class $TraitsPayloadCopyWith<$Res>  {
  factory $TraitsPayloadCopyWith(TraitsPayload value, $Res Function(TraitsPayload) _then) = _$TraitsPayloadCopyWithImpl;
@useResult
$Res call({
 List<Trait> traits,@JsonKey(name: 'traits_hash') String traitsHash
});




}
/// @nodoc
class _$TraitsPayloadCopyWithImpl<$Res>
    implements $TraitsPayloadCopyWith<$Res> {
  _$TraitsPayloadCopyWithImpl(this._self, this._then);

  final TraitsPayload _self;
  final $Res Function(TraitsPayload) _then;

/// Create a copy of TraitsPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? traits = null,Object? traitsHash = null,}) {
  return _then(TraitsPayload(
traits: null == traits ? _self.traits : traits // ignore: cast_nullable_to_non_nullable
as List<Trait>,traitsHash: null == traitsHash ? _self.traitsHash : traitsHash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TraitsPayload].
extension TraitsPayloadPatterns on TraitsPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TraitsPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TraitsPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TraitsPayload value)  $default,){
final _that = this;
switch (_that) {
case _TraitsPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TraitsPayload value)?  $default,){
final _that = this;
switch (_that) {
case _TraitsPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Trait> traits, @JsonKey(name: 'traits_hash')  String traitsHash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TraitsPayload() when $default != null:
return $default(_that.traits,_that.traitsHash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Trait> traits, @JsonKey(name: 'traits_hash')  String traitsHash)  $default,) {final _that = this;
switch (_that) {
case _TraitsPayload():
return $default(_that.traits,_that.traitsHash);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Trait> traits, @JsonKey(name: 'traits_hash')  String traitsHash)?  $default,) {final _that = this;
switch (_that) {
case _TraitsPayload() when $default != null:
return $default(_that.traits,_that.traitsHash);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TraitsPayload implements TraitsPayload {
  const _TraitsPayload({required  List<Trait> traits, @JsonKey(name: 'traits_hash') required this.traitsHash}): _traits = traits;
  factory _TraitsPayload.fromJson(Map<String, dynamic> json) => _$TraitsPayloadFromJson(json);

 final  List<Trait> _traits;
@override List<Trait> get traits {
  if (_traits is EqualUnmodifiableListView) return _traits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_traits);
}

@override@JsonKey(name: 'traits_hash') final  String traitsHash;

/// Create a copy of TraitsPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TraitsPayloadCopyWith<_TraitsPayload> get copyWith => __$TraitsPayloadCopyWithImpl<_TraitsPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TraitsPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TraitsPayload&&const DeepCollectionEquality().equals(other.traits, _traits)&&(identical(other.traitsHash, traitsHash) || other.traitsHash == traitsHash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_traits),traitsHash);
}

@override
String toString() {
    return 'TraitsPayload(traits: $traits, traitsHash: $traitsHash)';
}


}

/// @nodoc
abstract mixin class _$TraitsPayloadCopyWith<$Res> implements $TraitsPayloadCopyWith<$Res> {
  factory _$TraitsPayloadCopyWith(_TraitsPayload value, $Res Function(_TraitsPayload) _then) = __$TraitsPayloadCopyWithImpl;
@override @useResult
$Res call({
 List<Trait> traits,@JsonKey(name: 'traits_hash') String traitsHash
});




}
/// @nodoc
class __$TraitsPayloadCopyWithImpl<$Res>
    implements _$TraitsPayloadCopyWith<$Res> {
  __$TraitsPayloadCopyWithImpl(this._self, this._then);

  final _TraitsPayload _self;
  final $Res Function(_TraitsPayload) _then;

/// Create a copy of TraitsPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? traits = null,Object? traitsHash = null,}) {
  return _then(_TraitsPayload(
traits: null == traits ? _self._traits : traits // ignore: cast_nullable_to_non_nullable
as List<Trait>,traitsHash: null == traitsHash ? _self.traitsHash : traitsHash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DisputeResult {

 Trait get trait;@JsonKey(name: 'question_id') String get questionId;@JsonKey(name: 'question_text') String get questionText;
/// Create a copy of DisputeResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisputeResultCopyWith<DisputeResult> get copyWith => _$DisputeResultCopyWithImpl<DisputeResult>(this as DisputeResult, _$identity);

  /// Serializes this DisputeResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DisputeResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisputeResult&&(identical(other.trait, _this.trait) || other.trait == _this.trait)&&(identical(other.questionId, _this.questionId) || other.questionId == _this.questionId)&&(identical(other.questionText, _this.questionText) || other.questionText == _this.questionText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DisputeResult;
  return Object.hash(runtimeType,_this.trait,_this.questionId,_this.questionText);
}

@override
String toString() {
  final _this = this as DisputeResult;
  return 'DisputeResult(trait: ${_this.trait}, questionId: ${_this.questionId}, questionText: ${_this.questionText})';
}


}

/// @nodoc
abstract mixin class $DisputeResultCopyWith<$Res>  {
  factory $DisputeResultCopyWith(DisputeResult value, $Res Function(DisputeResult) _then) = _$DisputeResultCopyWithImpl;
@useResult
$Res call({
 Trait trait,@JsonKey(name: 'question_id') String questionId,@JsonKey(name: 'question_text') String questionText
});


$TraitCopyWith<$Res> get trait;

}
/// @nodoc
class _$DisputeResultCopyWithImpl<$Res>
    implements $DisputeResultCopyWith<$Res> {
  _$DisputeResultCopyWithImpl(this._self, this._then);

  final DisputeResult _self;
  final $Res Function(DisputeResult) _then;

/// Create a copy of DisputeResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trait = null,Object? questionId = null,Object? questionText = null,}) {
  return _then(DisputeResult(
trait: null == trait ? _self.trait : trait // ignore: cast_nullable_to_non_nullable
as Trait,questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of DisputeResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TraitCopyWith<$Res> get trait {
  
  return $TraitCopyWith<$Res>(_self.trait, (value) {
    return _then(_self.copyWith(trait: value));
  });
}
}


/// Adds pattern-matching-related methods to [DisputeResult].
extension DisputeResultPatterns on DisputeResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DisputeResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DisputeResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DisputeResult value)  $default,){
final _that = this;
switch (_that) {
case _DisputeResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DisputeResult value)?  $default,){
final _that = this;
switch (_that) {
case _DisputeResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Trait trait, @JsonKey(name: 'question_id')  String questionId, @JsonKey(name: 'question_text')  String questionText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DisputeResult() when $default != null:
return $default(_that.trait,_that.questionId,_that.questionText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Trait trait, @JsonKey(name: 'question_id')  String questionId, @JsonKey(name: 'question_text')  String questionText)  $default,) {final _that = this;
switch (_that) {
case _DisputeResult():
return $default(_that.trait,_that.questionId,_that.questionText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Trait trait, @JsonKey(name: 'question_id')  String questionId, @JsonKey(name: 'question_text')  String questionText)?  $default,) {final _that = this;
switch (_that) {
case _DisputeResult() when $default != null:
return $default(_that.trait,_that.questionId,_that.questionText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DisputeResult implements DisputeResult {
  const _DisputeResult({required this.trait, @JsonKey(name: 'question_id') required this.questionId, @JsonKey(name: 'question_text') required this.questionText});
  factory _DisputeResult.fromJson(Map<String, dynamic> json) => _$DisputeResultFromJson(json);

@override final  Trait trait;
@override@JsonKey(name: 'question_id') final  String questionId;
@override@JsonKey(name: 'question_text') final  String questionText;

/// Create a copy of DisputeResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisputeResultCopyWith<_DisputeResult> get copyWith => __$DisputeResultCopyWithImpl<_DisputeResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DisputeResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisputeResult&&(identical(other.trait, trait) || other.trait == trait)&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.questionText, questionText) || other.questionText == questionText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,trait,questionId,questionText);
}

@override
String toString() {
    return 'DisputeResult(trait: $trait, questionId: $questionId, questionText: $questionText)';
}


}

/// @nodoc
abstract mixin class _$DisputeResultCopyWith<$Res> implements $DisputeResultCopyWith<$Res> {
  factory _$DisputeResultCopyWith(_DisputeResult value, $Res Function(_DisputeResult) _then) = __$DisputeResultCopyWithImpl;
@override @useResult
$Res call({
 Trait trait,@JsonKey(name: 'question_id') String questionId,@JsonKey(name: 'question_text') String questionText
});


@override $TraitCopyWith<$Res> get trait;

}
/// @nodoc
class __$DisputeResultCopyWithImpl<$Res>
    implements _$DisputeResultCopyWith<$Res> {
  __$DisputeResultCopyWithImpl(this._self, this._then);

  final _DisputeResult _self;
  final $Res Function(_DisputeResult) _then;

/// Create a copy of DisputeResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trait = null,Object? questionId = null,Object? questionText = null,}) {
  return _then(_DisputeResult(
trait: null == trait ? _self.trait : trait // ignore: cast_nullable_to_non_nullable
as Trait,questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as String,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of DisputeResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TraitCopyWith<$Res> get trait {
  
  return $TraitCopyWith<$Res>(_self.trait, (value) {
    return _then(_self.copyWith(trait: value));
  });
}
}

// dart format on
