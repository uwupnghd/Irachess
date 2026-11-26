import 'dart:math';

import 'package:dartchess/dartchess.dart';

import '../../../core/chess/chess_utils.dart';
import '../../../core/engine/uci_engine.dart';
import '../../games/domain/pgn_import.dart';
import '../../openings/opening_book.dart';
import 'motifs.dart';
import 'win_chances.dart';

/// Clasificación de una jugada (orden = de mejor a peor para la UI).
enum MoveClass { brilliant, great, book, best, excellent, good, inaccuracy, miss, mistake, blunder, forced }

extension MoveClassX on MoveClass {
  bool get isError => this == MoveClass.mistake || this == MoveClass.blunder || this == MoveClass.miss;
  bool get isBad => isError || this == MoveClass.inaccuracy;
}

/// Umbrales en puntos de probabilidad de victoria (0–100). Ver docs/PROPUESTA.md §5.
abstract final class Thresholds {
  static const excellent = 2.0;
  static const good = 5.0;
  static const inaccuracy = 10.0;
  static const mistake = 20.0;
  static const greatGap = 10.0;
  static const brilliantMaxWinBefore = 95.0;
  static const brilliantMinWinAfter = 50.0;
  static const sacrificeMin = 2;
}

/// Datos para clasificar una jugada (todo desde el punto de vista de quien mueve).
class ClassifyInput {
  const ClassifyInput({
    required this.deltaW,
    required this.winBefore,
    required this.winAfter,
    this.isBest = false,
    this.isBook = false,
    this.isForced = false,
    this.isSacrifice = false,
    this.isRecapture = false,
    this.secondBestGap,
    this.opponentErred = false,
  });

  final double deltaW;
  final double winBefore;
  final double winAfter;
  final bool isBest;
  final bool isBook;
  final bool isForced;
  final bool isSacrifice;
  final bool isRecapture;
  final double? secondBestGap;
  final bool opponentErred;
}

MoveClass classify(ClassifyInput c) {
  if (c.isForced) return MoveClass.forced;
  if (c.isBook) return MoveClass.book;
  final d = max(0.0, c.deltaW);
  if (d <= Thresholds.excellent &&
      c.isSacrifice &&
      c.winBefore <= Thresholds.brilliantMaxWinBefore &&
      c.winAfter >= Thresholds.brilliantMinWinAfter) {
    return MoveClass.brilliant;
  }
  if (c.isBest && !c.isRecapture && (c.secondBestGap ?? 0) >= Thresholds.greatGap) return MoveClass.great;
  if (c.isBest) return MoveClass.best;
  if (c.opponentErred && d > Thresholds.inaccuracy && d <= Thresholds.mistake) return MoveClass.miss;
  if (d <= Thresholds.excellent) return MoveClass.excellent;
  if (d <= Thresholds.good) return MoveClass.good;
  if (d <= Thresholds.inaccuracy) return MoveClass.inaccuracy;
  if (d <= Thresholds.mistake) return MoveClass.mistake;
  return MoveClass.blunder;
}

/// Fragmento de explicación: clave de traducción + argumentos (texto plano).
class ExplPart {
  const ExplPart(this.key, [this.args = const {}]);
  final String key;
  final Map<String, String> args;

  Map<String, Object?> toJson() => {'k': key, 'a': args};
  factory ExplPart.fromJson(Map<String, Object?> j) =>
      ExplPart(j['k']! as String, (j['a'] as Map<String, Object?>? ?? const {}).cast<String, String>());
}

class AltMove {
  const AltMove(this.san, this.uci, this.cp, this.mate, this.line);
  final String san;
  final String uci;
  final int? cp;
  final int? mate;
  final List<String> line;

  Map<String, Object?> toJson() => {'san': san, 'uci': uci, 'cp': cp, 'mate': mate, 'line': line};
  factory AltMove.fromJson(Map<String, Object?> j) => AltMove(
    j['san']! as String,
    j['uci']! as String,
    j['cp'] as int?,
    j['mate'] as int?,
    (j['line'] as List<Object?>? ?? const []).cast<String>(),
  );
}

