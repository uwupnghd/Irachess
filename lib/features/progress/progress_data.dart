import 'dart:convert';

import 'package:dartchess/dartchess.dart';
import 'package:drift/drift.dart';

import '../../core/chess/chess_utils.dart';
import '../../core/db/database.dart';
import '../analysis/domain/game_report.dart';

class OpeningStat {
  OpeningStat(this.family);
  final String family;
  int games = 0, wins = 0, draws = 0, losses = 0;
  final List<double> accuracies = [];
  double? get accuracy => accuracies.isEmpty ? null : accuracies.reduce((a, b) => a + b) / accuracies.length;
}

class ProgressData {
  const ProgressData({
    required this.accuracy,
    required this.ratings,
    required this.openings,
    required this.errorTypes,
    required this.streak,
    required this.today,
    required this.visionBest,
    required this.visionSessions,
  });

  final List<double> accuracy;
  final List<double> ratings;
  final List<OpeningStat> openings;

  /// tactical | opening | endgame | other → cantidad
  final Map<String, int> errorTypes;
  final int streak;
  final int today;
  final int visionBest;
  final int visionSessions;

  bool get isEmpty => accuracy.isEmpty && ratings.isEmpty && visionSessions == 0;
}

/// Racha de días consecutivos con actividad que termina hoy (o ayer).
int dailyStreak(Iterable<DateTime> activity, DateTime now) {
  final days = {for (final t in activity) DateTime(t.year, t.month, t.day)};
  var day = DateTime(now.year, now.month, now.day);
  if (!days.contains(day)) day = day.subtract(const Duration(days: 1));
  var n = 0;
  while (days.contains(day)) {
    n++;
    day = DateTime(day.year, day.month, day.day - 1);
  }
  return n;
}

/// Tipo de error: táctico si hubo un motivo; si no, por fase.
String errorType(MoveReport m) {
  if (m.motifs.isNotEmpty) return 'tactical';
  return switch (m.phase) {
    GamePhase.opening => 'opening',
    GamePhase.endgame => 'endgame',
    GamePhase.middlegame => 'other',
  };
}

Future<ProgressData> loadProgress(AppDatabase db, DateTime now) async {
  final rows = await (db.select(db.games).join([
    leftOuterJoin(db.gameAnalyses, db.gameAnalyses.gameId.equalsExp(db.games.id)),
  ])
        ..where(db.games.deleted.equals(false))
        ..orderBy([OrderingTerm.asc(db.games.createdAt)]))
      .get();
  final accuracy = <double>[];
  final openings = <String, OpeningStat>{};
  final errorTypes = <String, int>{'tactical': 0, 'opening': 0, 'endgame': 0, 'other': 0};
  final activity = <DateTime>[];
  for (final r in rows) {
    final g = r.readTable(db.games);
    final a = r.readTableOrNull(db.gameAnalyses);
    final side = g.userSide == null ? null : Side.values.byName(g.userSide!);
    if (a != null) {
      activity.add(a.createdAt);
      if (a.userAccuracy != null) accuracy.add(a.userAccuracy!);
      if (side != null) {
        final report = GameReport.fromJson(jsonDecode(a.report) as Map<String, Object?>);
        for (final m in report.moves.where((m) => m.side == side && m.cls.isBad)) {
          errorTypes[errorType(m)] = errorTypes[errorType(m)]! + 1;
        }
      }
    }
    if (g.openingName != null && side != null) {
      final s = openings.putIfAbsent(g.openingName!.split(':').first, () => OpeningStat(g.openingName!.split(':').first));
      s.games++;
      final won = (g.result == '1-0' && side == Side.white) || (g.result == '0-1' && side == Side.black);
      final lost = (g.result == '0-1' && side == Side.white) || (g.result == '1-0' && side == Side.black);
      if (won) {
        s.wins++;
      } else if (lost) {
        s.losses++;
      } else if (g.result == '1/2-1/2') {
        s.draws++;
      }
      if (a?.userAccuracy != null) s.accuracies.add(a!.userAccuracy!);
    }
  }
  final attempts = await (db.select(db.puzzleAttempts)..orderBy([(t) => OrderingTerm.asc(t.attemptedAt)])).get();
  activity.addAll(attempts.map((a) => a.attemptedAt));
  final vision = await db.select(db.visionSessions).get();
  activity.addAll(vision.map((v) => v.startedAt));
  final midnight = DateTime(now.year, now.month, now.day);
  return ProgressData(
    accuracy: accuracy,
    ratings: [for (final a in attempts) if (!a.puzzleId.startsWith('own-')) a.ratingAfter],
    openings: openings.values.toList()..sort((a, b) => b.games.compareTo(a.games)),
    errorTypes: errorTypes,
    streak: dailyStreak(activity, now),
    today: attempts.where((a) => !a.attemptedAt.isBefore(midnight)).length,
    visionBest: vision.fold(0, (m, v) => v.score > m ? v.score : m),
    visionSessions: vision.length,
  );
}
