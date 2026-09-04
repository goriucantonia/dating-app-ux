import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import '../../core/auth/auth_controller.dart';
import 'models.dart';

/// Raised when the server says this analysis already has a selection (409).
/// It carries the session id, because the 409 is **state, not failure**
/// (communication_protocol.md §5): the right response is to open that chat.
class AlreadySelected implements Exception {
  const AlreadySelected(this.sessionId);

  final String? sessionId;
}

class ChatRepository {
  ChatRepository(this._dio);

  final Dio _dio;

  /// S14-U1. The one irreversible choice in an analysis.
  Future<ChatSessionSummary> select(String analysisId, String candidateUserId) async {
    try {
      final r = await _dio.post<Map<String, dynamic>>(
        '/analyses/$analysisId/select',
        data: {'candidate_user_id': candidateUserId},
      );
      return ChatSessionSummary.fromJson(r.data!);
    } on DioException catch (e) {
      final body = e.response?.data;
      if (e.response?.statusCode == 409 &&
          body is Map<String, dynamic> &&
          (body['error'] as Map?)?['code'] == 'already_selected') {
        final fields = (body['error'] as Map)['fields'];
        String? id;
        if (fields is List && fields.isNotEmpty) {
          id = (fields.first as Map)['message'] as String?;
        }
        throw AlreadySelected(id);
      }
      throw ApiException.from(e);
    }
  }

  Future<List<ChatSessionSummary>> sessions() async {
    final r = await _wrap(() => _dio.get<Map<String, dynamic>>('/chat/sessions'));
    return (r.data!['sessions'] as List)
        .map((j) => ChatSessionSummary.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  Future<ChatSessionDetail> detail(String sessionId) async {
    final r = await _wrap(
        () => _dio.get<Map<String, dynamic>>('/chat/sessions/$sessionId'));
    return ChatSessionDetail.fromJson(r.data!);
  }

  /// S14-U8. Ascending from `afterSeq`; the screen loads pages until
  /// `hasMore` is false.
  Future<MessagesPage> messages(String sessionId, {int afterSeq = 0}) async {
    final r = await _wrap(() => _dio.get<Map<String, dynamic>>(
          '/chat/sessions/$sessionId/messages',
          queryParameters: {'after_seq': afterSeq},
        ));
    return MessagesPage.fromJson(r.data!);
  }

  /// S14-U6/U7. Throws [ApiException] with code `reply_failed` on the
  /// server's give-up — the caller keeps the text in the composer.
  ///
  /// [clientMessageId] is reused on a retry of the SAME send, so a resend
  /// after a timeout gets the stored pair back instead of posting twice.
  Future<ReplyResult> send(String sessionId, String text,
      {String? clientMessageId}) async {
    final r = await _wrap(() => _dio.post<Map<String, dynamic>>(
          '/chat/sessions/$sessionId/messages',
          data: {
            'text': text,
            'client_message_id': ?clientMessageId,
          },
          options: modelCallOptions,
        ));
    return ReplyResult.fromJson(r.data!);
  }

  Future<ChatSessionSummary> end(String sessionId) async {
    final r = await _wrap(
        () => _dio.post<Map<String, dynamic>>('/chat/sessions/$sessionId/end'));
    return ChatSessionSummary.fromJson(r.data!);
  }

  Future<T> _wrap<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw ApiException.from(e);
    }
  }
}

final chatRepositoryProvider =
    Provider<ChatRepository>((ref) => ChatRepository(ref.watch(apiClientProvider)));

/// The session list. Invalidated after a selection and after ending a chat.
final chatSessionsProvider = FutureProvider<List<ChatSessionSummary>>((ref) async {
  // Signed out (or not yet known): no request. A tokenless fetch here was
  // a 401 nobody wanted, and a second fetch the moment auth resolved.
  // Loading until a person is signed in; rebuilt when that changes.
  if (ref.watch(currentUserIdProvider) == null) return Completer<List<ChatSessionSummary>>().future;
  return ref.watch(chatRepositoryProvider).sessions();
});

/// The selection made for one analysis, if any — what the results footer
/// reads to turn "Choose X" into "already chose X" (S14-U2).
final selectionForAnalysisProvider =
    Provider.family<ChatSessionSummary?, String>((ref, analysisId) {
  final sessions = ref.watch(chatSessionsProvider).valueOrNull;
  if (sessions == null) return null;
  return sessions.where((s) => s.analysisId == analysisId).firstOrNull;
});
