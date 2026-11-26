import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/db/database.dart';
import '../games/domain/pgn_import.dart';
import '../puzzles/data/puzzle_repository.dart';
import 'remote_store.dart';

/// Sincronización sin pérdidas ni duplicados:
/// - Intentos de problemas y sesiones de Visión: registros de solo inserción
///   con UUID → se unen (insertOrIgnore) en ambos sentidos.
/// - Partidas: clave natural (origen + id externo); gana la última escritura
///   (`updatedAt`); los borrados viajan como lápidas.
/// - Rating y rachas se recalculan desde el historial tras descargar.
/// - Los análisis no se sincronizan: se recalculan (y se cachean) localmente.
class SyncService {
  SyncService(this.db, this.remote, this.prefs, this.puzzles);
  final AppDatabase db;
  final RemoteStore remote;
  final SharedPreferences prefs;
  final PuzzleRepository puzzles;

  DateTime? _mark(String k) => DateTime.tryParse(prefs.getString('sync.$k') ?? '');
  Future<void> _setMark(String k, Iterable<RemoteRow> rows) async {
    DateTime? max;
    for (final r in rows) {
      final t = DateTime.parse(r['server_at']! as String);
      if (max == null || t.isAfter(max)) max = t;
    }
    if (max != null) await prefs.setString('sync.$k', max.toIso8601String());
  }

