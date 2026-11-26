import 'package:dartchess/dartchess.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/core/chess/chess_utils.dart';
import 'package:irachess/features/games/domain/pgn_import.dart';
import 'package:irachess/features/play/game_state.dart';

LiveGame playAll(String ucis, [String? fen]) {
  final g = LiveGame(fen == null ? null : positionFromFen(fen));
  for (final u in ucis.split(' ')) {
    g.play(parseUciMove(g.position, u)!);
  }
  return g;
}

void main() {
  test('jaque mate y PGN', () {
    final g = playAll('f2f3 e7e5 g2g4 d8h4');
    expect(g.end, GameEnd.checkmate);
    expect(g.result, '0-1');
    final pgn = g.pgn(white: 'Tú', black: 'Motor', date: '2026.11.26');
    expect(PgnImporter.parse(pgn).single.plies.last.san, 'Qh4#');
  });

  test('triple repetición', () {
    final g = playAll('g1f3 g8f6 f3g1 f6g8 g1f3 g8f6 f3g1 f6g8');
    expect(g.end, GameEnd.repetition);
    expect(g.result, '1/2-1/2');
  });

  test('ahogado, material insuficiente y 50 movimientos', () {
    expect(playAll('b6c7', 'k7/8/1Q6/8/8/8/8/7K w - - 0 1').end, GameEnd.stalemate);
    expect(playAll('h1h2', 'k7/8/8/8/8/8/8/7K w - - 0 1').end, GameEnd.material);
    expect(playAll('h1h2', 'k7/8/8/8/8/8/1R6/7K w - - 99 80').end, GameEnd.fiftyMoves);
  });

  test('abandono', () {
    final g = LiveGame()..resign(Side.white);
    expect(g.result, '0-1');
  });
}
