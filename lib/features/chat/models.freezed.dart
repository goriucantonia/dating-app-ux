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
mixin _$ChatMatch {

@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'display_name') String get displayName;@JsonKey(name: 'is_demo') bool get isDemo;
/// Create a copy of ChatMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMatchCopyWith<ChatMatch> get copyWith => _$ChatMatchCopyWithImpl<ChatMatch>(this as ChatMatch, _$identity);

  /// Serializes this ChatMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatMatch;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMatch&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.isDemo, _this.isDemo) || other.isDemo == _this.isDemo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMatch;
  return Object.hash(runtimeType,_this.userId,_this.displayName,_this.isDemo);
}

@override
String toString() {
  final _this = this as ChatMatch;
  return 'ChatMatch(userId: ${_this.userId}, displayName: ${_this.displayName}, isDemo: ${_this.isDemo})';
}


}

/// @nodoc
abstract mixin class $ChatMatchCopyWith<$Res>  {
  factory $ChatMatchCopyWith(ChatMatch value, $Res Function(ChatMatch) _then) = _$ChatMatchCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'display_name') String displayName,@JsonKey(name: 'is_demo') bool isDemo
});




}
/// @nodoc
class _$ChatMatchCopyWithImpl<$Res>
    implements $ChatMatchCopyWith<$Res> {
  _$ChatMatchCopyWithImpl(this._self, this._then);

  final ChatMatch _self;
  final $Res Function(ChatMatch) _then;

/// Create a copy of ChatMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? isDemo = null,}) {
  return _then(ChatMatch(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,isDemo: null == isDemo ? _self.isDemo : isDemo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMatch].
extension ChatMatchPatterns on ChatMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMatch value)  $default,){
final _that = this;
switch (_that) {
case _ChatMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMatch value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'is_demo')  bool isDemo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMatch() when $default != null:
return $default(_that.userId,_that.displayName,_that.isDemo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'is_demo')  bool isDemo)  $default,) {final _that = this;
switch (_that) {
case _ChatMatch():
return $default(_that.userId,_that.displayName,_that.isDemo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'is_demo')  bool isDemo)?  $default,) {final _that = this;
switch (_that) {
case _ChatMatch() when $default != null:
return $default(_that.userId,_that.displayName,_that.isDemo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMatch implements ChatMatch {
  const _ChatMatch({@JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'display_name') required this.displayName, @JsonKey(name: 'is_demo') required this.isDemo});
  factory _ChatMatch.fromJson(Map<String, dynamic> json) => _$ChatMatchFromJson(json);

@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'display_name') final  String displayName;
@override@JsonKey(name: 'is_demo') final  bool isDemo;

/// Create a copy of ChatMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMatchCopyWith<_ChatMatch> get copyWith => __$ChatMatchCopyWithImpl<_ChatMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMatchToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMatch&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.isDemo, isDemo) || other.isDemo == isDemo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,displayName,isDemo);
}

@override
String toString() {
    return 'ChatMatch(userId: $userId, displayName: $displayName, isDemo: $isDemo)';
}


}