class MoveReport {
  const MoveReport({
    required this.ply,
    required this.san,
    required this.uci,
    required this.fenBefore,
    required this.winBefore,
    required this.winAfter,
    required this.cls,
    required this.phase,
    this.alternatives = const [],
    this.explanation = const [],
    this.motifs = const [],
    this.cpAfter,
    this.mateAfter,
    this.timeSpent,
  });

  final int ply;
  final String san;
  final String uci;
  final String fenBefore;

  /// Probabilidad de victoria de quien mueve antes y después (0–100).
  final double winBefore;
  final double winAfter;
  final MoveClass cls;
  final GamePhase phase;

  /// Mejor jugada del motor + alternativas (máx. 3).
  final List<AltMove> alternatives;
  final List<ExplPart> explanation;
  final List<String> motifs;

  /// Evaluación tras la jugada desde el punto de vista de las blancas.
  final int? cpAfter;
  final int? mateAfter;
  final Duration? timeSpent;

  Side get side => whiteMoved ? Side.white : Side.black;
  int get moveNumber => int.parse(fenBefore.split(' ')[5]);
  bool get whiteMoved => fenBefore.split(' ')[1] == 'w';
  double get deltaW => max(0, winBefore - winAfter);
  AltMove? get best => alternatives.isEmpty ? null : alternatives.first;
  double get whiteWinAfter => whiteMoved ? winAfter : 100 - winAfter;

  Map<String, Object?> toJson() => {
    'ply': ply,
    'san': san,
    'uci': uci,
    'fen': fenBefore,
    'wb': winBefore,
    'wa': winAfter,
    'cls': cls.name,
    'ph': phase.name,
    'alt': [for (final a in alternatives) a.toJson()],
    'ex': [for (final e in explanation) e.toJson()],
    'mo': motifs,
    'cp': cpAfter,
    'mate': mateAfter,
    'ts': timeSpent?.inMilliseconds,
  };

  factory MoveReport.fromJson(Map<String, Object?> j) => MoveReport(
    ply: j['ply']! as int,
    san: j['san']! as String,
    uci: j['uci']! as String,
    fenBefore: j['fen']! as String,
    winBefore: (j['wb']! as num).toDouble(),
    winAfter: (j['wa']! as num).toDouble(),
    cls: MoveClass.values.byName(j['cls']! as String),
    phase: GamePhase.values.byName(j['ph']! as String),
    alternatives: [for (final a in j['alt']! as List<Object?>) AltMove.fromJson(a! as Map<String, Object?>)],
    explanation: [for (final e in j['ex']! as List<Object?>) ExplPart.fromJson(e! as Map<String, Object?>)],
    motifs: (j['mo']! as List<Object?>).cast<String>(),
    cpAfter: j['cp'] as int?,
    mateAfter: j['mate'] as int?,
    timeSpent: j['ts'] == null ? null : Duration(milliseconds: j['ts']! as int),
  );
}

class PhaseStats {
  const PhaseStats(this.moves, this.accuracy, this.errors);
  final int moves;
  final double? accuracy;
  final int errors;

  Map<String, Object?> toJson() => {'n': moves, 'acc': accuracy, 'err': errors};
  factory PhaseStats.fromJson(Map<String, Object?> j) =>
      PhaseStats(j['n']! as int, (j['acc'] as num?)?.toDouble(), j['err']! as int);
}

class GameReport {
  const GameReport({
    required this.moves,
    required this.accuracyWhite,
    required this.accuracyBlack,
    required this.opening,
    required this.critical,
    required this.phases,
    required this.recommendations,
    required this.startWhiteWin,
  });

  final List<MoveReport> moves;
  final double? accuracyWhite;
  final double? accuracyBlack;
  final OpeningResult opening;

  /// Plies de los momentos críticos (mayores caídas), en orden de partida.
  final List<int> critical;

  /// Estadísticas por fase para cada bando: 'white.opening' → stats.
  final Map<String, PhaseStats> phases;

  /// Recomendaciones (clave de traducción + argumentos).
  final List<ExplPart> recommendations;
  final double startWhiteWin;

