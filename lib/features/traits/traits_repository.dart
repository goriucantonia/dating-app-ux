import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import 'models.dart';

class TraitsRepository {
  TraitsRepository(this._dio);

  final Dio _dio;

  Future<TraitsPayload> fetch() async {
    final r = await _wrap(() => _dio.get<Map<String, dynamic>>('/traits'));
    return TraitsPayload.fromJson(r.data!);
  }

  Future<Trait> confirm(String traitId) async {
    final r = await _wrap(() =>
        _dio.post<Map<String, dynamic>>('/traits/$traitId/confirm'));
    return Trait.fromJson(r.data!);
  }

  /// Returns the generated follow-up question along with the updated trait —
  /// the UI deep-links straight to it, so "that's wrong" ends somewhere useful
  /// instead of just recolouring a card (S8-U3).
  Future<DisputeResult> dispute(String traitId, {String? correction}) async {
    final r = await _wrap(() => _dio.post<Map<String, dynamic>>(
        '/traits/$traitId/dispute',
        data: {if (correction != null && correction.isNotEmpty) 'correction': correction}));
    return DisputeResult.fromJson(r.data!);
  }

  Future<T> _wrap<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw ApiException.from(e);
    }
  }
}

final traitsRepositoryProvider =
    Provider<TraitsRepository>((ref) => TraitsRepository(ref.watch(apiClientProvider)));

final traitsProvider = FutureProvider<TraitsPayload>(
    (ref) async => ref.watch(traitsRepositoryProvider).fetch());
