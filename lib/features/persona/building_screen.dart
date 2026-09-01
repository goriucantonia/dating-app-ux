import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';
import 'persona_repository.dart';

/// `/onboarding/building` — the post-BQ5 chain (S7-U1..U3).
///
/// `POST /profile/extract`, then `POST /persona/compile`, then poll
/// `GET /persona/current` until the snapshot settles.
///
/// **The stage label names the real stage.** It is driven by which job is
/// actually in flight and by the snapshot's own status — never a fake timer
/// counting to an invented duration (new_user_creation.md §2). A progress bar
/// that lies is worse than no progress bar: this wait is genuinely 30-90
/// seconds on the current free models, and a user who is told "almost done"
/// for a minute stops believing anything the app says.
///
/// Every failure is visible and retryable, and the copy says the answers are
/// safe, because that is the thing a person will actually be afraid of after
/// spending ten minutes writing them (S7-U2, and the D-005 lesson: a submit
/// path must end in a visible outcome).
enum _Stage { reading, extracting, building, done, failed }

class BuildingScreen extends ConsumerStatefulWidget {
  const BuildingScreen({super.key});

  @override
  ConsumerState<BuildingScreen> createState() => _BuildingScreenState();
}

class _BuildingScreenState extends ConsumerState<BuildingScreen> {
  _Stage _stage = _Stage.reading;
  String? _error;
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    unawaited(_run());
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  String get _label => switch (_stage) {
        _Stage.reading => 'Reading your answers…',
        _Stage.extracting => 'Extracting traits…',
        _Stage.building => 'Building your persona…',
        _Stage.done => 'Ready.',
        _Stage.failed => 'Something went wrong.',
      };

  Future<void> _run() async {
    setState(() {
      _error = null;
      _stage = _Stage.reading;
    });
    final repo = ref.read(personaRepositoryProvider);
    try {
      setState(() => _stage = _Stage.extracting);
      await repo.extract();

      setState(() => _stage = _Stage.building);
      await repo.startCompile();
      _startPolling();
    } on ApiException catch (e) {
      _fail(e.message);
    } catch (e) {
      // The catch-all D-005 exists for: a storage or platform failure after a
      // server-side success must still put words on the screen.
      _fail('$e');
    }
  }

  void _startPolling() {
    _poll?.cancel();
    _poll = Timer.periodic(const Duration(seconds: 3), (_) async {
      if (!mounted) return;
      try {
        final state = await ref.read(personaRepositoryProvider).current();
        final snap = state.snapshot;
        if (snap == null) return;
        if (snap.status == 'ready') {
          _poll?.cancel();
          if (!mounted) return;
          setState(() => _stage = _Stage.done);
          // Step 8 owns /profile; until it exists this lands on home, which
          // already renders the live account.
          ref.invalidate(personaProvider);
          if (mounted) context.go('/');
        } else if (snap.status == 'failed') {
          _poll?.cancel();
          _fail(snap.error != null
              ? "We couldn't finish building your AI self."
              : 'Building your AI self failed.');
        }
      } on ApiException catch (e) {
        _poll?.cancel();
        _fail(e.message);
      }
    });
  }

  void _fail(String message) {
    if (!mounted) return;
    setState(() {
      _stage = _Stage.failed;
      _error = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Building your profile')),
      body: LayoutShell(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_stage == _Stage.failed) ...[
                  Icon(Icons.error_outline,
                      size: 56, color: theme.colorScheme.error),
                  const SizedBox(height: 16),
                  Text(_label,
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  Text(
                    _error ?? '',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    // The reassurance that matters: ten minutes of writing is
                    // not at risk, only the processing is being retried.
                    'Your answers are saved. Only the processing needs '
                    'another go.',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => unawaited(_run()),
                    child: const Text('Try again'),
                  ),
                  TextButton(
                    onPressed: () => context.go('/'),
                    child: const Text('Not now'),
                  ),
                ] else ...[
                  const CircularProgressIndicator(),
                  const SizedBox(height: 24),
                  Text(_label,
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  Text(
                    'This takes up to a minute. It only happens once.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
