import 'package:dartchess/dartchess.dart';

/// Valor material clásico. El rey vale mucho para que el intercambio estático
/// nunca "gane" capturando con el rey una casilla defendida.
const Map<Role, int> roleValue = {
  Role.pawn: 1,
  Role.knight: 3,
  Role.bishop: 3,
  Role.rook: 5,
  Role.queen: 9,
  Role.king: 100,
};

/// FEN sin contadores de jugadas: identifica la posición (aperturas, caché).
String epdOf(Position pos) => pos.fen.split(' ').take(4).join(' ');

Position positionFromFen(String fen) => Chess.fromSetup(Setup.parseFen(fen));

/// Convierte UCI estándar (e1g1) en el movimiento legal de dartchess, o null.
NormalMove? parseUciMove(Position pos, String uci) {
  if (uci.length < 4 || uci.length > 5) return null;
  final NormalMove raw;
  try {
    raw = NormalMove.fromUci(uci);
  } on Object {
    return null;
  }
  final move = pos.normalizeMove(raw);
  return move is NormalMove && pos.isLegal(move) ? move : null;
}

/// UCI estándar (el enroque como e1g1) a partir de un movimiento de dartchess.
String standardUci(Position pos, NormalMove move) {
  final piece = pos.board.pieceAt(move.from);
  if (piece != null && piece.role == Role.king && pos.board.sideAt(move.to) == piece.color) {
    final file = move.to.file > move.from.file ? 6 : 2;
    return '${move.from.name}${Square(file | (move.from.rank << 3)).name}';
  }
  return move.uci;
}

/// SAN de una jugada UCI, o la propia cadena si no es legal.
String sanOf(Position pos, String uci) {
  final move = parseUciMove(pos, uci);
  return move == null ? uci : pos.makeSanUnchecked(move).$2;
}

/// Convierte una línea UCI en SAN, deteniéndose en la primera jugada ilegal.
List<String> sanLine(Position pos, List<String> ucis, {int max = 99}) {
  final out = <String>[];
  var p = pos;
  for (final uci in ucis.take(max)) {
    final move = parseUciMove(p, uci);
    if (move == null) break;
    final (next, san) = p.makeSanUnchecked(move);
    out.add(san);
    p = next;
  }
  return out;
}

/// Material de [side] sin contar el rey.
int materialOf(Board board, Side side) {
  var total = 0;
  for (final role in [Role.pawn, Role.knight, Role.bishop, Role.rook, Role.queen]) {
    total += board.piecesOf(side, role).size * roleValue[role]!;
  }
  return total;
}

/// Material de [side] menos el del rival.
int materialBalance(Board board, Side side) => materialOf(board, side) - materialOf(board, side.opposite);

/// Atacantes reales de [side] sobre [square] con la ocupación [occupied].
SquareSet attackersOf(Board board, Square square, Side side, SquareSet occupied) =>
    board.attacksTo(square, side, occupied: occupied).intersect(occupied);

/// Intercambio estático: material que gana [side] si empieza a capturar en
/// [square] y ambos bandos siguen capturando mientras les convenga.
/// Devuelve 0 si no hay pieza rival o no hay atacantes.
int staticExchange(Board board, Square square, Side side) {
  final target = board.pieceAt(square);
  if (target == null || target.color == side) return 0;
  var occupied = board.occupied;
  final gains = <int>[roleValue[target.role]!];
  var mover = side;
  var attacker = _leastValuable(board, attackersOf(board, square, mover, occupied));
  while (attacker != null) {
    final value = roleValue[board.roleAt(attacker)!]!;
    gains.add(value - gains.last);
    occupied = occupied.withoutSquare(attacker);
    mover = mover.opposite;
    attacker = _leastValuable(board, attackersOf(board, square, mover, occupied));
  }
  // gains[i] = ganancia del que hace la captura i si el rival responde.
  for (var i = gains.length - 2; i > 0; i--) {
    gains[i - 1] = -_max(-gains[i - 1], gains[i]);
  }
  return gains.length == 1 ? 0 : gains[0];
}

int _max(int a, int b) => a > b ? a : b;

Square? _leastValuable(Board board, SquareSet attackers) {
  if (attackers.isEmpty) return null;
  for (final role in [Role.pawn, Role.knight, Role.bishop, Role.rook, Role.queen, Role.king]) {
    final s = attackers.intersect(board.byRole(role));
    if (s.isNotEmpty) return s.first;
  }
  return null;
}

/// Piezas de [side] (sin rey) que el rival puede ganar capturando ya.
List<(Square, Role, int)> hangingPieces(Board board, Side side) {
  final out = <(Square, Role, int)>[];
  for (final sq in board.bySide(side).diff(board.kings).squares) {
    final gain = staticExchange(board, sq, side.opposite);
    if (gain > 0) out.add((sq, board.roleAt(sq)!, gain));
  }
  out.sort((a, b) => b.$3.compareTo(a.$3));
  return out;
}

enum GamePhase { opening, middlegame, endgame }

/// Apertura: en libro o antes de la jugada 10. Final: <= 6 piezas mayores y
/// menores en total. Medio juego: el resto.
GamePhase phaseOf(Board board, {required int ply, required bool inBook}) {
  final pieces = board.knights.union(board.bishops).union(board.rooks).union(board.queens).size;
  if (pieces <= 6) return GamePhase.endgame;
  if (inBook || ply < 20) return GamePhase.opening;
  return GamePhase.middlegame;
}
