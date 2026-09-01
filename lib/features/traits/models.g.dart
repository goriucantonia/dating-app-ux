// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Trait _$TraitFromJson(Map<String, dynamic> json) => _Trait(
  id: json['id'] as String,
  category: json['category'] as String,
  label: json['label'] as String,
  description: json['description'] as String,
  confidence: (json['confidence'] as num).toDouble(),
  status: json['status'] as String,
  sourceAnswerIds: (json['source_answer_ids'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  extractedBy: json['extracted_by'] as String,
);

Map<String, dynamic> _$TraitToJson(_Trait instance) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category,
  'label': instance.label,
  'description': instance.description,
  'confidence': instance.confidence,
  'status': instance.status,
  'source_answer_ids': instance.sourceAnswerIds,
  'extracted_by': instance.extractedBy,
};

_TraitsPayload _$TraitsPayloadFromJson(Map<String, dynamic> json) =>
    _TraitsPayload(
      traits: (json['traits'] as List<dynamic>)
          .map((e) => Trait.fromJson(e as Map<String, dynamic>))
          .toList(),
      traitsHash: json['traits_hash'] as String,
    );

Map<String, dynamic> _$TraitsPayloadToJson(_TraitsPayload instance) =>
    <String, dynamic>{
      'traits': instance.traits,
      'traits_hash': instance.traitsHash,
    };

_DisputeResult _$DisputeResultFromJson(Map<String, dynamic> json) =>
    _DisputeResult(
      trait: Trait.fromJson(json['trait'] as Map<String, dynamic>),
      questionId: json['question_id'] as String,
      questionText: json['question_text'] as String,
    );

Map<String, dynamic> _$DisputeResultToJson(_DisputeResult instance) =>
    <String, dynamic>{
      'trait': instance.trait,
      'question_id': instance.questionId,
      'question_text': instance.questionText,
    };
