import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/providers.dart';
import '../../../core/ui/widgets/common.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../data/games_repository.dart';

class GamesScreen extends ConsumerWidget {
  const GamesScreen({super.key});

  List<Widget> _actions(BuildContext context, AppLocalizations l) => [
    FilledButton.icon(
      onPressed: () => context.go('/analyze/import'),
      icon: const Icon(Icons.content_paste),
      label: Text(l.actionPastePgn),
    ),
    FilledButton.tonalIcon(
      onPressed: () => context.go('/analyze/online'),
      icon: const Icon(Icons.cloud_download_outlined),
      label: Text(l.actionImportOnline),
    ),
    FilledButton.tonalIcon(
      onPressed: () => context.go('/analyze/play'),
      icon: const Icon(Icons.smart_toy_outlined),
      label: Text(l.actionPlayEngine),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final games = ref.watch(gamesListProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l.gamesTitle)),
      body: games.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(l.errorGeneric('$e')),
        data: (items) => items.isEmpty
            ? EmptyState(
                icon: Icons.insights,
                title: l.gamesEmptyTitle,
                body: l.gamesEmptyBody,
                actions: _actions(context, l),
              )
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Wrap(spacing: 8, runSpacing: 8, children: _actions(context, l)),
                  const SizedBox(height: 16),
                  for (final item in items) _GameTile(item),
                ],
              ),
      ),
    );
  }
}

class _GameTile extends ConsumerWidget {
  const _GameTile(this.item);
  final GameListItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final g = item.game;
    final a = item.analysis;
    final acc = a?.userAccuracy;
    final subtitle = [
      if (g.date != null && !g.date!.contains('?')) g.date!,
      g.result,
      if (g.openingName != null) g.openingName!,
      if (a == null) l.notAnalyzed else if (acc != null) l.accuracyShort(acc.toStringAsFixed(1)),
    ].join(' · ');
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        minVerticalPadding: 12,
        leading: Icon(a == null ? Icons.hourglass_empty : Icons.insights),
        title: Text(l.gameVs(g.white, g.black)),
        subtitle: Text(subtitle),
        onTap: () => context.go('/analyze/game/${g.id}'),
        trailing: IconButton(
          tooltip: l.delete,
          icon: const Icon(Icons.delete_outline),
          onPressed: () async {
            final ok = await showDialog<bool>(
              context: context,
              builder: (c) => AlertDialog(
                content: Text(l.deleteGameConfirm),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(c, false), child: Text(l.cancel)),
                  FilledButton(onPressed: () => Navigator.pop(c, true), child: Text(l.delete)),
                ],
              ),
            );
            if (ok ?? false) await ref.read(gamesRepositoryProvider).delete(g.id);
          },
        ),
      ),
    );
  }
}