  Map<MoveClass, int> counts(Side side) {
    final out = {for (final c in MoveClass.values) c: 0};
    for (final m in moves.where((m) => m.side == side)) {
      out[m.cls] = out[m.cls]! + 1;
    }
    return out;
  }

  double? accuracy(Side side) => side == Side.white ? accuracyWhite : accuracyBlack;

  /// Probabilidad de las blancas en cada posición (n jugadas → n+1 puntos).
  List<double> get whiteWins => [startWhiteWin, for (final m in moves) m.whiteWinAfter];

  Map<String, Object?> toJson() => {
    'moves': [for (final m in moves) m.toJson()],
    'accW': accuracyWhite,
    'accB': accuracyBlack,
    'opening': opening.toJson(),
    'critical': critical,
    'phases': {for (final e in phases.entries) e.key: e.value.toJson()},
    'rec': [for (final r in recommendations) r.toJson()],
    'w0': startWhiteWin,
  };

  factory GameReport.fromJson(Map<String, Object?> j) => GameReport(
    moves: [for (final m in j['moves']! as List<Object?>) MoveReport.fromJson(m! as Map<String, Object?>)],
    accuracyWhite: (j['accW'] as num?)?.toDouble(),
    accuracyBlack: (j['accB'] as num?)?.toDouble(),
    opening: OpeningResult.fromJson(j['opening']! as Map<String, Object?>),
    critical: (j['critical']! as List<Object?>).cast<int>(),
    phases: {
      for (final e in (j['phases']! as Map<String, Object?>).entries)
        e.key: PhaseStats.fromJson(e.value! as Map<String, Object?>),
    },
    recommendations: [for (final r in j['rec']! as List<Object?>) ExplPart.fromJson(r! as Map<String, Object?>)],
    startWhiteWin: (j['w0'] as num?)?.toDouble() ?? 50,
  );
}

/// Entrada para construir el informe (se envía a otro Isolate con `compute`).
class ReportInput {
  const ReportInput({required this.game, required this.evals, required this.opening, this.userSide});

  final ParsedGame game;

  /// Líneas del motor para cada posición (n+1). Vacía si la partida terminó.
  final List<List<EngineLine>> evals;
  final OpeningResult opening;
  final Side? userSide;
}

/// Evaluación de una posición desde el punto de vista de quien mueve.
double _positionWin(Position pos, List<EngineLine> lines) {
  if (pos.isCheckmate) return 0;
  if (pos.isStalemate || pos.isInsufficientMaterial) return 50;
  if (lines.isEmpty) return 50;
  return winPercent(cp: lines.first.cp, mate: lines.first.mate);
}

String _pawns(double win) {
  // Convierte probabilidad a "ventaja" legible en peones (inversa de la fórmula).
  final w = win.clamp(0.5, 99.5) / 100;
  final cp = log(w / (1 - w)) / 0.00368208;
  final p = (cp / 100).clamp(-99, 99);
  return '${p >= 0 ? '+' : '−'}${p.abs().toStringAsFixed(1)}';
}

