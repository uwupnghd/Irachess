import 'package:dartchess/dartchess.dart';

import '../../core/chess/chess_utils.dart';

enum GameEnd { checkmate, stalemate, repetition, fiftyMoves, material, resigned }

/// Partida en curso con todas las reglas de final (lógica pura).
class LiveGame {
  LiveGame([Position? start]) : positions = [start ?? Chess.initial];

  final List<Position> positions;
  final List<String> sans = [];
  final List<NormalMove> moves = [];
  GameEnd? end;
  Side? resignedBy;

  Position get position => positions.last;

  void play(NormalMove move) {
    final (next, san) = position.makeSan(move);
    sans.add(san);
    moves.add(move);
    positions.add(next);
    end = _detectEnd();
  }

  void resign(Side side) {
    end = GameEnd.resigned;
    resignedBy = side;
  }

  GameEnd? _detectEnd() {
    final p = position;
    if (p.isCheckmate) return GameEnd.checkmate;
    if (p.isStalemate) return GameEnd.stalemate;
    if (p.isInsufficientMaterial) return GameEnd.material;
    if (p.halfmoves >= 100) return GameEnd.fiftyMoves;
    final epd = epdOf(p);
    if (positions.where((x) => epdOf(x) == epd).length >= 3) return GameEnd.repetition;
    return null;
  }

  /// '1-0', '0-1', '1/2-1/2' o '*'.
  String get result => switch (end) {
    null => '*',
    GameEnd.checkmate => position.turn == Side.white ? '0-1' : '1-0',
    GameEnd.resigned => resignedBy == Side.white ? '0-1' : '1-0',
    _ => '1/2-1/2',
  };

  String pgn({required String white, required String black, required String date}) {
    final buf = StringBuffer()
      ..writeln('[Event "IraChess"]')
      ..writeln('[Date "$date"]')
      ..writeln('[White "$white"]')
      ..writeln('[Black "$black"]')
      ..writeln('[Result "$result"]')
      ..writeln();
    for (var i = 0; i < sans.length; i++) {
      if (i.isEven) buf.write('${i ~/ 2 + 1}. ');
      buf.write('${sans[i]} ');
    }
    buf.write(result);
    return buf.toString();
  }
}
