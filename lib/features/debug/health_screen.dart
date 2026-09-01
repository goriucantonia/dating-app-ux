import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';

/// THROWAWAY debug screen (S1-U6, retired in Step 4): calls `GET /health` and
/// renders the raw result — the first proof the wire in
/// communication_protocol.md is real and not a diagram.
final healthProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final dio = ref.watch(apiClientProvider);
  final response = await dio.get<Map<String, dynamic>>('/health');
  return response.data ?? {};
});

class HealthScreen extends ConsumerWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final health = ref.watch(healthProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Server health (debug)')),
      body: LayoutShell(
        child: Center(
          child: health.when(
            loading: () => const CircularProgressIndicator(),
            data: (data) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline, size: 48),
                const SizedBox(height: 12),
                Text('GET $apiBaseUrl/health',
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 8),
                Text('$data', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            error: (err, _) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_off, size: 48),
                const SizedBox(height: 12),
                Text(
                  err is DioException
                      ? "Couldn't reach the server at $apiBaseUrl."
                      : 'Something went wrong: $err',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => ref.invalidate(healthProvider),
                  child: const Text('Try again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
