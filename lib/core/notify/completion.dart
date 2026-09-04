import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/analyses/analyses_repository.dart';
import '../../features/analyses/models.dart';
import 'local_notification.dart';

/// The most recent analysis the poller watched finish (S13-U4). Set by the
/// ONE poller when it observes `simulating → complete` (or `failed`) live —
/// never on a cold load of an already-finished analysis, which is why this
/// is an event and not derived from status.
final finishedAnalysisProvider = StateProvider<Analysis?>((ref) => null);

/// The app-wide ScaffoldMessenger, so the banner can show from wherever the
/// user is standing — the whole point of "you can leave, this keeps running"
/// is that they are probably not on the progress screen when it finishes.
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

/// Wraps the router's pages; shows the in-app banner and fires the local
/// notification when an analysis the app was watching finishes.
///
/// **[onOpen] is passed in, not looked up (D-019).** This widget lives in
/// `MaterialApp.router`'s `builder`, which wraps the router's output from
/// ABOVE — so there is no `InheritedGoRouter` anywhere in its ancestry, and
/// `GoRouter.of(context)` from here (or from the messenger's context, which is
/// higher still) throws. The button did nothing, and because the throw
/// happened inside the action callback, `SnackBarAction` never got to dismiss
/// its own snackbar either. Whoever builds the app has the router in hand;
/// handing it over is both correct and one less thing to be wrong at runtime.
class CompletionListener extends ConsumerWidget {
  const CompletionListener({
    super.key,
    required this.child,
    required this.onOpen,
  });

  final Widget child;

  /// Navigate to a route. `GoRouter.go` in the app; a recorder in tests.
  final void Function(String route) onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Analysis?>(finishedAnalysisProvider, (_, next) {
      if (next == null) return;
      // Wherever the user is standing, the dashboard's cached history is now
      // behind; refresh it so the Home tab is coherent when they get there.
      ref.invalidate(analysisHistoryProvider);
      final failed = next.status == 'failed';
      final title = failed ? 'Your analysis stopped' : 'Your dates have finished';
      final body = failed
          ? 'Something went wrong partway. Open it to see where, and to pick up again.'
          : 'The results are ready to read.';
      notifyLocal(title: title, body: body);
      final target =
          failed ? '/analyses/${next.id}' : '/analyses/${next.id}/results';
      final messenger = scaffoldMessengerKey.currentState;
      messenger
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 12),
            content: Text('$title. $body'),
            action: SnackBarAction(
              label: failed ? 'Open' : 'See results',
              onPressed: () {
                // Dismiss FIRST. If the navigation throws, the banner must
                // still go — a notice you cannot get rid of without reloading
                // the page is worse than the thing it was announcing.
                messenger.hideCurrentSnackBar();
                // Consumed: this event has been acted on, so a later rebuild
                // of this listener must not resurrect the same banner.
                ref.read(finishedAnalysisProvider.notifier).state = null;
                onOpen(target);
              },
            ),
          ),
        );
    });
    return child;
  }
}
