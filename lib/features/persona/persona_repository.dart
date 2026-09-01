import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import 'models.dart';

class PersonaRepository {
  PersonaRepository(this._dio);

  final Dio _dio;

  /// Start-then-poll (S7-B7): this returns as soon as the job is accepted,
  /// not when the persona is built.
  Future<String> startCompile() async {
    final r = await _wrap(
        () => _dio.post<Map<String, dynamic>>('/persona/compile'));
    return r.data!['status'] as String;
  }

  Future<PersonaState> current() async {
    final r =
        await _wrap(() => _dio.get<Map<String, dynamic>>('/persona/current'));
    return PersonaState.fromJson(r.data!);
  }

  Future<void> extract() async {
    await _wrap(() => _dio.post<Map<String, dynamic>>('/profile/extract'));
  }

  Future<T> _wrap<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw ApiException.from(e);
    }
  }
}

final personaRepositoryProvider = Provider<PersonaRepository>(
    (ref) => PersonaRepository(ref.watch(apiClientProvider)));

/// Rebuilds on login/logout like `questionsProvider`, so a second account in
/// the same session never sees the first one's persona.
final personaProvider = FutureProvider<PersonaState>((ref) async {
  return ref.watch(personaRepositoryProvider).current();
});
