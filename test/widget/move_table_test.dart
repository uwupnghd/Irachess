import 'dart:io' as io;

import 'package:dartchess/dartchess.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/core/engine/uci_engine.dart';
import 'package:irachess/features/analysis/domain/game_report.dart';
import 'package:irachess/features/analysis/presentation/move_table.dart';
import 'package:irachess/features/analysis/presentation/summary_view.dart';
import 'package:irachess/features/games/domain/pgn_import.dart';
import 'package:irachess/features/openings/opening_book.dart';
import 'package:material_ui/material_ui.dart';

import '../fixtures/games.dart';
import '../helpers.dart';

GameReport scholarsReport() {
  EngineLine cp(int v, String pv) => EngineLine(pv: pv.split(' '), cp: v, depth: 16);
  final game = PgnImporter.parse(scholarsMate).single;
  final book = OpeningBook.parse(io.File('assets/openings.tsv').readAsStringSync());
  return buildReport(ReportInput(
    game: game,
    evals: [
      [cp(30, 'e2e4')], [cp(-30, 'e7e5')], [cp(30, 'g1f3')], [cp(-20, 'b8c6')], [cp(10, 'd1h5')],
      [cp(-40, 'g7g6 h5f3'), cp(-60, 'd8e7'), cp(-500, 'g8f6 h5f7')],
      [const EngineLine(pv: ['h5f7'], mate: 1, depth: 16)],
      const [],
    ],
    opening: book.identify(game.positions()),
    userSide: Side.black,
  ));
}

void main() {
  testWidgets('tabla: filas en notación española, filtros y salto a la posición', (tester) async {
    final report = scholarsReport();
    int? selected;
    var filter = MoveFilter.all;
    await pumpLocalized(tester, StatefulBuilder(
      builder: (context, setState) => SingleChildScrollView(
        child: MoveTable(
          moves: report.moves,
          index: 0,
          onSelect: (i) => selected = i,
          filter: filter,
          onFilter: (f) => setState(() => filter = f),
          userSide: Side.black,
        ),
      ),
    ));
    expect(find.text('3… Cf6'), findsOneWidget);
    expect(find.text('4. Dxf7#'), findsOneWidget);
    await tester.tap(find.text('Mis errores'));
    await tester.pumpAndSettle();
    expect(find.text('4. Dxf7#'), findsNothing);
    expect(find.text('3… Cf6'), findsOneWidget);
    await tester.tap(find.text('3… Cf6'));
    expect(selected, 6); // índice de la posición tras 3...Cf6
    await disposeTree(tester);
  });

  testWidgets('resumen: precisión, apertura y recomendaciones', (tester) async {
    final report = scholarsReport();
    await pumpLocalized(tester, SummaryView(report: report, white: 'Blanco', black: 'Negro', userSide: Side.black, onSelect: (_) {}));
    expect(find.text('Precisión'), findsOneWidget);
    await tester.scrollUntilVisible(find.textContaining('Entrena patrones de mate'), 200);
    expect(find.textContaining('Entrena patrones de mate'), findsOneWidget);
    await disposeTree(tester);
  });
}