GameReport buildReport(ReportInput input) {
  final game = input.game;
  final positions = game.positions();
  final exit = input.opening.exitPly;
  final moves = <MoveReport>[];
  MoveClass? prevClass;
  Duration? lastClock(int ply) {
    for (var i = ply - 2; i >= 0; i -= 2) {
      if (game.plies[i].clock != null) return game.plies[i].clock;
    }
    return null;
  }

  for (var i = 0; i < game.plies.length; i++) {
    final ply = game.plies[i];
    final before = positions[i], after = positions[i + 1];
    final linesBefore = input.evals[i];
    final linesAfter = input.evals[i + 1];
    final winBefore = _positionWin(before, linesBefore);
    final winAfter = 100 - _positionWin(after, linesAfter);
    final move = parseUciMove(before, ply.uci)!;
    final isBook = exit == null ? input.opening.opening != null : i < exit;
    final best = linesBefore.isEmpty ? null : linesBefore.first;
    final isBest = best != null && best.uci == ply.uci;
    final second = linesBefore.length > 1 ? linesBefore[1] : null;
    final prevMove = i > 0 ? game.plies[i - 1].uci : null;
    final isRecapture =
        prevMove != null && prevMove.substring(2, 4) == ply.uci.substring(2, 4) && before.board.occupied.has(move.to);
    final sacrifice = _isSacrifice(before, after, move, linesAfter);
    final cls = classify(ClassifyInput(
      deltaW: winBefore - winAfter,
      winBefore: winBefore,
      winAfter: winAfter,
      isBest: isBest,
      isBook: isBook,
      isForced: before.legalMoves.values.fold<int>(0, (s, d) => s + d.size) == 1,
      isSacrifice: sacrifice,
      isRecapture: isRecapture,
      secondBestGap: best != null && second != null
          ? winPercent(cp: best.cp, mate: best.mate) - winPercent(cp: second.cp, mate: second.mate)
          : null,
      opponentErred: prevClass != null && (prevClass == MoveClass.mistake || prevClass == MoveClass.blunder),
    ));
    prevClass = cls;

    final alternatives = [
      for (final l in linesBefore.take(3))
        AltMove(sanOf(before, l.uci), l.uci, l.cp, l.mate, sanLine(before, l.pv, max: 8)),
    ];
    final (explanation, motifs) = _explain(
      cls: cls,
      before: before,
      after: after,
      move: move,
      san: ply.san,
      linesBefore: linesBefore,
      linesAfter: linesAfter,
      winBefore: winBefore,
      winAfter: winAfter,
      opening: input.opening,
    );
    final afterLine = linesAfter.isEmpty ? null : linesAfter.first;
    final whiteSign = after.turn == Side.white ? 1 : -1;
    Duration? spent;
    final prevClock = lastClock(i);
    if (ply.clock != null && prevClock != null) {
      spent = prevClock - ply.clock! + Duration(seconds: game.incrementSeconds);
      if (spent.isNegative) spent = Duration.zero;
    }
    moves.add(MoveReport(
      ply: i,
      san: ply.san,
      uci: ply.uci,
      fenBefore: ply.fenBefore,
      winBefore: winBefore,
      winAfter: winAfter,
      cls: cls,
      phase: phaseOf(after.board, ply: i, inBook: isBook),
      alternatives: alternatives,
      explanation: explanation,
      motifs: motifs,
      cpAfter: after.isCheckmate ? null : (afterLine?.cp == null ? null : afterLine!.cp! * whiteSign),
      mateAfter: after.isCheckmate
          ? 0
          : (afterLine?.mate == null ? null : afterLine!.mate! * whiteSign),
      timeSpent: spent,
    ));
  }

  final startWhite = positions.first.turn == Side.white
      ? _positionWin(positions.first, input.evals.first)
      : 100 - _positionWin(positions.first, input.evals.first);
  final whiteWins = [startWhite, for (final m in moves) m.whiteWinAfter];
  final (accW, accB) = gameAccuracy(whiteWins, whiteStarts: positions.first.turn == Side.white);

  final critical = ([...moves.where((m) => m.cls != MoveClass.book && m.deltaW >= Thresholds.good)]
        ..sort((a, b) => b.deltaW.compareTo(a.deltaW)))
      .take(5)
      .map((m) => m.ply)
      .toList()
    ..sort();

  final phases = <String, PhaseStats>{};
  for (final side in Side.values) {
    for (final phase in GamePhase.values) {
      final ms = moves.where((m) => m.side == side && m.phase == phase).toList();
      if (ms.isEmpty) continue;
      final acc = ms.map((m) => moveAccuracy(m.winBefore, m.winAfter)).reduce((a, b) => a + b) / ms.length;
      phases['${side.name}.${phase.name}'] = PhaseStats(ms.length, acc, ms.where((m) => m.cls.isError).length);
    }
  }

  return GameReport(
    moves: moves,
    accuracyWhite: accW,
    accuracyBlack: accB,
    opening: input.opening,
    critical: critical,
    phases: phases,
    recommendations: recommendationsFor(moves, input.userSide, input.opening),
    startWhiteWin: startWhite,
  );
}

