import 'package:dartchess/dartchess.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/chess/chess_utils.dart';
import '../../../core/chess/notation.dart';
import '../../../core/ui/widgets/class_badge.dart';
import '../../../core/ui/widgets/common.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../domain/game_report.dart';
import 'explain_text.dart';
import 'move_table.dart';

String phaseName(AppLocalizations l, GamePhase p) => switch (p) {
  GamePhase.opening => l.phaseOpening,
  GamePhase.middlegame => l.phaseMiddlegame,
  GamePhase.endgame => l.phaseEndgame,
};

/// Tema de problemas recomendado para cada recomendación.
const _recTheme = {
  'recHanging': 'hangingPiece',
  'recFork': 'fork',
  'recPin': 'pin',
  'recMate': 'mateIn2',
  'recEndgame': 'endgame',
  'recMiss': 'mix',
};

class SummaryView extends StatelessWidget {
  const SummaryView({super.key, required this.report, required this.white, required this.black, required this.onSelect, this.userSide});
  final GameReport report;
  final String white;
  final String black;
  final Side? userSide;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final op = report.opening;
    final cw = report.counts(Side.white), cb = report.counts(Side.black);
    String acc(double? a) => a == null ? '–' : a.toStringAsFixed(1);

    // Fase con más errores del usuario (o de ambos si no se sabe).
    GamePhase? worst;
    var worstErrors = 0;
    for (final p in GamePhase.values) {
      final errors = [for (final s in Side.values) if (userSide == null || s == userSide) report.phases['${s.name}.${p.name}']?.errors ?? 0]
          .fold<int>(0, (a, b) => a + b);
      if (errors > worstErrors) {
        worst = p;
        worstErrors = errors;
      }
    }

    String? exitText;
    if (op.exitPly != null && op.exitPly! < report.moves.length) {
      final m = report.moves[op.exitPly!];
      final mine = userSide == null || m.side == userSide;
      exitText = mine
          ? l.summaryLeftBook(m.moveNumber, localizeSan(m.san, l.localeName), localizeSan(op.bookMoves.take(4).join(', '), l.localeName))
          : l.summaryOpponentLeftBook(m.moveNumber, localizeSan(m.san, l.localeName));
    }

    return ListView(padding: const EdgeInsets.all(16), children: [
      SectionTitle(l.summaryAccuracy),
      Row(children: [
        for (final (name, value, side) in [(white, report.accuracyWhite, Side.white), (black, report.accuracyBlack, Side.black)])
          Expanded(
            child: Card(
              color: side == userSide ? Theme.of(context).colorScheme.primaryContainer : null,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(children: [
                  Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text('${acc(value)} %', style: t.headlineMedium!.copyWith(fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
          ),
      ].expand((w) => [w, const SizedBox(width: 8)]).toList()..removeLast()),
      SectionTitle(l.summaryCounts),
      for (final c in MoveClass.values.where((c) => c != MoveClass.forced))
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(children: [
            SizedBox(width: 36, child: Text('${cw[c]}', textAlign: TextAlign.center, style: t.titleSmall)),
            Expanded(child: Center(child: ClassChip(c))),
            SizedBox(width: 36, child: Text('${cb[c]}', textAlign: TextAlign.center, style: t.titleSmall)),
          ]),
        ),
      SectionTitle(l.summaryOpening),
      Text(op.opening == null ? l.summaryNoOpening : '${op.opening!.eco} · ${op.opening!.name}', style: t.titleSmall),
      const SizedBox(height: 4),
      Text(exitText ?? (op.opening == null ? '' : l.summaryInBook)),
      SectionTitle(l.summaryPhases),
      if (worst != null) Text(l.summaryWorstPhase(phaseName(l, worst)), style: t.titleSmall),
      for (final p in GamePhase.values)
        for (final s in Side.values)
          if (report.phases['${s.name}.${p.name}'] case final stats? when userSide == null || s == userSide)
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text('${phaseName(l, p)}${userSide == null ? ' · ${s == Side.white ? l.sideWhite : l.sideBlack}' : ''}'),
              subtitle: Text(l.summaryPhaseLine(stats.moves, (stats.accuracy ?? 0).toStringAsFixed(0), stats.errors)),
            ),
      if (report.critical.isNotEmpty) ...[
        SectionTitle(l.summaryCritical),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (final ply in report.critical)
            ActionChip(
              avatar: ClassIcon(report.moves[ply].cls, size: 18),
              label: Text(moveLabel(l, report.moves[ply])),
              onPressed: () => onSelect(ply + 1),
            ),
        ]),
      ],
      SectionTitle(l.summaryRecommendations),
      for (final r in report.recommendations)
        Card(
          child: ListTile(
            leading: const Icon(Icons.lightbulb_outline),
            title: Text(renderPart(l, r)),
            trailing: _recTheme[r.key] == null ? null : const Icon(Icons.extension),
            onTap: _recTheme[r.key] == null ? null : () => context.go('/puzzles/solve?theme=${_recTheme[r.key]}'),
          ),
        ),
    ]);
  }
}
