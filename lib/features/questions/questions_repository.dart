import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import 'models.dart';

class QuestionsRepository {
  QuestionsRepository(this._dio);

  final Dio _dio;

  Future<List<Question>> fetchAll() async {
    final r = await _wrap(() => _dio.get<Map<String, dynamic>>('/questions'));
    return (r.data!['questions'] as List)
        .map((j) => Question.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  Future<NextBatch> nextBatch() async {
    final r =
        await _wrap(() => _dio.get<Map<String, dynamic>>('/questions/next-batch'));
    return NextBatch.fromJson(r.data!);
  }

  /// The ONE save path — first write and every later edit (server upsert).
  Future<Question> saveAnswer(String questionId, String text) async {
    final r = await _wrap(() => _dio.put<Map<String, dynamic>>(
        '/answers/$questionId', data: {'answer_text': text}));
    return Question.fromJson(r.data!);
  }

  Future<T> _wrap<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw ApiException.from(e);
    }
  }
}

final questionsRepositoryProvider = Provider<QuestionsRepository>(
    (ref) => QuestionsRepository(ref.watch(apiClientProvider)));
