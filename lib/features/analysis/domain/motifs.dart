import 'package:dartchess/dartchess.dart';

import '../../../core/chess/chess_utils.dart';

/// Pieza atacada por una táctica.
typedef Target = (Square square, Role role);

class Fork {
  const Fork(this.square, this.role, this.targets);
  final Square square;
  final Role role;
  final List<Target> targets;
}

class Pin {
  const Pin({required this.pinner, required this.pinned, required this.pinnedRole, required this.behindRole});
  final Square pinner;
  final Square pinned;
  final Role pinnedRole;
  final Role behindRole;
}

SquareSet _attacksOf(Board board, Square sq, SquareSet occupied) => attacks(board.pieceAt(sq)!, sq, occupied);

/// Horquilla: la pieza en [square] ataca a la vez dos o más piezas rivales
/// que son el rey, más valiosas que ella o están indefensas, y el rival no
/// puede capturarla con ganancia.
Fork? forkAt(Position pos, Square square) {
  final board = pos.board;
  final piece = board.pieceAt(square);
  if (piece == null) return null;
  final enemy = piece.color.opposite;
  if (staticExchange(board, square, enemy) > 0) return null;
  final myValue = roleValue[piece.role]!;
  final targets = <Target>[];
  for (final t in _attacksOf(board, square, board.occupied).intersect(board.bySide(enemy)).squares) {
    final role = board.roleAt(t)!;
    final valuable = role == Role.king || roleValue[role]! > myValue;
    if (valuable || staticExchange(board, t, piece.color) > 0) targets.add((t, role));
  }
  if (targets.length < 2) return null;
  targets.sort((a, b) => roleValue[b.$2]!.compareTo(roleValue[a.$2]!));
  return Fork(square, piece.role, targets);
}

/// Clavadas contra [victim]: una pieza suya atacada por un alfil, torre o dama
/// rival que tiene detrás al rey o a una pieza más valiosa.
List<Pin> pinsAgainst(Board board, Side victim) {
  final out = <Pin>[];
  final occ = board.occupied;
  final sliders = board.bySide(victim.opposite).intersect(board.bishops.union(board.rooks).union(board.queens));
  for (final s in sliders.squares) {
    final seen = _attacksOf(board, s, occ);
    for (final x in seen.intersect(board.bySide(victim)).squares) {
      final behind = _attacksOf(board, s, occ.withoutSquare(x)).diff(seen).intersect(board.bySide(victim));
      for (final y in behind.squares) {
        if (!ray(s, x).has(y)) continue;
        final xr = board.roleAt(x)!, yr = board.roleAt(y)!;
        if (xr != Role.king && (yr == Role.king || roleValue[yr]! > roleValue[xr]!)) {
          out.add(Pin(pinner: s, pinned: x, pinnedRole: xr, behindRole: yr));
        }
      }
    }
  }
  return out;
}

/// Ataque descubierto: al jugar [move] desde [before], otra pieza del mismo
/// bando pasa a atacar al rey o a una pieza valiosa (>= alfil) por la línea
/// que se abrió. Devuelve la pieza atacada más valiosa.
Target? discoveredAttack(Position before, NormalMove move) {
  final side = before.turn;
  final after = before.playUnchecked(move);
  final board = after.board;
  final sliders = board
      .bySide(side)
      .intersect(board.bishops.union(board.rooks).union(board.queens))
      .withoutSquare(move.to);
  Target? best;
  for (final s in sliders.squares) {
    final now = _attacksOf(board, s, board.occupied);
    final then = _attacksOf(before.board, s, before.board.occupied);
    for (final t in now.diff(then).intersect(board.bySide(side.opposite)).squares) {
      final role = board.roleAt(t)!;
      if (!between(s, t).has(move.from)) continue;
      if (role != Role.king && roleValue[role]! < 3) continue;
      if (best == null || roleValue[role]! > roleValue[best.$2]!) best = (t, role);
    }
  }
  return best;
}

/// Pin creado por la jugada (la pieza que clava es la que se acaba de mover).
Pin? pinCreatedBy(Position after, Square movedTo) {
  final side = after.board.sideAt(movedTo);
  if (side == null) return null;
  for (final pin in pinsAgainst(after.board, side.opposite)) {
    if (pin.pinner == movedTo) return pin;
  }
  return null;
}

/// Balance material (para [side]) tras seguir [pv] desde [pos] hasta [plies]
/// medias jugadas.
int materialAfterLine(Position pos, List<String> pv, Side side, {int plies = 6}) {
  var p = pos;
  for (final uci in pv.take(plies)) {
    final m = parseUciMove(p, uci);
    if (m == null) break;
    p = p.playUnchecked(m);
  }
  return materialBalance(p.board, side);
}
