import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/features/progress/progress_data.dart';

void main() {
  test('racha diaria', () {
    final now = DateTime(2026, 11, 26, 20);
    expect(dailyStreak([], now), 0);
    expect(dailyStreak([DateTime(2026, 11, 26, 8), DateTime(2026, 11, 25), DateTime(2026, 11, 24)], now), 3);
    // Si hoy aún no hay actividad, cuenta la racha hasta ayer.
    expect(dailyStreak([DateTime(2026, 11, 25), DateTime(2026, 11, 24)], now), 2);
    expect(dailyStreak([DateTime(2026, 11, 23)], now), 0);
    // Cambio de mes.
    expect(dailyStreak([DateTime(2026, 12, 1), DateTime(2026, 11, 30)], DateTime(2026, 12, 1, 9)), 2);
  });
}
