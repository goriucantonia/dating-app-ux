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
mixin _$User {

 String get id; String get email;@JsonKey(name: 'display_name') String get displayName;@JsonKey(name: 'birth_date') String get birthDate; int get age; String get gender;@JsonKey(name: 'interested_in') List<String> get interestedIn;@JsonKey(name: 'age_pref_min') int get agePrefMin;@JsonKey(name: 'age_pref_max') int get agePrefMax; String? get city; String? get country;@JsonKey(name: 'opt_in') bool get optIn;@JsonKey(name: 'is_demo') bool get isDemo;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as User;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.birthDate, _this.birthDate) || other.birthDate == _this.birthDate)&&(identical(other.age, _this.age) || other.age == _this.age)&&(identical(other.gender, _this.gender) || other.gender == _this.gender)&&const DeepCollectionEquality().equals(other.interestedIn, _this.interestedIn)&&(identical(other.agePrefMin, _this.agePrefMin) || other.agePrefMin == _this.agePrefMin)&&(identical(other.agePrefMax, _this.agePrefMax) || other.agePrefMax == _this.agePrefMax)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.country, _this.country) || other.country == _this.country)&&(identical(other.optIn, _this.optIn) || other.optIn == _this.optIn)&&(identical(other.isDemo, _this.isDemo) || other.isDemo == _this.isDemo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as User;
  return Object.hash(runtimeType,_this.id,_this.email,_this.displayName,_this.birthDate,_this.age,_this.gender,const DeepCollectionEquality().hash(_this.interestedIn),_this.agePrefMin,_this.agePrefMax,_this.city,_this.country,_this.optIn,_this.isDemo);
}

@override
String toString() {
  final _this = this as User;
  return 'User(id: ${_this.id}, email: ${_this.email}, displayName: ${_this.displayName}, birthDate: ${_this.birthDate}, age: ${_this.age}, gender: ${_this.gender}, interestedIn: ${_this.interestedIn}, agePrefMin: ${_this.agePrefMin}, agePrefMax: ${_this.agePrefMax}, city: ${_this.city}, country: ${_this.country}, optIn: ${_this.optIn}, isDemo: ${_this.isDemo})';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 String id, String email,@JsonKey(name: 'display_name') String displayName,@JsonKey(name: 'birth_date') String birthDate, int age, String gender,@JsonKey(name: 'interested_in') List<String> interestedIn,@JsonKey(name: 'age_pref_min') int agePrefMin,@JsonKey(name: 'age_pref_max') int agePrefMax, String? city, String? country,@JsonKey(name: 'opt_in') bool optIn,@JsonKey(name: 'is_demo') bool isDemo
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? birthDate = null,Object? age = null,Object? gender = null,Object? interestedIn = null,Object? agePrefMin = null,Object? agePrefMax = null,Object? city = freezed,Object? country = freezed,Object? optIn = null,Object? isDemo = null,}) {
  return _then(User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,interestedIn: null == interestedIn ? _self.interestedIn : interestedIn // ignore: cast_nullable_to_non_nullable
as List<String>,agePrefMin: null == agePrefMin ? _self.agePrefMin : agePrefMin // ignore: cast_nullable_to_non_nullable
as int,agePrefMax: null == agePrefMax ? _self.agePrefMax : agePrefMax // ignore: cast_nullable_to_non_nullable
as int,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,optIn: null == optIn ? _self.optIn : optIn // ignore: cast_nullable_to_non_nullable
as bool,isDemo: null == isDemo ? _self.isDemo : isDemo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'birth_date')  String birthDate,  int age,  String gender, @JsonKey(name: 'interested_in')  List<String> interestedIn, @JsonKey(name: 'age_pref_min')  int agePrefMin, @JsonKey(name: 'age_pref_max')  int agePrefMax,  String? city,  String? country, @JsonKey(name: 'opt_in')  bool optIn, @JsonKey(name: 'is_demo')  bool isDemo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.birthDate,_that.age,_that.gender,_that.interestedIn,_that.agePrefMin,_that.agePrefMax,_that.city,_that.country,_that.optIn,_that.isDemo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'birth_date')  String birthDate,  int age,  String gender, @JsonKey(name: 'interested_in')  List<String> interestedIn, @JsonKey(name: 'age_pref_min')  int agePrefMin, @JsonKey(name: 'age_pref_max')  int agePrefMax,  String? city,  String? country, @JsonKey(name: 'opt_in')  bool optIn, @JsonKey(name: 'is_demo')  bool isDemo)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.id,_that.email,_that.displayName,_that.birthDate,_that.age,_that.gender,_that.interestedIn,_that.agePrefMin,_that.agePrefMax,_that.city,_that.country,_that.optIn,_that.isDemo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'birth_date')  String birthDate,  int age,  String gender, @JsonKey(name: 'interested_in')  List<String> interestedIn, @JsonKey(name: 'age_pref_min')  int agePrefMin, @JsonKey(name: 'age_pref_max')  int agePrefMax,  String? city,  String? country, @JsonKey(name: 'opt_in')  bool optIn, @JsonKey(name: 'is_demo')  bool isDemo)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.birthDate,_that.age,_that.gender,_that.interestedIn,_that.agePrefMin,_that.agePrefMax,_that.city,_that.country,_that.optIn,_that.isDemo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User implements User {
  const _User({required this.id, required this.email, @JsonKey(name: 'display_name') required this.displayName, @JsonKey(name: 'birth_date') required this.birthDate, required this.age, required this.gender, @JsonKey(name: 'interested_in') required  List<String> interestedIn, @JsonKey(name: 'age_pref_min') required this.agePrefMin, @JsonKey(name: 'age_pref_max') required this.agePrefMax, this.city, this.country, @JsonKey(name: 'opt_in') required this.optIn, @JsonKey(name: 'is_demo') required this.isDemo}): _interestedIn = interestedIn;
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  String id;
@override final  String email;
@override@JsonKey(name: 'display_name') final  String displayName;
@override@JsonKey(name: 'birth_date') final  String birthDate;
@override final  int age;
@override final  String gender;
 final  List<String> _interestedIn;
@override@JsonKey(name: 'interested_in') List<String> get interestedIn {
  if (_interestedIn is EqualUnmodifiableListView) return _interestedIn;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interestedIn);
}

