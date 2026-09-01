// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Candidate _$CandidateFromJson(Map<String, dynamic> json) => _Candidate(
  candidateUserId: json['candidate_user_id'] as String,
  displayName: json['display_name'] as String,
  age: (json['age'] as num).toInt(),
  isDemo: json['is_demo'] as bool,
  traitLabels: (json['trait_labels'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
  ),
  rank: (json['rank'] as num).toInt(),
  fitForward: (json['fit_forward'] as num).toDouble(),
  fitBackward: (json['fit_backward'] as num).toDouble(),
  compatibility: (json['compatibility'] as num).toDouble(),
  sharedInterests: (json['shared_interests'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  reasonSummary: json['reason_summary'] as String,
  snapshotId: json['snapshot_id'] as String,
  finalScore: (json['final_score'] as num?)?.toDouble(),
  datesCompleted: (json['dates_completed'] as num?)?.toInt(),
  datesIncomplete: (json['dates_incomplete'] as num?)?.toInt(),
);

Map<String, dynamic> _$CandidateToJson(_Candidate instance) =>
    <String, dynamic>{
      'candidate_user_id': instance.candidateUserId,
      'display_name': instance.displayName,
      'age': instance.age,
      'is_demo': instance.isDemo,
      'trait_labels': instance.traitLabels,
      'rank': instance.rank,
      'fit_forward': instance.fitForward,
      'fit_backward': instance.fitBackward,
      'compatibility': instance.compatibility,
      'shared_interests': instance.sharedInterests,
      'reason_summary': instance.reasonSummary,
      'snapshot_id': instance.snapshotId,
      'final_score': instance.finalScore,
      'dates_completed': instance.datesCompleted,
      'dates_incomplete': instance.datesIncomplete,
    };

_Analysis _$AnalysisFromJson(Map<String, dynamic> json) => _Analysis(
  id: json['id'] as String,
  status: json['status'] as String,
  poolStatus: json['pool_status'] as String?,
  error: json['error'] as String?,
  createdAt: json['created_at'] as String,
  candidates:
      (json['candidates'] as List<dynamic>?)
          ?.map((e) => Candidate.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Candidate>[],
  removedCandidates: (json['removed_candidates'] as num?)?.toInt() ?? 0,
  message: json['message'] as String?,
  progress: json['progress'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AnalysisToJson(_Analysis instance) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'pool_status': instance.poolStatus,
  'error': instance.error,
  'created_at': instance.createdAt,
  'candidates': instance.candidates,
  'removed_candidates': instance.removedCandidates,
  'message': instance.message,
  'progress': instance.progress,
};
