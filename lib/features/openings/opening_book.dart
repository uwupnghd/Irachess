import 'package:dartchess/dartchess.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../core/chess/chess_utils.dart';

class OpeningName {
  const OpeningName(this.eco, this.name);
  final String eco;
  final String name;

  /// Familia: la parte antes de ':' (p. ej. "Sicilian Defense").
  String get family => name.split(':').first;
}

/// Resultado de identificar la apertura de una partida.
class OpeningResult {
  const OpeningResult({this.opening, this.namedAtPly, this.exitPly, this.bookMoves = const []});

  final OpeningName? opening;

  /// Media jugada (índice 0) tras la cual se alcanzó la posición con nombre.
  final int? namedAtPly;

  /// Media jugada (índice 0) con la que se salió de la teoría; null si nunca.
  final int? exitPly;

  /// Jugadas de libro (SAN) que había en la posición de [exitPly].
  final List<String> bookMoves;

  Map<String, Object?> toJson() => {
    'eco': opening?.eco,
    'name': opening?.name,
    'namedAt': namedAtPly,
    'exit': exitPly,
    'book': bookMoves,
  };

  factory OpeningResult.fromJson(Map<String, Object?> j) => OpeningResult(
    opening: j['eco'] == null ? null : OpeningName(j['eco']! as String, j['name']! as String),
    namedAtPly: j['namedAt'] as int?,
    exitPly: j['exit'] as int?,
    bookMoves: (j['book'] as List<Object?>? ?? const []).cast<String>(),
  );
}

/// Libro de aperturas ECO (dataset CC0 lichess-org/chess-openings).
/// Funciona sin conexión: se construye desde assets/openings.tsv.
class OpeningBook {
  OpeningBook._(this._named, this._book);

  final Map<String, OpeningName> _named;
  final Set<String> _book;

  int get size => _named.length;

  static Future<OpeningBook> load() async => parse(await rootBundle.loadString('assets/openings.tsv'));

  /// Construye el libro desde el TSV (eco \t nombre \t jugadas UCI).
  static OpeningBook parse(String tsv) {
    final named = <String, OpeningName>{};
    final book = <String>{};
    for (final line in tsv.split('\n')) {
      final cols = line.split('\t');
      if (cols.length < 3) continue;
      Position pos = Chess.initial;
      for (final uci in cols[2].split(' ')) {
        pos = pos.play(Move.parse(uci)!);
        book.add(epdOf(pos));
      }
      // Ante transposiciones, se conserva el primer nombre (línea más corta).
      named.putIfAbsent(epdOf(pos), () => OpeningName(cols[0], cols[1]));
    }
    return OpeningBook._(named, book);
  }

  bool inBook(String epd) => _book.contains(epd);

  OpeningName? nameOf(String epd) => _named[epd];

  /// [positions] = posición inicial + posición tras cada media jugada.
  OpeningResult identify(List<Position> positions) {
    OpeningName? opening;
    int? namedAt, exit;
    for (var ply = 0; ply + 1 < positions.length; ply++) {
      final epd = epdOf(positions[ply + 1]);
      final name = _named[epd];
      if (name != null) {
        opening = name;
        namedAt = ply;
      }
      if (exit == null && !_book.contains(epd)) {
        exit = ply;
        // Seguimos buscando nombres por si hay transposición de vuelta al libro.
      }
    }
    // Si la partida no empezó en la posición inicial, no hay teoría que aplicar.
    if (positions.isEmpty || epdOf(positions.first) != epdOf(Chess.initial)) {
      return const OpeningResult();
    }
    final bookMoves = exit == null ? <String>[] : _bookMovesFrom(positions[exit]);
    return OpeningResult(opening: opening, namedAtPly: namedAt, exitPly: exit, bookMoves: bookMoves);
  }

  List<String> _bookMovesFrom(Position pos) {
    final out = <String>[];
    for (final MapEntry(key: from, value: dests) in pos.legalMoves.entries) {
      for (final to in dests.squares) {
        for (final move in _withPromotions(pos, from, to)) {
          final (next, san) = pos.makeSanUnchecked(move);
          if (_book.contains(epdOf(next))) out.add(san);
        }
      }
    }
    return out;
  }

  Iterable<NormalMove> _withPromotions(Position pos, Square from, Square to) sync* {
    final isPromotion = pos.board.roleAt(from) == Role.pawn && (to.rank == Rank.first || to.rank == Rank.eighth);
    if (!isPromotion) {
      yield NormalMove(from: from, to: to);
    } else {
      for (final r in [Role.queen, Role.rook, Role.bishop, Role.knight]) {
        yield NormalMove(from: from, to: to, promotion: r);
      }
    }
  }
}
