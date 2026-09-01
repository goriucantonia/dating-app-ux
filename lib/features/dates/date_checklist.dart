import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models.dart';

/// The checklist of the (up to) 3 dates (S13-U2): pending / running /
/// complete / incomplete-with-reason. Shared between the `simulating` phase
/// and the results screen so the two cannot disagree about what a date's
/// status looks like.
///
/// **Completed dates unlock immediately** (S13-U3): a `complete` or
/// `incomplete` row is tappable while later dates still run. The rows are
/// already checkpointed server-side; this costs nothing and turns a dead
/// wait into the part worth watching.
class DateChecklist extends StatelessWidget {
  const DateChecklist({super.key, required this.dates});

  final List<DateSummary> dates;

  @override
  Widget build(BuildContext context) {
    if (dates.isEmpty) {
      return Text(
        'The dates are being set up…',
        style: Theme.of(context).textTheme.bodySmall,
      );
    }
    return Column(
      children: [for (final d in dates) _Row(date: d)],
    );
  }
}

/// Whether a date's transcript can be opened yet. Readable when anything has
/// been said; a pending date has no rows and a link to nothing is a lie.
bool dateReadable(DateSummary d) =>
    d.status == 'complete' ||
    d.status == 'incomplete' ||
    (d.status == 'running' && d.messageCount > 0);

class _Row extends StatelessWidget {
  const _Row({required this.date});

  final DateSummary date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final d = date;
    final (Widget leading, String status, Color colour) = switch (d.status) {
      'pending' => (
          Icon(Icons.radio_button_unchecked, color: scheme.outline),
          'Waiting its turn',
          scheme.outline,
        ),
      'running' => (
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          d.messageCount == 0
              ? 'Starting…'
              : 'Running — ${d.messageCount} message${d.messageCount == 1 ? '' : 's'} so far',
          scheme.primary,
        ),
      'complete' => (
          Icon(Icons.check_circle, color: scheme.primary),
          endingSentence(status: d.status, endedBy: d.endedBy),
          scheme.primary,
        ),
      'incomplete' => (
          Icon(Icons.warning_amber_rounded, color: scheme.tertiary),
          incompleteReason(d),
          scheme.tertiary,
        ),
      _ => (
          Icon(Icons.error_outline, color: scheme.error),
          incompleteReason(d),
          scheme.error,
        ),
    };
    final readable = dateReadable(d);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: leading,
        title: Text(
          d.settingName.isEmpty ? 'Date ${d.ordinal}' : d.settingName,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('With ${d.candidateName}'),
            Text(status, style: theme.textTheme.bodySmall?.copyWith(color: colour)),
          ],
        ),
        isThreeLine: true,
        trailing: readable ? const Icon(Icons.chevron_right) : null,
        onTap: readable ? () => context.push('/dates/${d.dateId}') : null,
      ),
    );
  }
}
