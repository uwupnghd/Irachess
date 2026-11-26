import 'dart:convert';

import '../../core/db/database.dart';
import '../../core/settings/settings.dart';

/// Exporta todos los datos del usuario a JSON (portabilidad).
Future<String> exportAllJson(AppDatabase db, Settings settings) async {
  return const JsonEncoder.withIndent(' ').convert({
    'app': 'IraChess',
    'version': 1,
    'exportedAt': DateTime.now().toIso8601String(),
    'settings': settings.toJson(),
    'games': [for (final r in await db.select(db.games).get()) r.toJson()],
    'analyses': [for (final r in await db.select(db.gameAnalyses).get()) r.toJson()],
    'puzzleAttempts': [for (final r in await db.select(db.puzzleAttempts).get()) r.toJson()],
    'visionSessions': [for (final r in await db.select(db.visionSessions).get()) r.toJson()],
    'ownPuzzles': [for (final r in await (db.select(db.puzzles)..where((t) => t.source.equals('own'))).get()) r.toJson()],
  });
}