@override@JsonKey(name: 'age_pref_min') final  int agePrefMin;
@override@JsonKey(name: 'age_pref_max') final  int agePrefMax;
@override final  String? city;
@override final  String? country;
@override@JsonKey(name: 'opt_in') final  bool optIn;
@override@JsonKey(name: 'is_demo') final  bool isDemo;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&const DeepCollectionEquality().equals(other.interestedIn, _interestedIn)&&(identical(other.agePrefMin, agePrefMin) || other.agePrefMin == agePrefMin)&&(identical(other.agePrefMax, agePrefMax) || other.agePrefMax == agePrefMax)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.optIn, optIn) || other.optIn == optIn)&&(identical(other.isDemo, isDemo) || other.isDemo == isDemo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,email,displayName,birthDate,age,gender,const DeepCollectionEquality().hash(_interestedIn),agePrefMin,agePrefMax,city,country,optIn,isDemo);
}

@override
String toString() {
    return 'User(id: $id, email: $email, displayName: $displayName, birthDate: $birthDate, age: $age, gender: $gender, interestedIn: $interestedIn, agePrefMin: $agePrefMin, agePrefMax: $agePrefMax, city: $city, country: $country, optIn: $optIn, isDemo: $isDemo)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 String id, String email,@JsonKey(name: 'display_name') String displayName,@JsonKey(name: 'birth_date') String birthDate, int age, String gender,@JsonKey(name: 'interested_in') List<String> interestedIn,@JsonKey(name: 'age_pref_min') int agePrefMin,@JsonKey(name: 'age_pref_max') int agePrefMax, String? city, String? country,@JsonKey(name: 'opt_in') bool optIn,@JsonKey(name: 'is_demo') bool isDemo
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? birthDate = null,Object? age = null,Object? gender = null,Object? interestedIn = null,Object? agePrefMin = null,Object? agePrefMax = null,Object? city = freezed,Object? country = freezed,Object? optIn = null,Object? isDemo = null,}) {
  return _then(_User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,interestedIn: null == interestedIn ? _self._interestedIn : interestedIn // ignore: cast_nullable_to_non_nullable
as List<String>,agePrefMin: null == agePrefMin ? _self.agePrefMin : agePrefMin // ignore: cast_nullable_to_non_nullable
as int,agePrefMax: null == agePrefMax ? _self.agePrefMax : agePrefMax // ignore: cast_nullable_to_non_nullable
as int,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,optIn: null == optIn ? _self.optIn : optIn // ignore: cast_nullable_to_non_nullable
as bool,isDemo: null == isDemo ? _self.isDemo : isDemo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
