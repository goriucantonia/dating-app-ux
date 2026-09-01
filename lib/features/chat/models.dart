import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// The person on the other side of a chat. `isDemo` is required, as
/// everywhere a user is rendered (communication_protocol.md §6).
@freezed
abstract class ChatMatch with _$ChatMatch {
  const factory ChatMatch({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'is_demo') required bool isDemo,
  }) = _ChatMatch;

  factory ChatMatch.fromJson(Map<String, dynamic> json) =>
      _$ChatMatchFromJson(json);
}

/// One chat message as the wire delivers it.
///
/// There is deliberately **no `state` field** (chat.md, S14-B5): the
/// persona's inner state is stored server-side and stripped from every chat
/// payload by contract. A field here would be the first step to showing it.
@freezed
abstract class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    @JsonKey(name: 'message_id') required String messageId,
    required int seq,
    // user | persona
    required String sender,
    required String text,
    @JsonKey(name: 'created_at') @Default('') String createdAt,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
}

@freezed
abstract class ChatSessionSummary with _$ChatSessionSummary {
  const factory ChatSessionSummary({
    @JsonKey(name: 'session_id') required String sessionId,
    @JsonKey(name: 'analysis_id') required String analysisId,
    required ChatMatch match,
    // active | ended
    required String status,
    @JsonKey(name: 'created_at') @Default('') String createdAt,
    @JsonKey(name: 'ended_at') String? endedAt,
    @JsonKey(name: 'last_message') ChatMessageModel? lastMessage,
  }) = _ChatSessionSummary;

  factory ChatSessionSummary.fromJson(Map<String, dynamic> json) =>
      _$ChatSessionSummaryFromJson(json);
}

/// The header sheet's payload (S14-U5): labels only, the digest, the way
/// back to the transcripts.
@freezed
abstract class ChatSessionDetail with _$ChatSessionDetail {
  const factory ChatSessionDetail({
    @JsonKey(name: 'session_id') required String sessionId,
    @JsonKey(name: 'analysis_id') required String analysisId,
    required ChatMatch match,
    required String status,
    @JsonKey(name: 'trait_labels') @Default(<String, List<String>>{}) Map<String, List<String>> traitLabels,
    @JsonKey(name: 'date_digest') @Default('') String dateDigest,
    @JsonKey(name: 'snapshot_id') @Default('') String snapshotId,
  }) = _ChatSessionDetail;

  factory ChatSessionDetail.fromJson(Map<String, dynamic> json) =>
      _$ChatSessionDetailFromJson(json);
}

@freezed
abstract class MessagesPage with _$MessagesPage {
  const factory MessagesPage({
    @Default(<ChatMessageModel>[]) List<ChatMessageModel> messages,
    @JsonKey(name: 'has_more') @Default(false) bool hasMore,
    @JsonKey(name: 'next_after_seq') @Default(0) int nextAfterSeq,
  }) = _MessagesPage;

  factory MessagesPage.fromJson(Map<String, dynamic> json) =>
      _$MessagesPageFromJson(json);
}

@freezed
abstract class ReplyResult with _$ReplyResult {
  const factory ReplyResult({
    @JsonKey(name: 'user_message') required ChatMessageModel userMessage,
    @JsonKey(name: 'persona_message') required ChatMessageModel personaMessage,
    @Default(false) bool compacted,
  }) = _ReplyResult;

  factory ReplyResult.fromJson(Map<String, dynamic> json) =>
      _$ReplyResultFromJson(json);
}