/// Sacrificio: la jugada deja material en prise (>= 2 puntos netos) y la mejor
/// línea del rival no lo devuelve en 4 medias jugadas.
bool _isSacrifice(Position before, Position after, NormalMove move, List<EngineLine> linesAfter) {
  final mover = before.turn;
  final captured = before.board.roleAt(move.to);
  final capturedValue = captured == null || before.board.sideAt(move.to) == mover ? 0 : roleValue[captured]!;
  var worst = 0;
  for (final sq in after.board.bySide(mover).diff(after.board.kings).diff(after.board.pawns).squares) {
    worst = max(worst, staticExchange(after.board, sq, mover.opposite));
  }
  if (worst - capturedValue < Thresholds.sacrificeMin) return false;
  if (linesAfter.isEmpty) return false;
  final balanceBefore = materialBalance(before.board, mover);
  return materialAfterLine(after, linesAfter.first.pv, mover, plies: 4) - balanceBefore <= -Thresholds.sacrificeMin;
}

String _roleName(Role r) => r.name;

(List<ExplPart>, List<String>) _explain({
  required MoveClass cls,
  required Position before,
  required Position after,
  required NormalMove move,
  required String san,
  required List<EngineLine> linesBefore,
  required List<EngineLine> linesAfter,
  required double winBefore,
  required double winAfter,
  required OpeningResult opening,
}) {
  final best = linesBefore.isEmpty ? null : linesBefore.first;
  final bestSan = best == null ? null : sanOf(before, best.uci);
  switch (cls) {
    case MoveClass.forced:
      return (const [ExplPart('forced')], const []);
    case MoveClass.book:
      return ([ExplPart('book', {'opening': opening.opening?.name ?? ''})], const []);
    case MoveClass.brilliant:
      return (const [ExplPart('brilliant')], const ['sacrifice']);
    case MoveClass.great:
      return (const [ExplPart('great')], const []);
    case MoveClass.best:
      return (const [ExplPart('best')], const []);
    case MoveClass.excellent:
    case MoveClass.good:
      return ([ExplPart('goodAlt', {'best': bestSan ?? ''})], const []);
    case MoveClass.inaccuracy:
    case MoveClass.mistake:
    case MoveClass.blunder:
    case MoveClass.miss:
      break;
  }

  final parts = <ExplPart>[];
  final motifs = <String>[];
  final mover = before.turn;
  if (cls == MoveClass.miss) parts.add(const ExplPart('miss'));

  // 1. Qué pasó: la refutación del rival.
  final reply = linesAfter.isEmpty ? null : linesAfter.first;
  if (reply != null && reply.mate != null && reply.mate! > 0) {
    parts.add(ExplPart('allowsMate', {
      'n': '${reply.mate}',
      'line': sanLine(after, reply.pv, max: reply.mate! * 2 - 1).join(' '),
    }));
    motifs.add('mate');
  } else if (reply != null) {
    final r1 = parseUciMove(after, reply.uci);
    if (r1 != null) {
      final replySan = sanOf(after, reply.uci);
      final afterReply = after.playUnchecked(r1);
      final capturedRole = after.board.sideAt(r1.to) == mover ? after.board.roleAt(r1.to) : null;
      final fork = forkAt(afterReply, r1.to);
      final pin = pinCreatedBy(afterReply, r1.to);
      final disc = discoveredAttack(after, r1);
      if (capturedRole != null && staticExchange(after.board, r1.to, mover.opposite) > 0) {
        parts.add(ExplPart('hanging', {'piece': _roleName(capturedRole), 'square': r1.to.name, 'reply': replySan}));
        motifs.add('hanging');
      } else if (fork != null) {
        parts.add(ExplPart('fork', {
          'reply': replySan,
          'piece1': _roleName(fork.targets[0].$2),
          'piece2': _roleName(fork.targets[1].$2),
        }));
        motifs.add('fork');
      } else if (pin != null) {
        parts.add(ExplPart('pin', {
          'reply': replySan,
          'piece': _roleName(pin.pinnedRole),
          'square': pin.pinned.name,
          'behind': _roleName(pin.behindRole),
        }));
        motifs.add('pin');
      } else if (disc != null) {
        parts.add(ExplPart('discovered', {'reply': replySan, 'piece': _roleName(disc.$2)}));
        motifs.add('discovered');
      } else {
        final lost = materialBalance(before.board, mover) - materialAfterLine(after, reply.pv, mover);
        if (lost >= 2) {
          parts.add(ExplPart('losesMaterial', {
            'n': '$lost',
            'line': sanLine(after, reply.pv, max: 4).join(' '),
          }));
          motifs.add('material');
        }
      }
    }
  }

  // 2. Qué era mejor.
  if (best != null && bestSan != null) {
    final b = parseUciMove(before, best.uci);
    if (best.mate != null && best.mate! > 0) {
      parts.add(ExplPart('missedMate', {'n': '${best.mate}', 'best': bestSan}));
      motifs.add('missedMate');
    } else if (b != null) {
      final afterBest = before.playUnchecked(b);
      final captured = before.board.sideAt(b.to) == mover.opposite ? before.board.roleAt(b.to) : null;
      final fork = forkAt(afterBest, b.to);
      final pin = pinCreatedBy(afterBest, b.to);
      final disc = discoveredAttack(before, b);
      if (captured != null && staticExchange(before.board, b.to, mover) > 0) {
        parts.add(ExplPart('bestWins', {'best': bestSan, 'piece': _roleName(captured)}));
      } else if (fork != null) {
        parts.add(ExplPart('bestFork', {
          'best': bestSan,
          'piece1': _roleName(fork.targets[0].$2),
          'piece2': _roleName(fork.targets[1].$2),
        }));
      } else if (pin != null) {
        parts.add(ExplPart('bestPin', {'best': bestSan, 'piece': _roleName(pin.pinnedRole)}));
      } else if (disc != null) {
        parts.add(ExplPart('bestDiscovered', {'best': bestSan, 'piece': _roleName(disc.$2)}));
      } else if (afterBest.isCheck) {
        parts.add(ExplPart('bestCheck', {'best': bestSan}));
      } else if (bestSan.startsWith('O-O')) {
        parts.add(ExplPart('bestCastle', {'best': bestSan}));
      } else {
        parts.add(ExplPart('bestGeneric', {'best': bestSan}));
      }
    }
  }

  if (motifs.isEmpty || motifs.every((m) => m == 'missedMate')) {
    parts.insert(cls == MoveClass.miss ? 1 : 0,
        ExplPart('evalDrop', {'before': _pawns(winBefore), 'after': _pawns(winAfter)}));
  }
  return (parts, motifs);
}