/// @nodoc
abstract mixin class _$ChatMatchCopyWith<$Res> implements $ChatMatchCopyWith<$Res> {
  factory _$ChatMatchCopyWith(_ChatMatch value, $Res Function(_ChatMatch) _then) = __$ChatMatchCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'display_name') String displayName,@JsonKey(name: 'is_demo') bool isDemo
});




}
/// @nodoc
class __$ChatMatchCopyWithImpl<$Res>
    implements _$ChatMatchCopyWith<$Res> {
  __$ChatMatchCopyWithImpl(this._self, this._then);

  final _ChatMatch _self;
  final $Res Function(_ChatMatch) _then;

/// Create a copy of ChatMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? isDemo = null,}) {
  return _then(_ChatMatch(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,isDemo: null == isDemo ? _self.isDemo : isDemo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ChatMessageModel {

@JsonKey(name: 'message_id') String get messageId; int get seq; String get sender; String get text;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageModelCopyWith<ChatMessageModel> get copyWith => _$ChatMessageModelCopyWithImpl<ChatMessageModel>(this as ChatMessageModel, _$identity);

  /// Serializes this ChatMessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatMessageModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageModel&&(identical(other.messageId, _this.messageId) || other.messageId == _this.messageId)&&(identical(other.seq, _this.seq) || other.seq == _this.seq)&&(identical(other.sender, _this.sender) || other.sender == _this.sender)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMessageModel;
  return Object.hash(runtimeType,_this.messageId,_this.seq,_this.sender,_this.text,_this.createdAt);
}

@override
String toString() {
  final _this = this as ChatMessageModel;
  return 'ChatMessageModel(messageId: ${_this.messageId}, seq: ${_this.seq}, sender: ${_this.sender}, text: ${_this.text}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ChatMessageModelCopyWith<$Res>  {
  factory $ChatMessageModelCopyWith(ChatMessageModel value, $Res Function(ChatMessageModel) _then) = _$ChatMessageModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'message_id') String messageId, int seq, String sender, String text,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$ChatMessageModelCopyWithImpl<$Res>
    implements $ChatMessageModelCopyWith<$Res> {
  _$ChatMessageModelCopyWithImpl(this._self, this._then);

  final ChatMessageModel _self;
  final $Res Function(ChatMessageModel) _then;

/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? seq = null,Object? sender = null,Object? text = null,Object? createdAt = null,}) {
  return _then(ChatMessageModel(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessageModel].
extension ChatMessageModelPatterns on ChatMessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessageModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'message_id')  String messageId,  int seq,  String sender,  String text, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessageModel() when $default != null:
return $default(_that.messageId,_that.seq,_that.sender,_that.text,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'message_id')  String messageId,  int seq,  String sender,  String text, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _ChatMessageModel():
return $default(_that.messageId,_that.seq,_that.sender,_that.text,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'message_id')  String messageId,  int seq,  String sender,  String text, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessageModel() when $default != null:
return $default(_that.messageId,_that.seq,_that.sender,_that.text,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessageModel implements ChatMessageModel {
  const _ChatMessageModel({@JsonKey(name: 'message_id') required this.messageId, required this.seq, required this.sender, required this.text, @JsonKey(name: 'created_at') this.createdAt = ''});
  factory _ChatMessageModel.fromJson(Map<String, dynamic> json) => _$ChatMessageModelFromJson(json);

@override@JsonKey(name: 'message_id') final  String messageId;
@override final  int seq;
@override final  String sender;
@override final  String text;
@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageModelCopyWith<_ChatMessageModel> get copyWith => __$ChatMessageModelCopyWithImpl<_ChatMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageModel&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,messageId,seq,sender,text,createdAt);
}

@override
String toString() {
    return 'ChatMessageModel(messageId: $messageId, seq: $seq, sender: $sender, text: $text, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageModelCopyWith<$Res> implements $ChatMessageModelCopyWith<$Res> {
  factory _$ChatMessageModelCopyWith(_ChatMessageModel value, $Res Function(_ChatMessageModel) _then) = __$ChatMessageModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'message_id') String messageId, int seq, String sender, String text,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$ChatMessageModelCopyWithImpl<$Res>
    implements _$ChatMessageModelCopyWith<$Res> {
  __$ChatMessageModelCopyWithImpl(this._self, this._then);

  final _ChatMessageModel _self;
  final $Res Function(_ChatMessageModel) _then;

/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? seq = null,Object? sender = null,Object? text = null,Object? createdAt = null,}) {
  return _then(_ChatMessageModel(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ChatSessionSummary {

@JsonKey(name: 'session_id') String get sessionId;@JsonKey(name: 'analysis_id') String get analysisId; ChatMatch get match; String get status;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'ended_at') String? get endedAt;@JsonKey(name: 'last_message') ChatMessageModel? get lastMessage;
/// Create a copy of ChatSessionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSessionSummaryCopyWith<ChatSessionSummary> get copyWith => _$ChatSessionSummaryCopyWithImpl<ChatSessionSummary>(this as ChatSessionSummary, _$identity);

  /// Serializes this ChatSessionSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatSessionSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSessionSummary&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.analysisId, _this.analysisId) || other.analysisId == _this.analysisId)&&(identical(other.match, _this.match) || other.match == _this.match)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.endedAt, _this.endedAt) || other.endedAt == _this.endedAt)&&(identical(other.lastMessage, _this.lastMessage) || other.lastMessage == _this.lastMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatSessionSummary;
  return Object.hash(runtimeType,_this.sessionId,_this.analysisId,_this.match,_this.status,_this.createdAt,_this.endedAt,_this.lastMessage);
}

@override
String toString() {
  final _this = this as ChatSessionSummary;
  return 'ChatSessionSummary(sessionId: ${_this.sessionId}, analysisId: ${_this.analysisId}, match: ${_this.match}, status: ${_this.status}, createdAt: ${_this.createdAt}, endedAt: ${_this.endedAt}, lastMessage: ${_this.lastMessage})';
}


}

/// @nodoc
abstract mixin class $ChatSessionSummaryCopyWith<$Res>  {
  factory $ChatSessionSummaryCopyWith(ChatSessionSummary value, $Res Function(ChatSessionSummary) _then) = _$ChatSessionSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'session_id') String sessionId,@JsonKey(name: 'analysis_id') String analysisId, ChatMatch match, String status,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'ended_at') String? endedAt,@JsonKey(name: 'last_message') ChatMessageModel? lastMessage
});


