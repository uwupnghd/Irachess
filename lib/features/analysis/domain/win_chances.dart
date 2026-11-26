import 'dart:math';

/// Probabilidad de victoria (0–100) a partir de centipeones, fórmula pública
/// de Lichess. Mate a favor = 100, en contra = 0.
double winPercent({int? cp, int? mate}) {
  if (mate != null) return mate > 0 ? 100 : 0;
  final c = (cp ?? 0).clamp(-1000, 1000);
  return 50 + 50 * (2 / (1 + exp(-0.00368208 * c)) - 1);
}

/// Precisión de una jugada (0–100) según la caída de probabilidad (Lichess).
double moveAccuracy(double winBefore, double winAfter) {
  if (winAfter >= winBefore) return 100;
  final raw = 103.1668100711649 * exp(-0.04354415386753951 * (winBefore - winAfter)) - 3.166924740191411;
  return (raw + 1).clamp(0, 100).toDouble();
}

/// Precisión de partida por bando (algoritmo de Lichess: media ponderada por
/// volatilidad + media armónica). [whiteWins] son las probabilidades de las
/// blancas en cada posición (n jugadas → n+1 valores). Devuelve (blancas, negras).
(double?, double?) gameAccuracy(List<double> whiteWins, {bool whiteStarts = true}) {
  if (whiteWins.length < 2) return (null, null);
  final moves = whiteWins.length - 1;
  final window = (moves ~/ 10).clamp(2, 8);
  final w = min(window, whiteWins.length);
  final windows = <List<double>>[
    for (var i = 0; i < w - 2; i++) whiteWins.sublist(0, w),
    for (var i = 0; i + w <= whiteWins.length; i++) whiteWins.sublist(i, i + w),
  ];
  final weights = [for (final xs in windows) _stdDev(xs).clamp(0.5, 12).toDouble()];
  final byColor = <bool, List<(double, double)>>{true: [], false: []};
  for (var i = 0; i < moves; i++) {
    final white = (i % 2 == 0) == whiteStarts;
    final prev = whiteWins[i], next = whiteWins[i + 1];
    final acc = white ? moveAccuracy(prev, next) : moveAccuracy(100 - prev, 100 - next);
    byColor[white]!.add((acc, weights[min(i, weights.length - 1)]));
  }
  double? colorAccuracy(List<(double, double)> xs) {
    if (xs.isEmpty) return null;
    final weightSum = xs.fold<double>(0, (s, x) => s + x.$2);
    final weighted = xs.fold<double>(0, (s, x) => s + x.$1 * x.$2) / weightSum;
    final harmonic = xs.length / xs.fold<double>(0, (s, x) => s + 1 / max(1, x.$1));
    return (weighted + harmonic) / 2;
  }

  return (colorAccuracy(byColor[true]!), colorAccuracy(byColor[false]!));
}

double _stdDev(List<double> xs) {
  final mean = xs.reduce((a, b) => a + b) / xs.length;
  final variance = xs.fold<double>(0, (s, x) => s + (x - mean) * (x - mean)) / xs.length;
  return sqrt(variance);
}
