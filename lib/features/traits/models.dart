import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// `confidence` and `status` come from the SERVER and are never derived here
/// (ux_architecture.md §3). The client showing a different confidence from the
/// one the matching pipeline used would be a lie with a straight face.
@freezed
abstract class Trait with _$Trait {
  const factory Trait({
    required String id,
    required String category,
    required String label,
    required String description,
    required double confidence,
    required String status, // inferred | confirmed | disputed | corrected | retracted
    @JsonKey(name: 'source_answer_ids') required List<String> sourceAnswerIds,
    @JsonKey(name: 'extracted_by') required String extractedBy,
  }) = _Trait;

  factory Trait.fromJson(Map<String, dynamic> json) => _$TraitFromJson(json);
}

@freezed
abstract class TraitsPayload with _$TraitsPayload {
  const factory TraitsPayload({
    required List<Trait> traits,
    @JsonKey(name: 'traits_hash') required String traitsHash,
  }) = _TraitsPayload;

  factory TraitsPayload.fromJson(Map<String, dynamic> json) =>
      _$TraitsPayloadFromJson(json);
}

@freezed
abstract class DisputeResult with _$DisputeResult {
  const factory DisputeResult({
    required Trait trait,
    @JsonKey(name: 'question_id') required String questionId,
    @JsonKey(name: 'question_text') required String questionText,
  }) = _DisputeResult;

  factory DisputeResult.fromJson(Map<String, dynamic> json) =>
      _$DisputeResultFromJson(json);
}

/// The six locked categories, in the order the profile shows them. Interests
/// and qualities first because a profile that opens with your flaws reads as
/// an accusation; flaws are still shown, plainly, just not first.
const traitCategoryOrder = <String>[
  'interest',
  'quality',
  'behavioral',
  'conversational_style',
  'partner_preference',
  'flaw',
];

const traitCategoryLabels = <String, String>{
  'interest': 'What you’re into',
  'quality': 'Your strengths',
  'behavioral': 'How you act',
  'conversational_style': 'How you talk',
  'partner_preference': 'What you want in someone',
  'flaw': 'Your rough edges',
};