$ChatMatchCopyWith<$Res> get match;$ChatMessageModelCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class _$ChatSessionSummaryCopyWithImpl<$Res>
    implements $ChatSessionSummaryCopyWith<$Res> {
  _$ChatSessionSummaryCopyWithImpl(this._self, this._then);

  final ChatSessionSummary _self;
  final $Res Function(ChatSessionSummary) _then;

/// Create a copy of ChatSessionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? analysisId = null,Object? match = null,Object? status = null,Object? createdAt = null,Object? endedAt = freezed,Object? lastMessage = freezed,}) {
  return _then(ChatSessionSummary(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,analysisId: null == analysisId ? _self.analysisId : analysisId // ignore: cast_nullable_to_non_nullable
as String,match: null == match ? _self.match : match // ignore: cast_nullable_to_non_nullable
as ChatMatch,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as String?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as ChatMessageModel?,
  ));
}
/// Create a copy of ChatSessionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMatchCopyWith<$Res> get match {
  
  return $ChatMatchCopyWith<$Res>(_self.match, (value) {
    return _then(_self.copyWith(match: value));
  });
}/// Create a copy of ChatSessionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMessageModelCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $ChatMessageModelCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatSessionSummary].
extension ChatSessionSummaryPatterns on ChatSessionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatSessionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatSessionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatSessionSummary value)  $default,){
final _that = this;
switch (_that) {
case _ChatSessionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatSessionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ChatSessionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'session_id')  String sessionId, @JsonKey(name: 'analysis_id')  String analysisId,  ChatMatch match,  String status, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'ended_at')  String? endedAt, @JsonKey(name: 'last_message')  ChatMessageModel? lastMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatSessionSummary() when $default != null:
return $default(_that.sessionId,_that.analysisId,_that.match,_that.status,_that.createdAt,_that.endedAt,_that.lastMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'session_id')  String sessionId, @JsonKey(name: 'analysis_id')  String analysisId,  ChatMatch match,  String status, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'ended_at')  String? endedAt, @JsonKey(name: 'last_message')  ChatMessageModel? lastMessage)  $default,) {final _that = this;
switch (_that) {
case _ChatSessionSummary():
return $default(_that.sessionId,_that.analysisId,_that.match,_that.status,_that.createdAt,_that.endedAt,_that.lastMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'session_id')  String sessionId, @JsonKey(name: 'analysis_id')  String analysisId,  ChatMatch match,  String status, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'ended_at')  String? endedAt, @JsonKey(name: 'last_message')  ChatMessageModel? lastMessage)?  $default,) {final _that = this;
switch (_that) {
case _ChatSessionSummary() when $default != null:
return $default(_that.sessionId,_that.analysisId,_that.match,_that.status,_that.createdAt,_that.endedAt,_that.lastMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatSessionSummary implements ChatSessionSummary {
  const _ChatSessionSummary({@JsonKey(name: 'session_id') required this.sessionId, @JsonKey(name: 'analysis_id') required this.analysisId, required this.match, required this.status, @JsonKey(name: 'created_at') this.createdAt = '', @JsonKey(name: 'ended_at') this.endedAt, @JsonKey(name: 'last_message') this.lastMessage});
  factory _ChatSessionSummary.fromJson(Map<String, dynamic> json) => _$ChatSessionSummaryFromJson(json);

@override@JsonKey(name: 'session_id') final  String sessionId;
@override@JsonKey(name: 'analysis_id') final  String analysisId;
@override final  ChatMatch match;
@override final  String status;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'ended_at') final  String? endedAt;
@override@JsonKey(name: 'last_message') final  ChatMessageModel? lastMessage;

/// Create a copy of ChatSessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatSessionSummaryCopyWith<_ChatSessionSummary> get copyWith => __$ChatSessionSummaryCopyWithImpl<_ChatSessionSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatSessionSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatSessionSummary&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.analysisId, analysisId) || other.analysisId == analysisId)&&(identical(other.match, match) || other.match == match)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,analysisId,match,status,createdAt,endedAt,lastMessage);
}

@override
String toString() {
    return 'ChatSessionSummary(sessionId: $sessionId, analysisId: $analysisId, match: $match, status: $status, createdAt: $createdAt, endedAt: $endedAt, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class _$ChatSessionSummaryCopyWith<$Res> implements $ChatSessionSummaryCopyWith<$Res> {
  factory _$ChatSessionSummaryCopyWith(_ChatSessionSummary value, $Res Function(_ChatSessionSummary) _then) = __$ChatSessionSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'session_id') String sessionId,@JsonKey(name: 'analysis_id') String analysisId, ChatMatch match, String status,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'ended_at') String? endedAt,@JsonKey(name: 'last_message') ChatMessageModel? lastMessage
});


