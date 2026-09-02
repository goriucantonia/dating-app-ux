// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Evaluation _$EvaluationFromJson(Map<String, dynamic> json) => _Evaluation(
  criteria: json['criteria'] as Map<String, dynamic>,
  dateScore: (json['date_score'] as num).toDouble(),
  isPartial: json['is_partial'] as bool,
  clickedSubjects:
      (json['clicked_subjects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  clashes:
      (json['clashes'] as List<dynamic>?)
          ?.map((e) => Clash.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Clash>[],
  perPeerSummary:
      json['per_peer_summary'] as Map<String, dynamic>? ??
      const <String, dynamic>{},
  verdictSummary: json['verdict_summary'] as String? ?? '',
  judgeProvider: json['judge_provider'] as String? ?? '',
  judgeModel: json['judge_model'] as String? ?? '',
  rubricVersion: json['rubric_version'] as String? ?? '',
);

Map<String, dynamic> _$EvaluationToJson(_Evaluation instance) =>
    <String, dynamic>{
      'criteria': instance.criteria,
      'date_score': instance.dateScore,
      'is_partial': instance.isPartial,
      'clicked_subjects': instance.clickedSubjects,
      'clashes': instance.clashes,
      'per_peer_summary': instance.perPeerSummary,
      'verdict_summary': instance.verdictSummary,
      'judge_provider': instance.judgeProvider,
      'judge_model': instance.judgeModel,
      'rubric_version': instance.rubricVersion,
    };

_Clash _$ClashFromJson(Map<String, dynamic> json) => _Clash(
  userTrait: json['user_trait'] as String? ?? '',
  candidateTrait: json['candidate_trait'] as String? ?? '',
  moment: json['moment'] as String? ?? '',
);

Map<String, dynamic> _$ClashToJson(_Clash instance) => <String, dynamic>{
  'user_trait': instance.userTrait,
  'candidate_trait': instance.candidateTrait,
  'moment': instance.moment,
};

_DateSummary _$DateSummaryFromJson(Map<String, dynamic> json) => _DateSummary(
  dateId: json['date_id'] as String,
  candidateUserId: json['candidate_user_id'] as String,
  candidateName: json['candidate_name'] as String,
  ordinal: (json['ordinal'] as num).toInt(),
  status: json['status'] as String,
  settingName: json['setting_name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  sensoryDetails: json['sensory_details'] as String? ?? '',
  archetype: json['archetype'] as String? ?? '',
  messageCount: (json['message_count'] as num?)?.toInt() ?? 0,
  turnCount: (json['turn_count'] as num?)?.toInt() ?? 0,
  error: json['error'] as String?,
  endedBy: json['ended_by'] as String?,
  evaluation: json['evaluation'] == null
      ? null
      : Evaluation.fromJson(json['evaluation'] as Map<String, dynamic>),
  excludedFromScore: json['excluded_from_score'] as bool? ?? false,
);

Map<String, dynamic> _$DateSummaryToJson(_DateSummary instance) =>
    <String, dynamic>{
      'date_id': instance.dateId,
      'candidate_user_id': instance.candidateUserId,
      'candidate_name': instance.candidateName,
      'ordinal': instance.ordinal,
      'status': instance.status,
      'setting_name': instance.settingName,
      'description': instance.description,
      'sensory_details': instance.sensoryDetails,
      'archetype': instance.archetype,
      'message_count': instance.messageCount,
      'turn_count': instance.turnCount,
      'error': instance.error,
      'ended_by': instance.endedBy,
      'evaluation': instance.evaluation,
      'excluded_from_score': instance.excludedFromScore,
    };

_Fixture _$FixtureFromJson(Map<String, dynamic> json) => _Fixture(
  settingName: json['setting_name'] as String? ?? '',
  archetype: json['archetype'] as String? ?? '',
  datesPerCandidate: (json['dates_per_candidate'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$FixtureToJson(_Fixture instance) => <String, dynamic>{
  'setting_name': instance.settingName,
  'archetype': instance.archetype,
  'dates_per_candidate': instance.datesPerCandidate,
};

_DatesPayload _$DatesPayloadFromJson(Map<String, dynamic> json) =>
    _DatesPayload(
      analysisId: json['analysis_id'] as String,
      status: json['status'] as String,
      progress: json['progress'] as Map<String, dynamic>?,
      fixture: json['fixture'] == null
          ? null
          : Fixture.fromJson(json['fixture'] as Map<String, dynamic>),
      dates:
          (json['dates'] as List<dynamic>?)
              ?.map((e) => DateSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DateSummary>[],
    );

Map<String, dynamic> _$DatesPayloadToJson(_DatesPayload instance) =>
    <String, dynamic>{
      'analysis_id': instance.analysisId,
      'status': instance.status,
      'progress': instance.progress,
      'fixture': instance.fixture,
      'dates': instance.dates,
    };

_TranscriptMessage _$TranscriptMessageFromJson(Map<String, dynamic> json) =>
    _TranscriptMessage(
      seq: (json['seq'] as num).toInt(),
      speaker: json['speaker'] as String,
      reply: json['reply'] as String,
      state: json['state'] as Map<String, dynamic>?,
      provider: json['provider'] as String?,
      modelId: json['model_id'] as String?,
    );

Map<String, dynamic> _$TranscriptMessageToJson(_TranscriptMessage instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'speaker': instance.speaker,
      'reply': instance.reply,
      'state': instance.state,
      'provider': instance.provider,
      'model_id': instance.modelId,
    };

_Transcript _$TranscriptFromJson(Map<String, dynamic> json) => _Transcript(
  dateId: json['date_id'] as String,
  analysisId: json['analysis_id'] as String,
  status: json['status'] as String,
  settingName: json['setting_name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  sensoryDetails: json['sensory_details'] as String? ?? '',
  userDisplayName: json['user_display_name'] as String? ?? 'You',
  candidateDisplayName: json['candidate_display_name'] as String? ?? '',
  schemaVersion: json['schema_version'] as String? ?? '',
  endedBy: json['ended_by'] as String?,
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map((e) => TranscriptMessage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TranscriptMessage>[],
);

Map<String, dynamic> _$TranscriptToJson(_Transcript instance) =>
    <String, dynamic>{
      'date_id': instance.dateId,
      'analysis_id': instance.analysisId,
      'status': instance.status,
      'setting_name': instance.settingName,
      'description': instance.description,
      'sensory_details': instance.sensoryDetails,
      'user_display_name': instance.userDisplayName,
      'candidate_display_name': instance.candidateDisplayName,
      'schema_version': instance.schemaVersion,
      'ended_by': instance.endedBy,
      'messages': instance.messages,
    };
