import 'dart:io' as io;

import 'package:dartchess/dartchess.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/core/engine/uci_engine.dart';
import 'package:irachess/features/analysis/domain/game_report.dart';
import 'package:irachess/features/games/domain/pgn_import.dart';
import 'package:irachess/features/openings/opening_book.dart';

import '../fixtures/games.dart';

EngineLine cp(int v, String pv) => EngineLine(pv: pv.split(' '), cp: v, depth: 16);
EngineLine mate(int n, String pv) => EngineLine(pv: pv.split(' '), mate: n, depth: 16);

void main() {
  final book = OpeningBook.parse(io.File('assets/openings.tsv').readAsStringSync());

  test('mate del pastor: 3...Cf6 es error grave con explicación de mate', () {
    final game = PgnImporter.parse(scholarsMate).single;
    // Evaluaciones simuladas (punto de vista de quien mueve en cada posición).
    final evals = [
      [cp(30, 'e2e4 e7e5')],
      [cp(-30, 'e7e5 g1f3')],
      [cp(30, 'g1f3 b8c6')],
      [cp(-20, 'b8c6 d2d3'), cp(-40, 'g8f6 d2d3')],
      [cp(10, 'd1h5 g7g6'), cp(5, 'g1f3 g8f6')],
      [cp(-40, 'g7g6 h5f3'), cp(-60, 'd8e7 b1c3'), cp(-500, 'g8f6 h5f7')],
      [mate(1, 'h5f7')],
      <EngineLine>[], // jaque mate
    ];
    final report = buildReport(ReportInput(
      game: game,
      evals: evals,
      opening: book.identify(game.positions()),
      userSide: Side.black,
    ));
    final nf6 = report.moves[5];
    expect(nf6.san, 'Nf6');
    expect(nf6.cls, MoveClass.blunder);
    expect(nf6.explanation.first.key, 'allowsMate');
    expect(nf6.explanation.first.args['line'], 'Qxf7#');
    expect(nf6.best!.san, 'g6');
    expect(nf6.alternatives, hasLength(3));
    expect(report.moves[6].cls, isNot(MoveClass.blunder)); // Qxf7# es la mejor
    expect(report.moves.last.mateAfter, 0);
    expect(report.accuracyWhite!, greaterThan(report.accuracyBlack!));
    expect(report.critical, contains(5));
    expect(report.recommendations.first.key, 'recMate');
    expect(report.opening.opening, isNotNull);
    // Ida y vuelta JSON (lo que se guarda en la base de datos).
    final again = GameReport.fromJson(report.toJson());
    expect(again.moves[5].cls, MoveClass.blunder);
    expect(again.counts(Side.black)[MoveClass.blunder], 1);
  });

  test('pieza colgada y tiempo empleado', () {
    final game = PgnImporter.parse('''
[TimeControl "60+1"]

1. e4 {[%clk 0:01:00]} e5 {[%clk 0:01:00]} 2. Nf3 {[%clk 0:00:55]} Qg5 {[%clk 0:00:40]} 3. Nxg5 {[%clk 0:00:54]} *''').single;
    final evals = [
      [cp(30, 'e2e4')],
      [cp(-30, 'e7e5')],
      [cp(30, 'g1f3')],
      [cp(-30, 'b8c6 f1b5')],
      [cp(900, 'f3g5 a7a6')],
      [cp(-900, 'a7a6')],
    ];
    final report = buildReport(ReportInput(game: game, evals: evals, opening: book.identify(game.positions())));
    final qg5 = report.moves[3];
    expect(qg5.cls, MoveClass.blunder);
    expect(qg5.explanation.first.key, 'hanging');
    expect(qg5.explanation.first.args, {'piece': 'queen', 'square': 'g5', 'reply': 'Nxg5'});
    expect(qg5.motifs, ['hanging']);
    expect(qg5.timeSpent, const Duration(seconds: 21)); // 60 - 40 + 1
  });
}