@override $ChatMatchCopyWith<$Res> get match;@override $ChatMessageModelCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class __$ChatSessionSummaryCopyWithImpl<$Res>
    implements _$ChatSessionSummaryCopyWith<$Res> {
  __$ChatSessionSummaryCopyWithImpl(this._self, this._then);

  final _ChatSessionSummary _self;
  final $Res Function(_ChatSessionSummary) _then;

/// Create a copy of ChatSessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? analysisId = null,Object? match = null,Object? status = null,Object? createdAt = null,Object? endedAt = freezed,Object? lastMessage = freezed,}) {
  return _then(_ChatSessionSummary(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,analysisId: null == analysisId ? _self.analysisId : analysisId // ignore: cast_nullable_to_non_nullable
as String,match: null == match ? _self.match : match // ignore: cast_nullable_to_non_nullable
as ChatMatch,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as String?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as ChatMessageModel?,
  ));
}

/// Create a copy of ChatSessionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMatchCopyWith<$Res> get match {
  
  return $ChatMatchCopyWith<$Res>(_self.match, (value) {
    return _then(_self.copyWith(match: value));
  });
}/// Create a copy of ChatSessionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMessageModelCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $ChatMessageModelCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// @nodoc
mixin _$ChatSessionDetail {

@JsonKey(name: 'session_id') String get sessionId;@JsonKey(name: 'analysis_id') String get analysisId; ChatMatch get match; String get status;@JsonKey(name: 'trait_labels') Map<String, List<String>> get traitLabels;@JsonKey(name: 'date_digest') String get dateDigest;@JsonKey(name: 'snapshot_id') String get snapshotId;
/// Create a copy of ChatSessionDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSessionDetailCopyWith<ChatSessionDetail> get copyWith => _$ChatSessionDetailCopyWithImpl<ChatSessionDetail>(this as ChatSessionDetail, _$identity);

  /// Serializes this ChatSessionDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatSessionDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSessionDetail&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.analysisId, _this.analysisId) || other.analysisId == _this.analysisId)&&(identical(other.match, _this.match) || other.match == _this.match)&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.traitLabels, _this.traitLabels)&&(identical(other.dateDigest, _this.dateDigest) || other.dateDigest == _this.dateDigest)&&(identical(other.snapshotId, _this.snapshotId) || other.snapshotId == _this.snapshotId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatSessionDetail;
  return Object.hash(runtimeType,_this.sessionId,_this.analysisId,_this.match,_this.status,const DeepCollectionEquality().hash(_this.traitLabels),_this.dateDigest,_this.snapshotId);
}

@override
String toString() {
  final _this = this as ChatSessionDetail;
  return 'ChatSessionDetail(sessionId: ${_this.sessionId}, analysisId: ${_this.analysisId}, match: ${_this.match}, status: ${_this.status}, traitLabels: ${_this.traitLabels}, dateDigest: ${_this.dateDigest}, snapshotId: ${_this.snapshotId})';
}


}

/// @nodoc
abstract mixin class $ChatSessionDetailCopyWith<$Res>  {
  factory $ChatSessionDetailCopyWith(ChatSessionDetail value, $Res Function(ChatSessionDetail) _then) = _$ChatSessionDetailCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'session_id') String sessionId,@JsonKey(name: 'analysis_id') String analysisId, ChatMatch match, String status,@JsonKey(name: 'trait_labels') Map<String, List<String>> traitLabels,@JsonKey(name: 'date_digest') String dateDigest,@JsonKey(name: 'snapshot_id') String snapshotId
});


