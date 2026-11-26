import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/providers.dart';
import '../../../core/settings/settings.dart';
import '../../../core/ui/widgets/common.dart';
import '../../../l10n/gen/app_localizations.dart';

const puzzleThemes = [
  'mateIn1', 'mateIn2', 'mateIn3', 'backRankMate', 'fork', 'pin', 'skewer',
  'discoveredAttack', 'hangingPiece', 'sacrifice', 'trappedPiece', 'endgame',
];

class PuzzleOverview {
  const PuzzleOverview(this.rating, this.streak, this.own, this.today);
  final double rating;
  final int streak;
  final int own;
  final int today;
}

final puzzleOverviewProvider = FutureProvider.autoDispose((ref) async {
  final repo = ref.watch(puzzleRepositoryProvider);
  final db = ref.watch(databaseProvider);
  await repo.ensureBaseLoaded();
  final midnight = DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  final today = await (db.select(db.puzzleAttempts)
        ..where((t) => t.attemptedAt.isBiggerThanValue(midnight.subtract(const Duration(milliseconds: 1))))
        ..orderBy([(t) => OrderingTerm.desc(t.attemptedAt)]))
      .get();
  return PuzzleOverview((await repo.currentRating()).rating, await repo.currentStreak(), await repo.countOwn(), today.length);
});

class PuzzlesHome extends ConsumerWidget {
  const PuzzlesHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final overview = ref.watch(puzzleOverviewProvider);
    final goal = ref.watch(settingsProvider.select((s) => s.dailyGoal));
    return Scaffold(
      appBar: AppBar(title: Text(l.puzzlesTitle), actions: [
        IconButton(tooltip: l.packsTitle, icon: const Icon(Icons.download_for_offline_outlined), onPressed: () => context.go('/puzzles/packs')),
      ]),
      body: overview.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(l.errorGeneric('$e')),
        data: (o) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(padding: const EdgeInsets.all(16), children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    Text(l.puzzleRating(o.rating.round()), style: t.headlineMedium),
                    const SizedBox(height: 4),
                    Text(l.puzzleStreak(o.streak)),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(value: (o.today / goal).clamp(0, 1).toDouble()),
                    const SizedBox(height: 4),
                    Text(l.progressDailyGoal(o.today, goal), style: t.bodySmall),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () => context.go('/puzzles/solve?theme=mix'),
                      icon: const Icon(Icons.play_arrow),
                      label: Text(l.puzzleStart),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.history_edu),
                  title: Text(l.themeName('own')),
                  subtitle: Text(o.own == 0 ? l.puzzleMyErrorsEmpty : '${o.own}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: o.own == 0 ? null : () => context.go('/puzzles/solve?theme=own'),
                ),
              ),
              SectionTitle(l.puzzleThemes),
              Wrap(spacing: 8, runSpacing: 8, children: [
                for (final theme in puzzleThemes)
                  ActionChip(label: Text(l.themeName(theme)), onPressed: () => context.go('/puzzles/solve?theme=$theme')),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
