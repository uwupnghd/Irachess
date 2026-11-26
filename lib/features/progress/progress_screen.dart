import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/providers.dart';
import '../../core/settings/settings.dart';
import '../../core/ui/theme.dart';
import '../../core/ui/widgets/common.dart';
import '../../l10n/gen/app_localizations.dart';
import 'progress_data.dart';

final progressProvider = FutureProvider.autoDispose((ref) => loadProgress(ref.watch(databaseProvider), DateTime.now()));

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final data = ref.watch(progressProvider);
    final goal = ref.watch(settingsProvider.select((s) => s.dailyGoal));
    return Scaffold(
      appBar: AppBar(title: Text(l.progressTitle), actions: [
        IconButton(tooltip: l.retry, icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(progressProvider)),
      ]),
      body: data.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(l.errorGeneric('$e')),
        data: (d) => d.isEmpty
            ? EmptyState(icon: Icons.trending_up, title: l.progressTitle, body: l.progressEmpty)
            : RefreshIndicator(
                onRefresh: () => ref.refresh(progressProvider.future),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 820),
                    child: ListView(padding: const EdgeInsets.all(16), children: [
                      Wrap(spacing: 12, runSpacing: 12, children: [
                        _Stat(icon: Icons.local_fire_department, text: l.progressStreak(d.streak)),
                        _Stat(icon: Icons.flag, text: l.progressDailyGoal(d.today, goal)),
                        _Stat(icon: Icons.visibility, text: l.progressVision('${d.visionBest}', d.visionSessions)),
                      ]),
                      if (d.accuracy.isNotEmpty) ...[
                        SectionTitle(l.progressAccuracy),
                        _LineSpark(values: d.accuracy, min: 0, max: 100, color: brandIndigo),
                      ],
                      if (d.ratings.isNotEmpty) ...[
                        SectionTitle(l.progressPuzzleRating),
                        _LineSpark(values: d.ratings, color: brandAmber),
                      ],
                      SectionTitle(l.progressErrorTypes),
                      _ErrorBars(d.errorTypes),
                      if (d.openings.isNotEmpty) ...[
                        SectionTitle(l.progressOpenings),
                        for (final o in d.openings.take(8))
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(o.family),
                            subtitle: Text([
                              l.openingStats(o.games, (100 * o.wins / o.games).round(), (100 * o.draws / o.games).round(),
                                  (100 * o.losses / o.games).round()),
                              if (o.accuracy != null) l.openingAcc(o.accuracy!.toStringAsFixed(1)),
                            ].join(' · ')),
                          ),
                      ],
                    ]),
                  ),
                ),
              ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: brandAmber), const SizedBox(width: 8), Text(text)]),
    ),
  );
}

class _LineSpark extends StatelessWidget {
  const _LineSpark({required this.values, required this.color, this.min, this.max});
  final List<double> values;
  final Color color;
  final double? min;
  final double? max;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 160,
    child: LineChart(LineChartData(
      minY: min,
      maxY: max,
      gridData: const FlGridData(drawVerticalLine: false),
      borderData: FlBorderData(show: false),
      titlesData: const FlTitlesData(
        topTitles: AxisTitles(),
        rightTitles: AxisTitles(),
        bottomTitles: AxisTitles(),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [for (var i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i])],
          color: color,
          barWidth: 2,
          dotData: FlDotData(show: values.length < 30),
        ),
      ],
    )),
  );
}

class _ErrorBars extends StatelessWidget {
  const _ErrorBars(this.types);
  final Map<String, int> types;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final names = {'tactical': l.errTactical, 'opening': l.errOpening, 'endgame': l.errEndgame, 'other': l.errOther};
    final total = types.values.fold<int>(0, (a, b) => a + b);
    return Column(children: [
      for (final e in types.entries)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(children: [
            SizedBox(width: 110, child: Text(names[e.key]!)),
            Expanded(child: LinearProgressIndicator(value: total == 0 ? 0 : e.value / total, minHeight: 10)),
            SizedBox(width: 40, child: Text('${e.value}', textAlign: TextAlign.end)),
          ]),
        ),
    ]);
  }
}