$ChatMatchCopyWith<$Res> get match;

}
/// @nodoc
class _$ChatSessionDetailCopyWithImpl<$Res>
    implements $ChatSessionDetailCopyWith<$Res> {
  _$ChatSessionDetailCopyWithImpl(this._self, this._then);

  final ChatSessionDetail _self;
  final $Res Function(ChatSessionDetail) _then;

/// Create a copy of ChatSessionDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? analysisId = null,Object? match = null,Object? status = null,Object? traitLabels = null,Object? dateDigest = null,Object? snapshotId = null,}) {
  return _then(ChatSessionDetail(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,analysisId: null == analysisId ? _self.analysisId : analysisId // ignore: cast_nullable_to_non_nullable
as String,match: null == match ? _self.match : match // ignore: cast_nullable_to_non_nullable
as ChatMatch,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,traitLabels: null == traitLabels ? _self.traitLabels : traitLabels // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,dateDigest: null == dateDigest ? _self.dateDigest : dateDigest // ignore: cast_nullable_to_non_nullable
as String,snapshotId: null == snapshotId ? _self.snapshotId : snapshotId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ChatSessionDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMatchCopyWith<$Res> get match {
  
  return $ChatMatchCopyWith<$Res>(_self.match, (value) {
    return _then(_self.copyWith(match: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatSessionDetail].
extension ChatSessionDetailPatterns on ChatSessionDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatSessionDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatSessionDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatSessionDetail value)  $default,){
final _that = this;
switch (_that) {
case _ChatSessionDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatSessionDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ChatSessionDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'session_id')  String sessionId, @JsonKey(name: 'analysis_id')  String analysisId,  ChatMatch match,  String status, @JsonKey(name: 'trait_labels')  Map<String, List<String>> traitLabels, @JsonKey(name: 'date_digest')  String dateDigest, @JsonKey(name: 'snapshot_id')  String snapshotId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatSessionDetail() when $default != null:
return $default(_that.sessionId,_that.analysisId,_that.match,_that.status,_that.traitLabels,_that.dateDigest,_that.snapshotId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'session_id')  String sessionId, @JsonKey(name: 'analysis_id')  String analysisId,  ChatMatch match,  String status, @JsonKey(name: 'trait_labels')  Map<String, List<String>> traitLabels, @JsonKey(name: 'date_digest')  String dateDigest, @JsonKey(name: 'snapshot_id')  String snapshotId)  $default,) {final _that = this;
switch (_that) {
case _ChatSessionDetail():
return $default(_that.sessionId,_that.analysisId,_that.match,_that.status,_that.traitLabels,_that.dateDigest,_that.snapshotId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'session_id')  String sessionId, @JsonKey(name: 'analysis_id')  String analysisId,  ChatMatch match,  String status, @JsonKey(name: 'trait_labels')  Map<String, List<String>> traitLabels, @JsonKey(name: 'date_digest')  String dateDigest, @JsonKey(name: 'snapshot_id')  String snapshotId)?  $default,) {final _that = this;
switch (_that) {
case _ChatSessionDetail() when $default != null:
return $default(_that.sessionId,_that.analysisId,_that.match,_that.status,_that.traitLabels,_that.dateDigest,_that.snapshotId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatSessionDetail implements ChatSessionDetail {
  const _ChatSessionDetail({@JsonKey(name: 'session_id') required this.sessionId, @JsonKey(name: 'analysis_id') required this.analysisId, required this.match, required this.status, @JsonKey(name: 'trait_labels')  Map<String, List<String>> traitLabels = const <String, List<String>>{}, @JsonKey(name: 'date_digest') this.dateDigest = '', @JsonKey(name: 'snapshot_id') this.snapshotId = ''}): _traitLabels = traitLabels;
  factory _ChatSessionDetail.fromJson(Map<String, dynamic> json) => _$ChatSessionDetailFromJson(json);

@override@JsonKey(name: 'session_id') final  String sessionId;
@override@JsonKey(name: 'analysis_id') final  String analysisId;
@override final  ChatMatch match;
@override final  String status;
 final  Map<String, List<String>> _traitLabels;
@override@JsonKey(name: 'trait_labels') Map<String, List<String>> get traitLabels {
  if (_traitLabels is EqualUnmodifiableMapView) return _traitLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_traitLabels);
}

@override@JsonKey(name: 'date_digest') final  String dateDigest;
@override@JsonKey(name: 'snapshot_id') final  String snapshotId;

/// Create a copy of ChatSessionDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatSessionDetailCopyWith<_ChatSessionDetail> get copyWith => __$ChatSessionDetailCopyWithImpl<_ChatSessionDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatSessionDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatSessionDetail&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.analysisId, analysisId) || other.analysisId == analysisId)&&(identical(other.match, match) || other.match == match)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.traitLabels, _traitLabels)&&(identical(other.dateDigest, dateDigest) || other.dateDigest == dateDigest)&&(identical(other.snapshotId, snapshotId) || other.snapshotId == snapshotId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,analysisId,match,status,const DeepCollectionEquality().hash(_traitLabels),dateDigest,snapshotId);
}

@override
String toString() {
    return 'ChatSessionDetail(sessionId: $sessionId, analysisId: $analysisId, match: $match, status: $status, traitLabels: $traitLabels, dateDigest: $dateDigest, snapshotId: $snapshotId)';
}


}

/// @nodoc
abstract mixin class _$ChatSessionDetailCopyWith<$Res> implements $ChatSessionDetailCopyWith<$Res> {
  factory _$ChatSessionDetailCopyWith(_ChatSessionDetail value, $Res Function(_ChatSessionDetail) _then) = __$ChatSessionDetailCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'session_id') String sessionId,@JsonKey(name: 'analysis_id') String analysisId, ChatMatch match, String status,@JsonKey(name: 'trait_labels') Map<String, List<String>> traitLabels,@JsonKey(name: 'date_digest') String dateDigest,@JsonKey(name: 'snapshot_id') String snapshotId
});


@override $ChatMatchCopyWith<$Res> get match;

}
/// @nodoc
class __$ChatSessionDetailCopyWithImpl<$Res>
    implements _$ChatSessionDetailCopyWith<$Res> {
  __$ChatSessionDetailCopyWithImpl(this._self, this._then);

  final _ChatSessionDetail _self;
  final $Res Function(_ChatSessionDetail) _then;

/// Create a copy of ChatSessionDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? analysisId = null,Object? match = null,Object? status = null,Object? traitLabels = null,Object? dateDigest = null,Object? snapshotId = null,}) {
  return _then(_ChatSessionDetail(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,analysisId: null == analysisId ? _self.analysisId : analysisId // ignore: cast_nullable_to_non_nullable
as String,match: null == match ? _self.match : match // ignore: cast_nullable_to_non_nullable
as ChatMatch,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,traitLabels: null == traitLabels ? _self._traitLabels : traitLabels // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,dateDigest: null == dateDigest ? _self.dateDigest : dateDigest // ignore: cast_nullable_to_non_nullable
as String,snapshotId: null == snapshotId ? _self.snapshotId : snapshotId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ChatSessionDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMatchCopyWith<$Res> get match {
  
  return $ChatMatchCopyWith<$Res>(_self.match, (value) {
    return _then(_self.copyWith(match: value));
  });
}
}


/// @nodoc
mixin _$MessagesPage {

 List<ChatMessageModel> get messages;@JsonKey(name: 'has_more') bool get hasMore;@JsonKey(name: 'next_after_seq') int get nextAfterSeq;
/// Create a copy of MessagesPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessagesPageCopyWith<MessagesPage> get copyWith => _$MessagesPageCopyWithImpl<MessagesPage>(this as MessagesPage, _$identity);

  /// Serializes this MessagesPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MessagesPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessagesPage&&const DeepCollectionEquality().equals(other.messages, _this.messages)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.nextAfterSeq, _this.nextAfterSeq) || other.nextAfterSeq == _this.nextAfterSeq));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MessagesPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.messages),_this.hasMore,_this.nextAfterSeq);
}

@override
String toString() {
  final _this = this as MessagesPage;
  return 'MessagesPage(messages: ${_this.messages}, hasMore: ${_this.hasMore}, nextAfterSeq: ${_this.nextAfterSeq})';
}


}

/// @nodoc
abstract mixin class $MessagesPageCopyWith<$Res>  {
  factory $MessagesPageCopyWith(MessagesPage value, $Res Function(MessagesPage) _then) = _$MessagesPageCopyWithImpl;
@useResult
$Res call({
 List<ChatMessageModel> messages,@JsonKey(name: 'has_more') bool hasMore,@JsonKey(name: 'next_after_seq') int nextAfterSeq
});




}
/// @nodoc
class _$MessagesPageCopyWithImpl<$Res>
    implements $MessagesPageCopyWith<$Res> {
  _$MessagesPageCopyWithImpl(this._self, this._then);

  final MessagesPage _self;
  final $Res Function(MessagesPage) _then;

/// Create a copy of MessagesPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? hasMore = null,Object? nextAfterSeq = null,}) {
  return _then(MessagesPage(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextAfterSeq: null == nextAfterSeq ? _self.nextAfterSeq : nextAfterSeq // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MessagesPage].
extension MessagesPagePatterns on MessagesPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessagesPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessagesPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessagesPage value)  $default,){
final _that = this;
switch (_that) {
case _MessagesPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessagesPage value)?  $default,){
final _that = this;
switch (_that) {
case _MessagesPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatMessageModel> messages, @JsonKey(name: 'has_more')  bool hasMore, @JsonKey(name: 'next_after_seq')  int nextAfterSeq)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessagesPage() when $default != null:
return $default(_that.messages,_that.hasMore,_that.nextAfterSeq);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatMessageModel> messages, @JsonKey(name: 'has_more')  bool hasMore, @JsonKey(name: 'next_after_seq')  int nextAfterSeq)  $default,) {final _that = this;
switch (_that) {
case _MessagesPage():
return $default(_that.messages,_that.hasMore,_that.nextAfterSeq);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatMessageModel> messages, @JsonKey(name: 'has_more')  bool hasMore, @JsonKey(name: 'next_after_seq')  int nextAfterSeq)?  $default,) {final _that = this;
switch (_that) {
case _MessagesPage() when $default != null:
return $default(_that.messages,_that.hasMore,_that.nextAfterSeq);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessagesPage implements MessagesPage {
  const _MessagesPage({ List<ChatMessageModel> messages = const <ChatMessageModel>[], @JsonKey(name: 'has_more') this.hasMore = false, @JsonKey(name: 'next_after_seq') this.nextAfterSeq = 0}): _messages = messages;
  factory _MessagesPage.fromJson(Map<String, dynamic> json) => _$MessagesPageFromJson(json);

 final  List<ChatMessageModel> _messages;
@override@JsonKey() List<ChatMessageModel> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey(name: 'has_more') final  bool hasMore;
@override@JsonKey(name: 'next_after_seq') final  int nextAfterSeq;

/// Create a copy of MessagesPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessagesPageCopyWith<_MessagesPage> get copyWith => __$MessagesPageCopyWithImpl<_MessagesPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessagesPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessagesPage&&const DeepCollectionEquality().equals(other.messages, _messages)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextAfterSeq, nextAfterSeq) || other.nextAfterSeq == nextAfterSeq));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),hasMore,nextAfterSeq);
}

@override
String toString() {
    return 'MessagesPage(messages: $messages, hasMore: $hasMore, nextAfterSeq: $nextAfterSeq)';
}


}

/// @nodoc
abstract mixin class _$MessagesPageCopyWith<$Res> implements $MessagesPageCopyWith<$Res> {
  factory _$MessagesPageCopyWith(_MessagesPage value, $Res Function(_MessagesPage) _then) = __$MessagesPageCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessageModel> messages,@JsonKey(name: 'has_more') bool hasMore,@JsonKey(name: 'next_after_seq') int nextAfterSeq
});




}
/// @nodoc
class __$MessagesPageCopyWithImpl<$Res>
    implements _$MessagesPageCopyWith<$Res> {
  __$MessagesPageCopyWithImpl(this._self, this._then);

  final _MessagesPage _self;
  final $Res Function(_MessagesPage) _then;

/// Create a copy of MessagesPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? hasMore = null,Object? nextAfterSeq = null,}) {
  return _then(_MessagesPage(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextAfterSeq: null == nextAfterSeq ? _self.nextAfterSeq : nextAfterSeq // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ReplyResult {

@JsonKey(name: 'user_message') ChatMessageModel get userMessage;@JsonKey(name: 'persona_message') ChatMessageModel get personaMessage; bool get compacted;
/// Create a copy of ReplyResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplyResultCopyWith<ReplyResult> get copyWith => _$ReplyResultCopyWithImpl<ReplyResult>(this as ReplyResult, _$identity);

  /// Serializes this ReplyResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReplyResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplyResult&&(identical(other.userMessage, _this.userMessage) || other.userMessage == _this.userMessage)&&(identical(other.personaMessage, _this.personaMessage) || other.personaMessage == _this.personaMessage)&&(identical(other.compacted, _this.compacted) || other.compacted == _this.compacted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReplyResult;
  return Object.hash(runtimeType,_this.userMessage,_this.personaMessage,_this.compacted);
}

@override
String toString() {
  final _this = this as ReplyResult;
  return 'ReplyResult(userMessage: ${_this.userMessage}, personaMessage: ${_this.personaMessage}, compacted: ${_this.compacted})';
}


}

/// @nodoc
abstract mixin class $ReplyResultCopyWith<$Res>  {
  factory $ReplyResultCopyWith(ReplyResult value, $Res Function(ReplyResult) _then) = _$ReplyResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_message') ChatMessageModel userMessage,@JsonKey(name: 'persona_message') ChatMessageModel personaMessage, bool compacted
});


$ChatMessageModelCopyWith<$Res> get userMessage;$ChatMessageModelCopyWith<$Res> get personaMessage;

}
/// @nodoc
class _$ReplyResultCopyWithImpl<$Res>
    implements $ReplyResultCopyWith<$Res> {
  _$ReplyResultCopyWithImpl(this._self, this._then);

  final ReplyResult _self;
  final $Res Function(ReplyResult) _then;

/// Create a copy of ReplyResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userMessage = null,Object? personaMessage = null,Object? compacted = null,}) {
  return _then(ReplyResult(
userMessage: null == userMessage ? _self.userMessage : userMessage // ignore: cast_nullable_to_non_nullable
as ChatMessageModel,personaMessage: null == personaMessage ? _self.personaMessage : personaMessage // ignore: cast_nullable_to_non_nullable
as ChatMessageModel,compacted: null == compacted ? _self.compacted : compacted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ReplyResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMessageModelCopyWith<$Res> get userMessage {
  
  return $ChatMessageModelCopyWith<$Res>(_self.userMessage, (value) {
    return _then(_self.copyWith(userMessage: value));
  });
}/// Create a copy of ReplyResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMessageModelCopyWith<$Res> get personaMessage {
  
  return $ChatMessageModelCopyWith<$Res>(_self.personaMessage, (value) {
    return _then(_self.copyWith(personaMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReplyResult].
extension ReplyResultPatterns on ReplyResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplyResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplyResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplyResult value)  $default,){
final _that = this;
switch (_that) {
case _ReplyResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplyResult value)?  $default,){
final _that = this;
switch (_that) {
case _ReplyResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_message')  ChatMessageModel userMessage, @JsonKey(name: 'persona_message')  ChatMessageModel personaMessage,  bool compacted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplyResult() when $default != null:
return $default(_that.userMessage,_that.personaMessage,_that.compacted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_message')  ChatMessageModel userMessage, @JsonKey(name: 'persona_message')  ChatMessageModel personaMessage,  bool compacted)  $default,) {final _that = this;
switch (_that) {
case _ReplyResult():
return $default(_that.userMessage,_that.personaMessage,_that.compacted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_message')  ChatMessageModel userMessage, @JsonKey(name: 'persona_message')  ChatMessageModel personaMessage,  bool compacted)?  $default,) {final _that = this;
switch (_that) {
case _ReplyResult() when $default != null:
return $default(_that.userMessage,_that.personaMessage,_that.compacted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplyResult implements ReplyResult {
  const _ReplyResult({@JsonKey(name: 'user_message') required this.userMessage, @JsonKey(name: 'persona_message') required this.personaMessage, this.compacted = false});
  factory _ReplyResult.fromJson(Map<String, dynamic> json) => _$ReplyResultFromJson(json);

@override@JsonKey(name: 'user_message') final  ChatMessageModel userMessage;
@override@JsonKey(name: 'persona_message') final  ChatMessageModel personaMessage;
@override@JsonKey() final  bool compacted;

/// Create a copy of ReplyResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplyResultCopyWith<_ReplyResult> get copyWith => __$ReplyResultCopyWithImpl<_ReplyResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplyResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplyResult&&(identical(other.userMessage, userMessage) || other.userMessage == userMessage)&&(identical(other.personaMessage, personaMessage) || other.personaMessage == personaMessage)&&(identical(other.compacted, compacted) || other.compacted == compacted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userMessage,personaMessage,compacted);
}

@override
String toString() {
    return 'ReplyResult(userMessage: $userMessage, personaMessage: $personaMessage, compacted: $compacted)';
}


}

/// @nodoc
abstract mixin class _$ReplyResultCopyWith<$Res> implements $ReplyResultCopyWith<$Res> {
  factory _$ReplyResultCopyWith(_ReplyResult value, $Res Function(_ReplyResult) _then) = __$ReplyResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_message') ChatMessageModel userMessage,@JsonKey(name: 'persona_message') ChatMessageModel personaMessage, bool compacted
});


@override $ChatMessageModelCopyWith<$Res> get userMessage;@override $ChatMessageModelCopyWith<$Res> get personaMessage;

}
/// @nodoc
class __$ReplyResultCopyWithImpl<$Res>
    implements _$ReplyResultCopyWith<$Res> {
  __$ReplyResultCopyWithImpl(this._self, this._then);

  final _ReplyResult _self;
  final $Res Function(_ReplyResult) _then;

/// Create a copy of ReplyResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userMessage = null,Object? personaMessage = null,Object? compacted = null,}) {
  return _then(_ReplyResult(
userMessage: null == userMessage ? _self.userMessage : userMessage // ignore: cast_nullable_to_non_nullable
as ChatMessageModel,personaMessage: null == personaMessage ? _self.personaMessage : personaMessage // ignore: cast_nullable_to_non_nullable
as ChatMessageModel,compacted: null == compacted ? _self.compacted : compacted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ReplyResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMessageModelCopyWith<$Res> get userMessage {
  
  return $ChatMessageModelCopyWith<$Res>(_self.userMessage, (value) {
    return _then(_self.copyWith(userMessage: value));
  });
}/// Create a copy of ReplyResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMessageModelCopyWith<$Res> get personaMessage {
  
  return $ChatMessageModelCopyWith<$Res>(_self.personaMessage, (value) {
    return _then(_self.copyWith(personaMessage: value));
  });
}
}

// dart format on
