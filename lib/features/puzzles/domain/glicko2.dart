import 'dart:math';

/// Estado de rating Glicko-2.
class Rating {
  const Rating(this.rating, this.rd, this.vol);
  final double rating;
  final double rd;
  final double vol;

  static const initialRd = 350.0;
  static const initialVol = 0.06;
}

const _scale = 173.7178;
const _tau = 0.75;
const _minRd = 60.0; // para que el rating de problemas siga moviéndose
const _maxRd = 350.0;

double _g(double phi) => 1 / sqrt(1 + 3 * phi * phi / (pi * pi));

/// Actualiza [player] tras una partida contra un rival de [oppRating]/[oppRd].
/// [score]: 1 = resuelto, 0 = fallado (Glickman 2012, un solo periodo).
Rating glickoUpdate(Rating player, double oppRating, double oppRd, double score) {
  final mu = (player.rating - 1500) / _scale;
  final phi = player.rd / _scale;
  final muJ = (oppRating - 1500) / _scale;
  final phiJ = oppRd / _scale;
  final g = _g(phiJ);
  final e = 1 / (1 + exp(-g * (mu - muJ)));
  final v = 1 / (g * g * e * (1 - e));
  final delta = v * g * (score - e);

  final a = log(player.vol * player.vol);
  double f(double x) {
    final ex = exp(x);
    final num = ex * (delta * delta - phi * phi - v - ex);
    final den = 2 * pow(phi * phi + v + ex, 2);
    return num / den - (x - a) / (_tau * _tau);
  }

  var bigA = a;
  double bigB;
  if (delta * delta > phi * phi + v) {
    bigB = log(delta * delta - phi * phi - v);
  } else {
    var k = 1;
    while (f(a - k * _tau) < 0) {
      k++;
    }
    bigB = a - k * _tau;
  }
  var fA = f(bigA), fB = f(bigB);
  for (var i = 0; i < 100 && (bigB - bigA).abs() > 1e-6; i++) {
    final c = bigA + (bigA - bigB) * fA / (fB - fA);
    final fC = f(c);
    if (fC * fB <= 0) {
      bigA = bigB;
      fA = fB;
    } else {
      fA = fA / 2;
    }
    bigB = c;
    fB = fC;
  }
  final vol = exp(bigA / 2);
  final phiStar = sqrt(phi * phi + vol * vol);
  final newPhi = 1 / sqrt(1 / (phiStar * phiStar) + 1 / v);
  final newMu = mu + newPhi * newPhi * g * (score - e);
  return Rating(
    (newMu * _scale + 1500).clamp(100, 3500).toDouble(),
    (newPhi * _scale).clamp(_minRd, _maxRd).toDouble(),
    vol,
  );
}
