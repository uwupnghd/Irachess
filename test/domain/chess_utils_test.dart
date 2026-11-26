import 'package:dartchess/dartchess.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/core/chess/chess_utils.dart';
import 'package:irachess/features/analysis/domain/motifs.dart';

Position p(String fen) => positionFromFen(fen);

void main() {
  test('UCI estándar y enroque', () {
    final pos = p('r3k2r/8/8/8/8/8/8/R3K2R w KQkq - 0 1');
    final castle = parseUciMove(pos, 'e1g1')!;
    expect(standardUci(pos, castle), 'e1g1');
    expect(sanOf(pos, 'e1c1'), 'O-O-O');
    expect(parseUciMove(pos, 'e1e3'), isNull);
    expect(parseUciMove(pos, 'zz'), isNull);
    expect(sanLine(Chess.initial, ['e2e4', 'e7e5', 'g1f3']), ['e4', 'e5', 'Nf3']);
  });

  test('intercambio estático', () {
    // Caballo negro en d5 defendido por peón e6, atacado por la dama blanca d1.
    final b = p('4k3/8/4p3/3n4/8/8/8/3QK3 w - - 0 1').board;
    expect(staticExchange(b, Square.d5, Side.white), lessThan(0));
    // Sin el peón defensor, el caballo cuelga.
    final b2 = p('4k3/8/8/3n4/8/8/8/3QK3 w - - 0 1').board;
    expect(staticExchange(b2, Square.d5, Side.white), 3);
    expect(hangingPieces(b2, Side.black).single.$2, Role.knight);
    // Rayos X: torre detrás de torre.
    final b3 = p('3rk3/8/8/3p4/8/8/3R4/3RK3 w - - 0 1').board;
    expect(staticExchange(b3, Square.d5, Side.white), 1);
  });

  test('fase de la partida', () {
    expect(phaseOf(Chess.initial.board, ply: 4, inBook: false), GamePhase.opening);
    expect(phaseOf(Chess.initial.board, ply: 30, inBook: false), GamePhase.middlegame);
    expect(phaseOf(p('4k3/8/8/8/8/8/8/R3K3 w - - 0 1').board, ply: 2, inBook: true), GamePhase.endgame);
  });

  test('horquilla de caballo', () {
    final pos = p('r3k3/2N5/8/8/8/8/8/4K3 b - - 0 1');
    final fork = forkAt(pos, Square.c7)!;
    expect(fork.targets.map((t) => t.$2), [Role.king, Role.rook]);
    // Si el caballo se puede capturar gratis, no es horquilla.
    expect(forkAt(p('r2qk3/2N5/8/8/8/8/8/4K3 b - - 0 1'), Square.c7), isNull);
  });

  test('clavada', () {
    final pins = pinsAgainst(p('4k3/8/8/8/8/8/4n3/K3R3 w - - 0 1').board, Side.black);
    expect(pins.single.pinnedRole, Role.knight);
    expect(pins.single.behindRole, Role.king);
  });

  test('ataque descubierto', () {
    // Alfil c2 detrás del caballo d3; al mover el caballo, el alfil ataca h7?
    final before = p('6k1/7q/8/8/8/3N4/2B5/4K3 w - - 0 1');
    final move = parseUciMove(before, 'd3e5')!;
    expect(discoveredAttack(before, move)?.$2, Role.queen);
  });
}