/// Recomendaciones de práctica a partir de los fallos del usuario (o de
/// ambos bandos si no se sabe cuál es).
List<ExplPart> recommendationsFor(List<MoveReport> moves, Side? userSide, OpeningResult opening) {
  final mine = moves.where((m) => (userSide == null || m.side == userSide) && m.cls.isBad).toList();
  int count(bool Function(MoveReport) f) => mine.where(f).length;
  final scored = <(int, ExplPart)>[
    (count((m) => m.motifs.contains('hanging')) * 3, const ExplPart('recHanging')),
    (count((m) => m.motifs.contains('fork')) * 3, const ExplPart('recFork')),
    (count((m) => m.motifs.contains('pin') || m.motifs.contains('discovered')) * 3, const ExplPart('recPin')),
    (count((m) => m.motifs.contains('mate') || m.motifs.contains('missedMate')) * 3, const ExplPart('recMate')),
    (count((m) => m.phase == GamePhase.opening) * 2,
        ExplPart('recOpening', {'opening': opening.opening?.family ?? ''})),
    (count((m) => m.phase == GamePhase.endgame) * 2, const ExplPart('recEndgame')),
    (count((m) => m.cls == MoveClass.miss) * 2, const ExplPart('recMiss')),
  ]..sort((a, b) => b.$1.compareTo(a.$1));
  final out = [for (final (score, part) in scored.take(3)) if (score >= 2) part];
  return out.isEmpty ? const [ExplPart('recKeepGoing')] : out;
}
