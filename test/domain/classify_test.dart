import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/features/analysis/domain/game_report.dart';

MoveClass c(double d, {double before = 50, bool best = false, bool sac = false, double? gap, bool erred = false}) =>
    classify(ClassifyInput(
      deltaW: d,
      winBefore: before,
      winAfter: before - d,
      isBest: best,
      isSacrifice: sac,
      secondBestGap: gap,
      opponentErred: erred,
    ));

void main() {
  test('umbrales por caída de probabilidad', () {
    expect(c(0, best: true), MoveClass.best);
    expect(c(1.5), MoveClass.excellent);
    expect(c(4), MoveClass.good);
    expect(c(8), MoveClass.inaccuracy);
    expect(c(15), MoveClass.mistake);
    expect(c(35), MoveClass.blunder);
    expect(c(-3), MoveClass.excellent); // mejor de lo que esperaba el motor
  });

  test('teoría y jugada forzada tienen prioridad', () {
    expect(classify(const ClassifyInput(deltaW: 30, winBefore: 50, winAfter: 20, isBook: true)), MoveClass.book);
    expect(classify(const ClassifyInput(deltaW: 30, winBefore: 50, winAfter: 20, isForced: true)), MoveClass.forced);
  });

  test('brillante: sacrificio casi perfecto sin estar ya ganado', () {
    expect(c(1, before: 60, sac: true), MoveClass.brilliant);
    expect(c(1, before: 98, sac: true), isNot(MoveClass.brilliant)); // ya ganaba
    expect(c(1, before: 45, sac: true), isNot(MoveClass.brilliant)); // queda perdiendo
    expect(c(5, before: 70, sac: true), isNot(MoveClass.brilliant));
  });

  test('genial: única jugada buena, salvo recaptura', () {
    expect(c(0, best: true, gap: 15), MoveClass.great);
    expect(c(0, best: true, gap: 5), MoveClass.best);
    expect(
      classify(const ClassifyInput(deltaW: 0, winBefore: 50, winAfter: 50, isBest: true, isRecapture: true, secondBestGap: 40)),
      MoveClass.best,
    );
  });

  test('omisión: no castigar un error rival', () {
    expect(c(15, erred: true), MoveClass.miss);
    expect(c(30, erred: true), MoveClass.blunder);
    expect(c(8, erred: true), MoveClass.inaccuracy);
  });
}
