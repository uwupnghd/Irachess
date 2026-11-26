import 'dart:convert';

import 'package:dartchess/dartchess.dart';

import '../../../core/chess/chess_utils.dart';

class Puzzle {
  const Puzzle({
    required this.id,
    required this.fen,
    required this.moves,
    required this.rating,
    required this.themes,
    required this.source,
    this.gameId,
    this.ply,
    this.note,
  });

  final String id;
  final String fen;

  /// Lichess: la 1.ª jugada es del rival y luego empieza la solución.
  /// Propios (`own`): la posición ya es tu turno y la solución es la 1.ª.
  final List<String> moves;
  final int rating;
  final List<String> themes;
  final String source;
  final int? gameId;
  final int? ply;

  /// Datos extra de los problemas propios (JSON): jugada hecha, mejor,
  /// alternativas aceptadas y explicación.
  final Map<String, Object?>? note;

  bool get hasPreMove => source != 'own';

  List<String> get accepted => (note?['accept'] as List<Object?>? ?? const []).cast<String>();

  static Puzzle fromCsvLine(String line, {required String source, String? packId}) {
    final c = line.split(',');
    return Puzzle(
      id: c[0],
      fen: c[1],
      moves: c[2].split(' '),
      rating: int.parse(c[3]),
      themes: c[5].split(' ').where((t) => t.isNotEmpty).toList(),
      source: source,
    );
  }

  static Map<String, Object?>? decodeNote(String? s) => s == null ? null : jsonDecode(s) as Map<String, Object?>;
}

enum PuzzleStep { correct, wrong, solved }

/// Estado de un problema en curso (lógica pura, sin UI).
class PuzzleRun {
  PuzzleRun(this.puzzle) {
    position = positionFromFen(puzzle.fen);
    if (puzzle.hasPreMove) {
      final pre = parseUciMove(position, puzzle.moves.first)!;
      position = position.play(pre);
      lastMove = pre;
      _i = 1;
    }
    userSide = position.turn;
  }

  final Puzzle puzzle;
  late Position position;
  late final Side userSide;
  NormalMove? lastMove;
  int _i = 0;
  int mistakes = 0;
  bool done = false;

  String get expectedUci => puzzle.moves[_i];
  NormalMove? get expectedMove => done ? null : parseUciMove(position, expectedUci);

  /// Juega la jugada del usuario. Si es correcta y queda solución, responde
  /// el rival automáticamente (se devuelve su jugada).
  (PuzzleStep, NormalMove? reply) play(NormalMove move) {
    if (done) return (PuzzleStep.solved, null);
    final uci = standardUci(position, move);
    final next = position.play(move);
    final last = _i == puzzle.moves.length - 1;
    final ok = uci == expectedUci || next.isCheckmate || (last && puzzle.accepted.contains(uci));
    if (!ok) {
      mistakes++;
      return (PuzzleStep.wrong, null);
    }
    position = next;
    lastMove = move;
    _i++;
    if (_i >= puzzle.moves.length || next.isCheckmate) {
      done = true;
      return (PuzzleStep.solved, null);
    }
    final reply = parseUciMove(position, puzzle.moves[_i])!;
    position = position.play(reply);
    lastMove = reply;
    _i++;
    if (_i >= puzzle.moves.length) {
      done = true;
      return (PuzzleStep.solved, reply);
    }
    return (PuzzleStep.correct, reply);
  }
}
