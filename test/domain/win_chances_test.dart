import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/features/analysis/domain/win_chances.dart';

void main() {
  test('probabilidad de victoria', () {
    expect(winPercent(cp: 0), closeTo(50, 0.001));
    expect(winPercent(cp: 100), greaterThan(55));
    expect(winPercent(cp: -100), closeTo(100 - winPercent(cp: 100), 0.001));
    expect(winPercent(cp: 5000), winPercent(cp: 1000)); // acotado
    expect(winPercent(mate: 3), 100);
    expect(winPercent(mate: -1), 0);
  });

  test('precisión por jugada', () {
    expect(moveAccuracy(50, 50), 100);
    expect(moveAccuracy(50, 60), 100);
    expect(moveAccuracy(60, 40), inInclusiveRange(30, 50));
    expect(moveAccuracy(100, 0), 0);
  });

  test('precisión de partida', () {
    final perfect = gameAccuracy(List.filled(41, 55.0));
    expect(perfect.$1, closeTo(100, 0.01));
    expect(perfect.$2, closeTo(100, 0.01));
    // Las negras regalan toda la ventaja de golpe.
    final (w, b) = gameAccuracy([50, 50, 50, 50, 90, 90, 90]);
    expect(w!, greaterThan(b!));
    expect(gameAccuracy([50]), (null, null));
  });
}
