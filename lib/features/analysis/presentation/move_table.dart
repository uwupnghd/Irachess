import 'package:dartchess/dartchess.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/chess/chess_utils.dart';
import '../../../core/chess/notation.dart';
import '../../../core/ui/widgets/class_badge.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../domain/game_report.dart';
import 'eval_widgets.dart';

enum MoveFilter { all, myErrors, blunders, opening, middlegame, endgame }

bool matchesFilter(MoveReport m, MoveFilter f, Side? user) => switch (f) {
  MoveFilter.all => true,
  MoveFilter.myErrors => (user == null || m.side == user) && m.cls.isBad,
  MoveFilter.blunders => m.cls == MoveClass.blunder,
  MoveFilter.opening => m.phase == GamePhase.opening,
  MoveFilter.middlegame => m.phase == GamePhase.middlegame,
  MoveFilter.endgame => m.phase == GamePhase.endgame,
};

String moveLabel(AppLocalizations l, MoveReport m) {
  final san = localizeSan(m.san, l.localeName);
  return m.whiteMoved ? l.moveOf(m.moveNumber, san) : l.moveOfBlack(m.moveNumber, san);
}

String _time(Duration d) => d.inMinutes > 0 ? '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}' : '${d.inSeconds} s';

/// Tabla de jugadas con filtros. Tocar una fila salta a esa posición.
class MoveTable extends StatelessWidget {
  const MoveTable({
    super.key,
    required this.moves,
    required this.index,
    required this.onSelect,
    required this.filter,
    required this.onFilter,
    this.userSide,
  });

  final List<MoveReport> moves;
  final int index;
  final ValueChanged<int> onSelect;
  final MoveFilter filter;
  final ValueChanged<MoveFilter> onFilter;
  final Side? userSide;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final rows = moves.where((m) => matchesFilter(m, filter, userSide)).toList();
    final labels = {
      MoveFilter.all: l.filterAll,
      MoveFilter.myErrors: l.filterMyErrors,
      MoveFilter.blunders: l.filterBlunders,
      MoveFilter.opening: l.phaseOpening,
      MoveFilter.middlegame: l.phaseMiddlegame,
      MoveFilter.endgame: l.phaseEndgame,
    };
    final hasTime = moves.any((m) => m.timeSpent != null);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(children: [
          for (final f in MoveFilter.values)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: ChoiceChip(label: Text(labels[f]!), selected: filter == f, onSelected: (_) => onFilter(f)),
            ),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: DefaultTextStyle(
          style: t.labelSmall!.copyWith(color: scheme.onSurfaceVariant),
          child: Row(children: [
            SizedBox(width: 72, child: Text(l.tableNumber)),
            const SizedBox(width: 28),
            Expanded(child: Text(l.tableEval)),
            Expanded(child: Text(l.tableBest)),
            if (hasTime) SizedBox(width: 48, child: Text(l.tableTime, textAlign: TextAlign.end)),
          ]),
        ),
      ),
      for (final m in rows)
        Material(
          color: index == m.ply + 1 ? scheme.primaryContainer : Colors.transparent,
          child: InkWell(
            onTap: () => onSelect(m.ply + 1),
            child: Semantics(
              button: true,
              selected: index == m.ply + 1,
              label: '${moveLabel(l, m)}, ${className(l, m.cls)}',
              child: ExcludeSemantics(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(children: [
                    SizedBox(width: 72, child: Text(moveLabel(l, m), style: t.bodyMedium!.copyWith(fontWeight: FontWeight.w600))),
                    SizedBox(width: 28, child: Align(alignment: Alignment.centerLeft, child: ClassIcon(m.cls, size: 18))),
                    Expanded(child: Text(evalText(cp: m.cpAfter, mate: m.mateAfter), style: t.bodySmall)),
                    Expanded(
                      child: Text(
                        m.cls.isBad || m.cls == MoveClass.good || m.cls == MoveClass.excellent ? localizeSan(m.best?.san ?? '', l.localeName) : '',
                        style: t.bodySmall,
                      ),
                    ),
                    if (hasTime)
                      SizedBox(
                        width: 48,
                        child: Text(m.timeSpent == null ? '' : _time(m.timeSpent!), style: t.bodySmall, textAlign: TextAlign.end),
                      ),
                  ]),
                ),
              ),
            ),
          ),
        ),
    ]);
  }
}
