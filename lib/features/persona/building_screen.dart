import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';
import '../../core/auth/auth_controller.dart';
import 'persona_repository.dart';

/// `/onboarding/building` — the post-BQ5 chain (S7-U1..U3), and since the
/// 2026-09-02 audit ALSO the chain after a batch, an edit, or a correction
/// answer: `POST /profile/extract`, then `POST /persona/compile`, then poll
/// `GET /persona/current` until the snapshot settles. `returnTo` says where
/// to land afterwards.
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
///
/// What the audit changed here:
/// - the extract call gets the long timeout, and `queued` is honoured by
///   waiting for the run already in flight instead of compiling from nothing;
/// - an unchanged re-read with a fresh persona finishes without a compile;
/// - the poll re-arms only after each request returns, catches everything,
///   tolerates a few failed ticks, and gives up after [_pollBudget] with words
///   on the screen instead of a spinner for ever;
/// - "Ready" means a READY snapshot that is not stale — the old one is stale
///   the moment extraction changed a trait, so it no longer counts as done;
/// - there is a way out (sign out) while it runs.
enum _Stage { reading, extracting, waiting, building, done, failed }

const _pollInterval = Duration(seconds: 3);
const _pollBudget = Duration(minutes: 6);
const _maxConsecutiveFailures = 5;

class BuildingScreen extends ConsumerStatefulWidget {
  const BuildingScreen({super.key, this.returnTo});

  /// Where to go when the persona is ready. Defaults to home.
  final String? returnTo;

  @override
  ConsumerState<BuildingScreen> createState() => _BuildingScreenState();
}

class _BuildingScreenState extends ConsumerState<BuildingScreen> {
  _Stage _stage = _Stage.reading;
  String? _error;
  Timer? _poll;
  DateTime? _pollStarted;
  int _failedTicks = 0;

  String get _destination {
    final to = widget.returnTo;
    return (to == null || to.isEmpty) ? '/' : to;
  }

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
        _Stage.waiting => 'Still reading your answers…',
        _Stage.building => 'Building your persona…',
        _Stage.done => 'Ready.',
        _Stage.failed => 'Something went wrong.',
      };

  Future<void> _run() async {
    _poll?.cancel();
    setState(() {
      _error = null;
      _stage = _Stage.reading;
      _failedTicks = 0;
    });
    final repo = ref.read(personaRepositoryProvider);
    try {
      setState(() => _stage = _Stage.extracting);
      // Start-then-poll (D-022): the server answers at once and reads the
      // answers in the background; no request is left open for a minute.
      final started = await repo.extract(wait: false);
      if (!mounted) return;
      if (started.queued) setState(() => _stage = _Stage.waiting);
      final status = await _waitForExtraction(repo);
      if (!mounted) return;
      if (status != null && status.failed) {
        _fail(status.lastError ?? "We couldn't read your answers just now.");
        return;
      }
      if (status == null || status.lastStatus == null) {
        // The server no longer knows about the run it accepted (a restart
        // in between, or every status read failed). Compiling now would
        // build from the OLD traits and call it done (review 2026-09-03).
        _fail('We lost track of the reading — it may have finished. '
            'Try again: a finished read is quick to confirm.');
        return;
      }
      final outcome = ExtractOutcome(
        status: status.lastStatus ?? 'done',
        changed: status.changed ?? true,
      );

      if (!outcome.changed) {
        // Nothing moved. If the persona that exists is fresh, there is
        // nothing to build and a compile would burn a call to reproduce it.
        final state = await repo.current();
        if (!mounted) return;
        final snap = state.snapshot;
        if (snap != null && snap.status == 'ready' && !snap.stale) {
          _finish();
          return;
        }
      }

      setState(() => _stage = _Stage.building);
      await repo.startCompile(); // 'already_compiling' is fine: same job
      _pollStarted = DateTime.now();
      _scheduleTick(immediately: true);
    } on ApiException catch (e) {
      _fail(e.message);
    } catch (e) {
      // The catch-all D-005 exists for: a storage or platform failure after a
      // server-side success must still put words on the screen.
      _fail('Something went wrong on this device. Please try again.');
    }
  }

  /// Poll the extraction status until no run is in flight, within the same
  /// budget the compile poll gets. Returns the last status seen (null if
  /// every read failed). On the budget's end the compile is attempted
  /// anyway — the server's own compile-after-extract may already have run.
  Future<ExtractStatus?> _waitForExtraction(PersonaRepository repo) async {
    final started = DateTime.now();
    ExtractStatus? last;
    while (DateTime.now().difference(started) < _pollBudget) {
      await Future<void>.delayed(_pollInterval);
      if (!mounted) return last;
      try {
        last = await repo.extractStatus();
        if (!last.running) return last;
      } on ApiException catch (e) {
        // One failed status read is not a verdict; a dead session is.
        if (e.status == 401) rethrow;
      }
    }
    return last;
  }

  void _scheduleTick({bool immediately = false}) {
    _poll?.cancel();
    _poll = Timer(immediately ? Duration.zero : _pollInterval, _tick);
  }

  Future<void> _tick() async {
    if (!mounted) return;
    final started = _pollStarted ?? DateTime.now();
    if (DateTime.now().difference(started) > _pollBudget) {
      _fail('Building is taking much longer than it should. Your answers are '
          'saved — you can try again, or come back later.');
      return;
    }
    try {
      final state = await ref.read(personaRepositoryProvider).current();
      if (!mounted) return;
      _failedTicks = 0;
      final snap = state.snapshot;
      if (snap != null && snap.status == 'ready' && !snap.stale) {
        _finish();
        return;
      }
      if (snap != null && snap.status == 'failed') {
        _fail(snap.error != null
            ? "We couldn't finish building your AI self."
            : 'Building your AI self failed.');
        return;
      }
      // null (no row yet), compiling, or a stale ready one: keep asking.
    } on ApiException catch (e) {
      if (!mounted) return;
      if (++_failedTicks >= _maxConsecutiveFailures || e.status == 401) {
        _fail(e.message);
        return;
      }
    } catch (e) {
      if (!mounted) return;
      if (++_failedTicks >= _maxConsecutiveFailures) {
        _fail('Something went wrong on this device. Please try again.');
        return;
      }
    }
    if (mounted) _scheduleTick();
  }

  void _finish() {
    _poll?.cancel();
    if (!mounted) return;
    setState(() => _stage = _Stage.done);
    ref.invalidate(personaProvider);
    context.go(_destination);
  }

  void _fail(String message) {
    _poll?.cancel();
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
      appBar: AppBar(
        title: const Text('Building your profile'),
        actions: [
          // The one exit while this runs. Without it a wrong account, or a
          // build that never settles, left nowhere to go (audit 2026-09-02).
          TextButton(
            onPressed: () =>
                ref.read(authControllerProvider.notifier).logOut(),
            child: const Text('Sign out'),
          ),
        ],
      ),
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
                    onPressed: () => context.go(_destination),
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
                    _stage == _Stage.waiting
                        ? 'An earlier attempt is still running on the server. '
                            'Waiting for it rather than starting another.'
                        : 'This can take a couple of minutes on the free '
                            'models. You can leave — sign out or close the '
                            'tab — and the work carries on.',
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
