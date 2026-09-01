// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Question _$QuestionFromJson(Map<String, dynamic> json) => _Question(
  id: json['id'] as String,
  origin: json['origin'] as String,
  code: json['code'] as String?,
  poolOrder: (json['pool_order'] as num?)?.toInt(),
  probeArea: json['probe_area'] as String,
  text: json['text'] as String,
  answered: json['answered'] as bool,
  answerText: json['answer_text'] as String?,
  answerUpdatedAt: json['answer_updated_at'] as String?,
);

Map<String, dynamic> _$QuestionToJson(_Question instance) => <String, dynamic>{
  'id': instance.id,
  'origin': instance.origin,
  'code': instance.code,
  'pool_order': instance.poolOrder,
  'probe_area': instance.probeArea,
  'text': instance.text,
  'answered': instance.answered,
  'answer_text': instance.answerText,
  'answer_updated_at': instance.answerUpdatedAt,
};

_PoolProgress _$PoolProgressFromJson(Map<String, dynamic> json) =>
    _PoolProgress(
      answeredPool: (json['answered_pool'] as num).toInt(),
      totalPool: (json['total_pool'] as num).toInt(),
    );

Map<String, dynamic> _$PoolProgressToJson(_PoolProgress instance) =>
    <String, dynamic>{
      'answered_pool': instance.answeredPool,
      'total_pool': instance.totalPool,
    };

_NextBatch _$NextBatchFromJson(Map<String, dynamic> json) => _NextBatch(
  status: json['status'] as String,
  questions: (json['questions'] as List<dynamic>)
      .map((e) => Question.fromJson(e as Map<String, dynamic>))
      .toList(),
  progress: PoolProgress.fromJson(json['progress'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NextBatchToJson(_NextBatch instance) =>
    <String, dynamic>{
      'status': instance.status,
      'questions': instance.questions,
      'progress': instance.progress,
    };
