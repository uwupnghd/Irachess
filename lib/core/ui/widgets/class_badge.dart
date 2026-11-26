import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../features/analysis/domain/game_report.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../settings/settings.dart';
import '../theme.dart';

String className(AppLocalizations l, MoveClass c) => switch (c) {
  MoveClass.brilliant => l.clsBrilliant,
  MoveClass.great => l.clsGreat,
  MoveClass.book => l.clsBook,
  MoveClass.best => l.clsBest,
  MoveClass.excellent => l.clsExcellent,
  MoveClass.good => l.clsGood,
  MoveClass.inaccuracy => l.clsInaccuracy,
  MoveClass.miss => l.clsMiss,
  MoveClass.mistake => l.clsMistake,
  MoveClass.blunder => l.clsBlunder,
  MoveClass.forced => l.clsForced,
};

/// Círculo con el símbolo de la clasificación (símbolo + color + nombre accesible).
class ClassIcon extends ConsumerWidget {
  const ClassIcon(this.cls, {super.key, this.size = 22});
  final MoveClass cls;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = classStyle(cls, colorBlind: ref.watch(settingsProvider).colorBlind);
    return Semantics(
      label: className(AppLocalizations.of(context), cls),
      child: ExcludeSemantics(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: style.color, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(size * 0.14),
            child: FittedBox(
              child: Text(style.symbol, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
            ),
          ),
        ),
      ),
    );
  }
}

class ClassChip extends StatelessWidget {
  const ClassChip(this.cls, {super.key});
  final MoveClass cls;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ClassIcon(cls),
      const SizedBox(width: 6),
      Text(className(AppLocalizations.of(context), cls), style: Theme.of(context).textTheme.titleSmall),
    ],
  );
}
