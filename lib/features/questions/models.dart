import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
abstract class Question with _$Question {
  const factory Question({
    required String id,
    required String origin, // baseline | pool | dispute
    String? code,
    @JsonKey(name: 'pool_order') int? poolOrder,
    @JsonKey(name: 'probe_area') required String probeArea,
    required String text,
    required bool answered,
    @JsonKey(name: 'answer_text') String? answerText,
    @JsonKey(name: 'answer_updated_at') String? answerUpdatedAt,
    // Which trait a dispute question is about (null for baseline/pool).
    @JsonKey(name: 'trait_id') String? traitId,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
}

@freezed
abstract class PoolProgress with _$PoolProgress {
  const factory PoolProgress({
    @JsonKey(name: 'answered_pool') required int answeredPool,
    @JsonKey(name: 'total_pool') required int totalPool,
  }) = _PoolProgress;

  factory PoolProgress.fromJson(Map<String, dynamic> json) =>
      _$PoolProgressFromJson(json);
}

@freezed
abstract class NextBatch with _$NextBatch {
  const factory NextBatch({
    required String status, // 'ok' | 'pool_exhausted'
    required List<Question> questions,
    required PoolProgress progress,
  }) = _NextBatch;

  factory NextBatch.fromJson(Map<String, dynamic> json) => _$NextBatchFromJson(json);
}
