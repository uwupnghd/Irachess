import 'dart:io' as io;

import 'package:dartchess/dartchess.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/core/engine/engine_channel_io.dart';
import 'package:irachess/core/engine/uci_engine.dart';
import 'package:irachess/features/analysis/domain/game_report.dart';
import 'package:irachess/features/games/domain/pgn_import.dart';
import 'package:irachess/features/openings/opening_book.dart';

import '../fixtures/games.dart';

void main() {
  test('parser de líneas info', () {
    final (n, l) = parseInfoLine('info depth 16 seldepth 20 multipv 2 score cp -34 nodes 1 nps 2 pv e7e5 g1f3')!;
    expect(n, 2);
    expect(l.cp, -34);
    expect(l.pv, ['e7e5', 'g1f3']);
    expect(parseInfoLine('info depth 3 multipv 1 score mate -2 pv a1a2')!.$2.mate, -2);
    expect(parseInfoLine('info depth 10 score cp 20 lowerbound pv e2e4'), isNull);
    expect(parseInfoLine('info string NNUE'), isNull);
  });

  final hasEngine = findDesktopEngine() != null;

  test('Stockfish real: análisis completo de una partida', () async {
    final engine = await UciEngine.start();
    final game = PgnImporter.parse(scholarsMate).single;
    final positions = game.positions();
    final sw = Stopwatch()..start();
    final evals = <List<EngineLine>>[];
    for (final p in positions) {
      evals.add(p.isGameOver ? const [] : await engine.analyse(p.fen, preset: EnginePreset.normal));
    }
    sw.stop();
    await engine.dispose();
    expect(evals.first, hasLength(3));
    final book = OpeningBook.parse(io.File('assets/openings.tsv').readAsStringSync());
    final report = buildReport(ReportInput(game: game, evals: evals, opening: book.identify(positions), userSide: Side.black));
    expect(report.moves[5].cls, MoveClass.blunder);
    expect(report.moves[5].explanation.first.key, 'allowsMate');
    // ignore: avoid_print
    print('8 posiciones en ${sw.elapsedMilliseconds} ms; ${[for (final m in report.moves) '${m.san}:${m.cls.name}']}');
  }, skip: hasEngine ? false : 'Stockfish no instalado');
}
