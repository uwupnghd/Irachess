import 'package:dartchess/dartchess.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/core/chess/chess_utils.dart';
import 'package:irachess/features/puzzles/domain/glicko2.dart';
import 'package:irachess/features/puzzles/domain/puzzle.dart';

void main() {
  test('Glicko-2: ganar sube, perder baja, la incertidumbre baja', () {
    const r = Rating(1500, 200, 0.06);
    final win = glickoUpdate(r, 1500, 80, 1);
    final loss = glickoUpdate(r, 1500, 80, 0);
    expect(win.rating, greaterThan(1500));
    expect(loss.rating, lessThan(1500));
    expect(win.rd, lessThan(200));
    // Ganar a un rival mucho más fuerte sube más.
    expect(glickoUpdate(r, 1900, 80, 1).rating, greaterThan(win.rating));
    // Ejemplo de Glickman (1 partida): valores razonables y estables.
    final big = glickoUpdate(const Rating(1500, 350, 0.06), 1400, 30, 1);
    expect(big.rating, inInclusiveRange(1600, 1800));
  });

  // Problema con formato de Lichess: la 1.ª jugada es del rival.
  const lichess = Puzzle(
    id: '00sHx',
    fen: 'q3k1nr/1pp1nQpp/3p4/1P2p3/4P3/B1PP1b2/B5PP/5K2 b k - 0 17',
    moves: ['e8d7', 'a2e6', 'd7d8', 'f7f8'],
    rating: 1760,
    themes: ['mate', 'mateIn2', 'middlegame', 'short'],
    source: 'base',
  );

  test('problema de Lichess: jugada previa del rival, respuesta automática y mate', () {
    final run = PuzzleRun(lichess);
    expect(run.userSide, Side.white);
    expect(run.lastMove!.uci, 'e8d7');
    final wrong = run.play(parseUciMove(run.position, 'a3b2') ?? parseUciMove(run.position, 'f7f8')!);
    expect(wrong.$1, PuzzleStep.wrong);
    expect(run.mistakes, 1);
    final (step, reply) = run.play(parseUciMove(run.position, 'a2e6')!);
    expect(step, PuzzleStep.correct);
    expect(reply!.uci, 'd7d8');
    expect(run.play(parseUciMove(run.position, 'f7f8')!).$1, PuzzleStep.solved);
    expect(run.done, isTrue);
  });

  test('problema propio: una jugada, se aceptan alternativas equivalentes', () {
    const own = Puzzle(
      id: 'own-1-5',
      fen: 'r1bqkbnr/pppp1ppp/2n5/4p2Q/2B1P3/8/PPPP1PPP/RNB1K1NR b KQkq - 3 3',
      moves: ['g7g6'],
      rating: 900,
      themes: ['own'],
      source: 'own',
      note: {'accept': ['d8e7']},
    );
    final a = PuzzleRun(own);
    expect(a.userSide, Side.black);
    expect(a.play(parseUciMove(a.position, 'g8f6')!).$1, PuzzleStep.wrong);
    expect(a.play(parseUciMove(a.position, 'd8e7')!).$1, PuzzleStep.solved);
  });
}
