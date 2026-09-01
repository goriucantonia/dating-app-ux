import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/analyses/analyses_repository.dart';
import '../../features/analyses/models.dart';

/// THE polling primitive (S10-U1, `ux_architecture.md` §1.4).
///
/// **A second polling implementation is a defect, not a convenience** (§16).
/// Everything that watches an analysis — the dashboard hero, the analysis
/// screen, the history card — watches THIS, keyed by analysis id.
///
/// Three properties, each of which had to be designed for rather than hoped
/// for:
///
/// 1. **It survives screen navigation.** The provider is a `family` and is NOT
///    autoDispose, so going dashboard → analysis → dashboard reuses the one
///    live loop instead of tearing it down and starting another. AC2 checks
///    this against the request log, because "probably fine" is not an answer
///    when the failure mode is a silent doubling of server load.
/// 2. **It backs off.** 3 seconds while the thing is fresh, 10 seconds after
///    two minutes. A simulation in Step 11 can run for a long time and a 3s
///    poll for ten minutes is rude to a free tier that bills by the request.
/// 3. **It stops on terminal states.** `matched`, `complete`, `no_candidates`
///    and `failed` are ends; a poller still ticking after one of them is a
///    leak that only shows up as a mysteriously warm phone.
const _fastInterval = Duration(seconds: 3);
const _slowInterval = Duration(seconds: 10);
const _backOffAfter = Duration(minutes: 2);

/// Statuses the server will never move away from on its own. `matched` is
/// terminal HERE by design: matching is done, and the next transition needs
/// the user to press "Start Simulated Dates" (S10-U12, a decision point).
const terminalStatuses = {'matched', 'complete', 'no_candidates', 'failed'};

class AnalysisPoller extends StateNotifier<AsyncValue<Analysis>> {
  AnalysisPoller(this._repo, this._id) : super(const AsyncValue.loading()) {
    _startedAt = DateTime.now();
    unawaited(_tick());
  }

  final AnalysesRepository _repo;
  final String _id;
  Timer? _timer;
  late final DateTime _startedAt;

  bool get _shouldBackOff =>
      DateTime.now().difference(_startedAt) > _backOffAfter;

  Future<void> _tick() async {
    try {
      final analysis = await _repo.get(_id);
      if (!mounted) return;
      state = AsyncValue.data(analysis);
      if (terminalStatuses.contains(analysis.status)) {
        _timer?.cancel();
        return;
      }
    } catch (e, st) {
      if (!mounted) return;
      // A failed poll is NOT terminal: the server may simply be slow or the
      // network briefly gone. Surface it, keep the loop, let the next tick
      // recover — and only show the error state if there is nothing to show.
      if (state is! AsyncData) state = AsyncValue.error(e, st);
    }
    if (!mounted) return;
    _timer?.cancel();
    _timer = Timer(_shouldBackOff ? _slowInterval : _fastInterval, _tick);
  }

  /// Force an immediate poll — used by pull-to-refresh and by "try again",
  /// so those do not need a polling loop of their own either.
  Future<void> refreshNow() async {
    _timer?.cancel();
    await _tick();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// Deliberately NOT autoDispose — see property 1 above.
final analysisPollerProvider = StateNotifierProvider.family<AnalysisPoller,
    AsyncValue<Analysis>, String>(
  (ref, id) => AnalysisPoller(ref.watch(analysesRepositoryProvider), id),
);
