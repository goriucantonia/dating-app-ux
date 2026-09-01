// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMatch _$ChatMatchFromJson(Map<String, dynamic> json) => _ChatMatch(
  userId: json['user_id'] as String,
  displayName: json['display_name'] as String,
  isDemo: json['is_demo'] as bool,
);

Map<String, dynamic> _$ChatMatchToJson(_ChatMatch instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'display_name': instance.displayName,
      'is_demo': instance.isDemo,
    };

_ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    _ChatMessageModel(
      messageId: json['message_id'] as String,
      seq: (json['seq'] as num).toInt(),
      sender: json['sender'] as String,
      text: json['text'] as String,
      createdAt: json['created_at'] as String? ?? '',
    );

Map<String, dynamic> _$ChatMessageModelToJson(_ChatMessageModel instance) =>
    <String, dynamic>{
      'message_id': instance.messageId,
      'seq': instance.seq,
      'sender': instance.sender,
      'text': instance.text,
      'created_at': instance.createdAt,
    };

_ChatSessionSummary _$ChatSessionSummaryFromJson(Map<String, dynamic> json) =>
    _ChatSessionSummary(
      sessionId: json['session_id'] as String,
      analysisId: json['analysis_id'] as String,
      match: ChatMatch.fromJson(json['match'] as Map<String, dynamic>),
      status: json['status'] as String,
      createdAt: json['created_at'] as String? ?? '',
      endedAt: json['ended_at'] as String?,
      lastMessage: json['last_message'] == null
          ? null
          : ChatMessageModel.fromJson(
              json['last_message'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ChatSessionSummaryToJson(_ChatSessionSummary instance) =>
    <String, dynamic>{
      'session_id': instance.sessionId,
      'analysis_id': instance.analysisId,
      'match': instance.match,
      'status': instance.status,
      'created_at': instance.createdAt,
      'ended_at': instance.endedAt,
      'last_message': instance.lastMessage,
    };

_ChatSessionDetail _$ChatSessionDetailFromJson(Map<String, dynamic> json) =>
    _ChatSessionDetail(
      sessionId: json['session_id'] as String,
      analysisId: json['analysis_id'] as String,
      match: ChatMatch.fromJson(json['match'] as Map<String, dynamic>),
      status: json['status'] as String,
      traitLabels:
          (json['trait_labels'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>).map((e) => e as String).toList(),
            ),
          ) ??
          const <String, List<String>>{},
      dateDigest: json['date_digest'] as String? ?? '',
      snapshotId: json['snapshot_id'] as String? ?? '',
    );

Map<String, dynamic> _$ChatSessionDetailToJson(_ChatSessionDetail instance) =>
    <String, dynamic>{
      'session_id': instance.sessionId,
      'analysis_id': instance.analysisId,
      'match': instance.match,
      'status': instance.status,
      'trait_labels': instance.traitLabels,
      'date_digest': instance.dateDigest,
      'snapshot_id': instance.snapshotId,
    };

_MessagesPage _$MessagesPageFromJson(Map<String, dynamic> json) =>
    _MessagesPage(
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ChatMessageModel>[],
      hasMore: json['has_more'] as bool? ?? false,
      nextAfterSeq: (json['next_after_seq'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MessagesPageToJson(_MessagesPage instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'has_more': instance.hasMore,
      'next_after_seq': instance.nextAfterSeq,
    };

_ReplyResult _$ReplyResultFromJson(Map<String, dynamic> json) => _ReplyResult(
  userMessage: ChatMessageModel.fromJson(
    json['user_message'] as Map<String, dynamic>,
  ),
  personaMessage: ChatMessageModel.fromJson(
    json['persona_message'] as Map<String, dynamic>,
  ),
  compacted: json['compacted'] as bool? ?? false,
);

Map<String, dynamic> _$ReplyResultToJson(_ReplyResult instance) =>
    <String, dynamic>{
      'user_message': instance.userMessage,
      'persona_message': instance.personaMessage,
      'compacted': instance.compacted,
    };
