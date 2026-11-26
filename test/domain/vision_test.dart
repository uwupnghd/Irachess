import 'dart:math';

import 'package:dartchess/dartchess.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/features/vision/vision_game.dart';

void main() {
  test('aciertos, fallos, racha y fin por tiempo o aciertos', () {
    final g = VisionGame(VisionMode.hits20, random: Random(1));
    final first = g.target;
    expect(g.tap(first), isTrue);
    expect(g.target, isNot(first));
    final wrong = Square((g.target + 1) % 64);
    expect(g.tap(wrong), isFalse);
    expect((g.score, g.errors, g.streak, g.bestStreak), (1, 1, 0, 1));
    expect(g.misses.single.$2, wrong);
    for (var i = 0; i < 19; i++) {
      g.tap(g.target);
    }
    expect(g.finished(Duration.zero), isTrue);
    expect(VisionGame(VisionMode.time30).finished(const Duration(seconds: 30)), isTrue);
    expect(VisionGame(VisionMode.time30).finished(const Duration(seconds: 29)), isFalse);
  });

  test('casillas más falladas', () {
    final top = topMisses([
      [['e4', 'e5'], ['d4', 'd5']],
      [['e4', 'f4']],
    ]);
    expect(top.first, ('e4', 2));
  });
}