  /// Devuelve (enviados, recibidos).
  Future<(int, int)> sync() async {
    var up = 0, down = 0;

    // 1. Partidas: primero bajar y aplicar lo más reciente; luego subir.
    final remoteGames = await remote.since('games', _mark('games'));
    for (final r in remoteGames) {
      if (await _applyGame(r)) down++;
    }
    await _setMark('games', remoteGames);
    final pushedAt = DateTime.tryParse(prefs.getString('sync.gamesPushed') ?? '') ?? DateTime(2000);
    final localGames = await (db.select(db.games)..where((t) => t.updatedAt.isBiggerThanValue(pushedAt))).get();
    await remote.upsert('games', [for (final g in localGames) _gameRow(g)], merge: true);
    up += localGames.length;
    await prefs.setString('sync.gamesPushed', DateTime.now().toIso8601String());

    // 2. Intentos de problemas (solo inserción).
    final pending = await (db.select(db.puzzleAttempts)..where((t) => t.syncedAt.isNull())).get();
    await remote.upsert('puzzle_attempts', [
      for (final a in pending)
        {
          'id': a.id,
          'puzzle_id': a.puzzleId,
          'solved': a.solved,
          'hints_used': a.hintsUsed,
          'time_ms': a.timeMs,
          'puzzle_rating': a.puzzleRating,
          'attempted_at': a.attemptedAt.toUtc().toIso8601String(),
        },
    ], merge: false);
    up += pending.length;
    final now = DateTime.now();
    await (db.update(db.puzzleAttempts)..where((t) => t.syncedAt.isNull())).write(PuzzleAttemptsCompanion(syncedAt: Value(now)));
    final remoteAttempts = await remote.since('puzzle_attempts', _mark('attempts'));
    final knownAttempts = await _existing(db.puzzleAttempts, db.puzzleAttempts.id, remoteAttempts);
    var newAttempts = 0;
    await db.batch((b) {
      for (final r in remoteAttempts.where((r) => !knownAttempts.contains(r['id']))) {
        newAttempts++;
        b.insert(
          db.puzzleAttempts,
          PuzzleAttemptsCompanion.insert(
            id: r['id']! as String,
            puzzleId: r['puzzle_id']! as String,
            solved: r['solved']! as bool,
            hintsUsed: Value(r['hints_used']! as int),
            timeMs: r['time_ms']! as int,
            puzzleRating: r['puzzle_rating']! as int,
            ratingAfter: 0,
            rdAfter: 0,
            volAfter: 0,
            attemptedAt: DateTime.parse(r['attempted_at']! as String).toLocal(),
            syncedAt: Value(now),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
    await _setMark('attempts', remoteAttempts);
    if (newAttempts > 0) await puzzles.recomputeRatings();
    down += newAttempts;

    // 3. Sesiones de Visión (solo inserción).
    final pendingVision = await (db.select(db.visionSessions)..where((t) => t.syncedAt.isNull())).get();
    await remote.upsert('vision_sessions', [
      for (final v in pendingVision)
        {
          'id': v.id,
          'mode': v.mode,
          'side': v.side,
          'coords': v.coords,
          'score': v.score,
          'errors': v.errors,
          'duration_ms': v.durationMs,
          'misses': jsonDecode(v.misses),
          'started_at': v.startedAt.toUtc().toIso8601String(),
        },
    ], merge: false);
    up += pendingVision.length;
    await (db.update(db.visionSessions)..where((t) => t.syncedAt.isNull())).write(VisionSessionsCompanion(syncedAt: Value(now)));
    final remoteVision = await remote.since('vision_sessions', _mark('vision'));
    final knownVision = await _existing(db.visionSessions, db.visionSessions.id, remoteVision);
    final newVision = remoteVision.where((r) => !knownVision.contains(r['id'])).toList();
    await db.batch((b) {
      for (final r in newVision) {
        b.insert(
          db.visionSessions,
          VisionSessionsCompanion.insert(
            id: r['id']! as String,
            mode: r['mode']! as String,
            side: r['side']! as String,
            coords: r['coords']! as bool,
            score: r['score']! as int,
            errors: r['errors']! as int,
            durationMs: r['duration_ms']! as int,
            misses: jsonEncode(r['misses']),
            startedAt: DateTime.parse(r['started_at']! as String).toLocal(),
            syncedAt: Value(now),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
    await _setMark('vision', remoteVision);
    down += newVision.length;
    return (up, down);
  }

  Future<Set<String>> _existing(TableInfo<Table, Object?> table, GeneratedColumn<String> id, List<RemoteRow> rows) async {
    if (rows.isEmpty) return {};
    final q = db.selectOnly(table)
      ..addColumns([id])
      ..where(id.isIn([for (final r in rows) r['id']! as String]));
    return (await q.map((r) => r.read(id)!).get()).toSet();
  }

  RemoteRow _gameRow(Game g) => {
    'source': g.source,
    'external_id': g.externalId,
    'pgn': g.pgn,
    'user_side': g.userSide,
    'deleted': g.deleted,
    'updated_at': g.updatedAt.toUtc().toIso8601String(),
  };

  /// Aplica una partida remota si es nueva o más reciente. Devuelve si cambió algo.
  Future<bool> _applyGame(RemoteRow r) async {
    final source = r['source']! as String, ext = r['external_id']! as String;
    final updated = DateTime.parse(r['updated_at']! as String).toLocal();
    final deleted = r['deleted']! as bool;
    final local = await (db.select(db.games)..where((t) => t.source.equals(source) & t.externalId.equals(ext))).getSingleOrNull();
    if (local == null) {
      if (deleted) return false;
      final ParsedGame g;
      try {
        g = PgnImporter.parse(r['pgn']! as String).first;
      } on PgnImportException {
        return false;
      }
      await db.into(db.games).insert(GamesCompanion.insert(
        source: source,
        externalId: Value(ext),
        pgn: g.pgn,
        white: g.white,
        black: g.black,
        result: g.result,
        date: Value(g.headers['Date']),
        timeControl: Value(g.headers['TimeControl']),
        userSide: Value(r['user_side'] as String?),
        plies: g.plies.length,
        createdAt: updated,
        updatedAt: updated,
      ));
      return true;
    }
    if (!updated.isAfter(local.updatedAt)) return false;
    await db.transaction(() async {
      if (deleted) {
        await (db.delete(db.gameAnalyses)..where((t) => t.gameId.equals(local.id))).go();
        await (db.delete(db.puzzles)..where((t) => t.gameId.equals(local.id))).go();
      }
      await (db.update(db.games)..where((t) => t.id.equals(local.id))).write(GamesCompanion(
        userSide: Value(r['user_side'] as String?),
        deleted: Value(deleted),
        updatedAt: Value(updated),
      ));
    });
    return true;
  }
}
