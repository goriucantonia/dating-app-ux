import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// Mirror of the server's UserOut payload. Unknown JSON fields are ignored by
/// convention (communication_protocol.md §7 — additive changes are safe).
/// `isDemo` is always present when a user is rendered (§6).
@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String email,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'birth_date') required String birthDate,
    required int age,
    required String gender,
    @JsonKey(name: 'interested_in') required List<String> interestedIn,
    @JsonKey(name: 'age_pref_min') required int agePrefMin,
    @JsonKey(name: 'age_pref_max') required int agePrefMax,
    String? city,
    String? country,
    @JsonKey(name: 'opt_in') required bool optIn,
    @JsonKey(name: 'is_demo') required bool isDemo,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

/// The registration form's payload — the exact A1 field set.
class RegisterData {
  RegisterData({
    required this.email,
    required this.password,
    required this.displayName,
    required this.birthDate,
    required this.gender,
    required this.interestedIn,
    required this.agePrefMin,
    required this.agePrefMax,
    this.city,
    this.country,
    required this.optIn,
  });

  final String email;
  final String password;
  final String displayName;
  final DateTime birthDate;
  final String gender;
  final List<String> interestedIn;
  final int agePrefMin;
  final int agePrefMax;
  final String? city;
  final String? country;
  final bool optIn;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'display_name': displayName,
        'birth_date':
            '${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}',
        'gender': gender,
        'interested_in': interestedIn,
        'age_pref_min': agePrefMin,
        'age_pref_max': agePrefMax,
        if (city != null && city!.isNotEmpty) 'city': city,
        if (country != null && country!.isNotEmpty) 'country': country,
        'opt_in': optIn,
      };
}

const genderValues = ['man', 'woman', 'nonbinary', 'other'];
