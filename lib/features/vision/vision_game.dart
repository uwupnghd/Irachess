import 'dart:math';

import 'package:dartchess/dartchess.dart';

enum VisionMode {
  time30(seconds: 30),
  time60(seconds: 60),
  hits20(target: 20);

  const VisionMode({this.seconds, this.target});
  final int? seconds;
  final int? target;
}

/// Lógica del entrenamiento de coordenadas (sin UI ni temporizador real).
class VisionGame {
  VisionGame(this.mode, {Random? random}) : _random = random ?? Random() {
    target = _pick();
  }

  final VisionMode mode;
  final Random _random;
  late Square target;
  int score = 0;
  int errors = 0;
  int streak = 0;
  int bestStreak = 0;
  final List<(Square target, Square tapped)> misses = [];

  Square _pick() {
    Square s;
    do {
      s = Square(_random.nextInt(64));
    } while (score + errors > 0 && s == target);
    return s;
  }

  /// Devuelve true si se acertó. Siempre cambia de casilla al acertar.
  bool tap(Square square) {
    if (square == target) {
      score++;
      streak++;
      bestStreak = max(bestStreak, streak);
      target = _pick();
      return true;
    }
    errors++;
    streak = 0;
    misses.add((target, square));
    return false;
  }

  bool finished(Duration elapsed) =>
      (mode.seconds != null && elapsed.inSeconds >= mode.seconds!) || (mode.target != null && score >= mode.target!);
}

/// Casillas más falladas a partir de las sesiones guardadas.
List<(String square, int count)> topMisses(Iterable<List<List<String>>> sessions, {int top = 5}) {
  final counts = <String, int>{};
  for (final s in sessions) {
    for (final m in s) {
      counts[m.first] = (counts[m.first] ?? 0) + 1;
    }
  }
  final list = counts.entries.map((e) => (e.key, e.value)).toList()..sort((a, b) => b.$2.compareTo(a.$2));
  return list.take(top).toList();
}
