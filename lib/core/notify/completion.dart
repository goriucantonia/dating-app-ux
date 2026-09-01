import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
class CompletionListener extends ConsumerWidget {
  const CompletionListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Analysis?>(finishedAnalysisProvider, (_, next) {
      if (next == null) return;
      final failed = next.status == 'failed';
      final title = failed ? 'Your analysis stopped' : 'Your dates have finished';
      final body = failed
          ? 'Something went wrong partway. Open it to see where, and to pick up again.'
          : 'The results are ready to read.';
      notifyLocal(title: title, body: body);
      final target =
          failed ? '/analyses/${next.id}' : '/analyses/${next.id}/results';
      scaffoldMessengerKey.currentState
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 12),
            content: Text('$title. $body'),
            action: SnackBarAction(
              label: failed ? 'Open' : 'See results',
              onPressed: () {
                // The router lives above this widget; use the messenger's
                // own context, which is inside MaterialApp.router.
                final ctx = scaffoldMessengerKey.currentContext;
                if (ctx != null) GoRouter.of(ctx).go(target);
              },
            ),
          ),
        );
    });
    return child;
  }
}
