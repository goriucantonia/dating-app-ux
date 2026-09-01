import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import 'models.dart';

/// Raised when the server says an analysis is already running (409).
///
/// It carries the running id, because the 409 is **state, not failure**
/// (`communication_protocol.md` §5): the right response is to go and watch
/// that analysis, not to show the user a rejection.
class AnalysisAlreadyRunning implements Exception {
  const AnalysisAlreadyRunning(this.analysisId);

  final String analysisId;
}

class AnalysesRepository {
  AnalysesRepository(this._dio);

  final Dio _dio;

  Future<Analysis> start() async {
    try {
      final r = await _dio.post<Map<String, dynamic>>('/analyses');
      return Analysis.fromJson(r.data!);
    } on DioException catch (e) {
      final body = e.response?.data;
      if (e.response?.statusCode == 409 && body is Map<String, dynamic>) {
        final fields = (body['error'] as Map?)?['fields'];
        if (fields is List && fields.isNotEmpty) {
          final id = (fields.first as Map)['message'] as String?;
          if (id != null) throw AnalysisAlreadyRunning(id);
        }
      }
      throw ApiException.from(e);
    }
  }

  Future<Analysis> get(String id) async {
    try {
      final r = await _dio.get<Map<String, dynamic>>('/analyses/$id');
      return Analysis.fromJson(r.data!);
    } on DioException catch (e) {
      throw ApiException.from(e);
    }
  }

  /// Start the simulated dates for a matched analysis (S11-B11).
  ///
  /// A 409 here is the same shape of thing as `start()`'s: the dates are
  /// already running, which is not an error to show but a reason to go and
  /// watch them.
  Future<void> simulate(String id) async {
    try {
      await _dio.post<Map<String, dynamic>>('/analyses/$id/simulate');
    } on DioException catch (e) {
      final body = e.response?.data;
      if (e.response?.statusCode == 409 &&
          body is Map<String, dynamic> &&
          (body['error'] as Map?)?['code'] == 'simulation_in_progress') {
        return;
      }
      throw ApiException.from(e);
    }
  }

  Future<List<Analysis>> history() async {
    try {
      final r = await _dio.get<Map<String, dynamic>>('/analyses');
      return (r.data!['analyses'] as List)
          .map((j) => Analysis.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.from(e);
    }
  }
}

final analysesRepositoryProvider = Provider<AnalysesRepository>(
    (ref) => AnalysesRepository(ref.watch(apiClientProvider)));

final analysisHistoryProvider = FutureProvider<List<Analysis>>(
    (ref) async => ref.watch(analysesRepositoryProvider).history());
