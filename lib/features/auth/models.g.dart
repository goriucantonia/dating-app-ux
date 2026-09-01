// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['display_name'] as String,
  birthDate: json['birth_date'] as String,
  age: (json['age'] as num).toInt(),
  gender: json['gender'] as String,
  interestedIn: (json['interested_in'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  agePrefMin: (json['age_pref_min'] as num).toInt(),
  agePrefMax: (json['age_pref_max'] as num).toInt(),
  city: json['city'] as String?,
  country: json['country'] as String?,
  optIn: json['opt_in'] as bool,
  isDemo: json['is_demo'] as bool,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'display_name': instance.displayName,
  'birth_date': instance.birthDate,
  'age': instance.age,
  'gender': instance.gender,
  'interested_in': instance.interestedIn,
  'age_pref_min': instance.agePrefMin,
  'age_pref_max': instance.agePrefMax,
  'city': instance.city,
  'country': instance.country,
  'opt_in': instance.optIn,
  'is_demo': instance.isDemo,
};
