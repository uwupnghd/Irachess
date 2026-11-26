import 'dart:convert';

import 'package:dartchess/dartchess.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../../core/db/database.dart';
import '../../../core/settings/settings.dart';
import '../../../core/util/ids.dart';
import '../../analysis/domain/game_report.dart';
import '../../analysis/domain/win_chances.dart';
import '../domain/glicko2.dart';
import '../domain/puzzle.dart';

const puzzleRd = 80.0;

int initialRatingFor(PlayerLevel level) => switch (level) {
  PlayerLevel.beginner => 600,
  PlayerLevel.novice => 1000,
  PlayerLevel.intermediate => 1400,
  PlayerLevel.advanced => 1800,
};

Puzzle puzzleFromRow(PuzzleRow r) => Puzzle(
  id: r.id,
  fen: r.fen,
  moves: r.moves.split(' '),
  rating: r.rating,
  themes: r.themes.trim().split(' ').where((t) => t.isNotEmpty).toList(),
  source: r.source,
  gameId: r.gameId,
  ply: r.ply,
  note: Puzzle.decodeNote(r.note),
);

PuzzlesCompanion _companion(Puzzle p, {String? packId}) => PuzzlesCompanion.insert(
  id: p.id,
  fen: p.fen,
  moves: p.moves.join(' '),
  rating: p.rating,
  themes: ' ${p.themes.join(' ')} ',
  source: p.source,
  packId: Value(packId),
  gameId: Value(p.gameId),
  ply: Value(p.ply),
  note: Value(p.note == null ? null : jsonEncode(p.note)),
);

class PuzzleRepository {
  PuzzleRepository(this.db, this.level);
  final AppDatabase db;
  final PlayerLevel level;

  /// Importa el lote base incluido en la app (una sola vez).
  Future<void> ensureBaseLoaded() async {
    final count = await (db.selectOnly(db.puzzles)
          ..addColumns([db.puzzles.id.count()])
          ..where(db.puzzles.source.equals('base')))
        .map((r) => r.read(db.puzzles.id.count()))
        .getSingle();
    if ((count ?? 0) > 0) return;
    final csv = await rootBundle.loadString('assets/puzzles/base.csv');
    await insertCsv(csv, source: 'base');
  }

  Future<int> insertCsv(String csv, {required String source, String? packId}) async {
    final puzzles = [
      for (final line in const LineSplitter().convert(csv))
        if (line.trim().isNotEmpty) Puzzle.fromCsvLine(line, source: source),
    ];
    await db.batch((b) {
      b.insertAll(db.puzzles, [for (final p in puzzles) _companion(p, packId: packId)], mode: InsertMode.insertOrIgnore);
    });
    return puzzles.length;
  }

  Future<Rating> currentRating() async {
    final last = await (db.select(db.puzzleAttempts)
          ..orderBy([(t) => OrderingTerm.desc(t.attemptedAt)])
          ..limit(1))
        .getSingleOrNull();
    if (last == null) return Rating(initialRatingFor(level).toDouble(), Rating.initialRd, Rating.initialVol);
    return Rating(last.ratingAfter, last.rdAfter, last.volAfter);
  }

  /// Siguiente problema cerca del rating del usuario, evitando repetir los
  /// últimos intentados. `own` = problemas de mis errores no resueltos.
  Future<Puzzle?> next({required String theme, required double rating}) async {
    final recent = await (db.selectOnly(db.puzzleAttempts)
          ..addColumns([db.puzzleAttempts.puzzleId])
          ..orderBy([OrderingTerm.desc(db.puzzleAttempts.attemptedAt)])
          ..limit(300))
        .map((r) => r.read(db.puzzleAttempts.puzzleId)!)
        .get();
    if (theme == 'own') {
      final solved = await (db.selectOnly(db.puzzleAttempts)
            ..addColumns([db.puzzleAttempts.puzzleId])
            ..where(db.puzzleAttempts.solved.equals(true) & db.puzzleAttempts.puzzleId.like('own-%')))
          .map((r) => r.read(db.puzzleAttempts.puzzleId)!)
          .get();
      final row = await (db.select(db.puzzles)
            ..where((t) => t.source.equals('own') & t.id.isNotIn(solved))
            ..orderBy([(t) => OrderingTerm.desc(t.gameId), (t) => OrderingTerm.asc(t.ply)])
            ..limit(1))
          .getSingleOrNull();
      return row == null ? null : puzzleFromRow(row);
    }
    for (final window in [200, 400, 800, 3000]) {
      final q = db.select(db.puzzles)
        ..where((t) =>
            t.source.isNotValue('own') &
            t.rating.isBetweenValues(rating.round() - window, rating.round() + window) &
            t.id.isNotIn(recent) &
            (theme == 'mix' ? const Constant(true) : t.themes.like('% $theme %')))
        ..orderBy([(t) => OrderingTerm.random()])
        ..limit(1);
      final row = await q.getSingleOrNull();
      if (row != null) return puzzleFromRow(row);
    }
    return null;
  }

  /// Guarda el intento y actualiza el rating (solo cuenta si no es propio).
  Future<(Rating, double)> recordAttempt(Puzzle p, {required bool solved, required int hints, required Duration time}) async {
    final before = await currentRating();
    final after = p.source == 'own' ? before : glickoUpdate(before, p.rating.toDouble(), puzzleRd, solved && hints == 0 ? 1 : 0);
    await db.into(db.puzzleAttempts).insert(PuzzleAttemptsCompanion.insert(
      id: uuidV4(),
      puzzleId: p.id,
      solved: solved,
      hintsUsed: Value(hints),
      timeMs: time.inMilliseconds,
      puzzleRating: p.rating,
      ratingAfter: after.rating,
      rdAfter: after.rd,
      volAfter: after.vol,
      attemptedAt: DateTime.now(),
    ));
    return (after, after.rating - before.rating);
  }

  /// Recalcula la cadena de ratings en orden cronológico (tras sincronizar
  /// intentos de otros dispositivos).
  Future<void> recomputeRatings() async {
    final attempts = await (db.select(db.puzzleAttempts)..orderBy([(t) => OrderingTerm.asc(t.attemptedAt)])).get();
    var r = Rating(initialRatingFor(level).toDouble(), Rating.initialRd, Rating.initialVol);
    await db.batch((b) {
      for (final a in attempts) {
        if (!a.puzzleId.startsWith('own-')) {
          r = glickoUpdate(r, a.puzzleRating.toDouble(), puzzleRd, a.solved && a.hintsUsed == 0 ? 1 : 0);
        }
        b.update(db.puzzleAttempts, PuzzleAttemptsCompanion(ratingAfter: Value(r.rating), rdAfter: Value(r.rd), volAfter: Value(r.vol)),
            where: (t) => t.id.equals(a.id));
      }
    });
  }

  /// Racha de problemas resueltos seguidos (más recientes primero).
  Future<int> currentStreak() async {
    final rows = await (db.select(db.puzzleAttempts)
          ..orderBy([(t) => OrderingTerm.desc(t.attemptedAt)])
          ..limit(500))
        .get();
    var n = 0;
    for (final a in rows) {
      if (!a.solved || a.hintsUsed > 0) break;
      n++;
    }
    return n;
  }

  Future<int> countOwn() async =>
      (await (db.select(db.puzzles)..where((t) => t.source.equals('own'))).get()).length;

  Future<int> countAll() async => await (db.selectOnly(db.puzzles)..addColumns([db.puzzles.id.count()]))
          .map((r) => r.read(db.puzzles.id.count()))
          .getSingle() ??
      0;

  /// Crea problemas con los errores del usuario en una partida analizada.
  Future<int> generateFromReport(int gameId, GameReport report, Side userSide) async {
    final puzzles = <Puzzle>[];
    for (final m in report.moves) {
      if (m.side != userSide || !m.cls.isError || m.best == null) continue;
      final best = m.best!;
      final bestW = winPercent(cp: best.cp, mate: best.mate);
      // Si la mejor jugada tampoco mejora nada, no es un buen problema.
      if (bestW - m.winAfter < 10) continue;
      final accept = [
        for (final a in m.alternatives.skip(1))
          if (bestW - winPercent(cp: a.cp, mate: a.mate) <= Thresholds.excellent) a.uci,
      ];
      puzzles.add(Puzzle(
        id: 'own-$gameId-${m.ply}',
        fen: m.fenBefore,
        moves: [best.uci],
        rating: (800 + m.deltaW * 10).round(),
        themes: ['own', ...m.motifs],
        source: 'own',
        gameId: gameId,
        ply: m.ply,
        note: {
          'played': m.san,
          'best': best.san,
          'accept': accept,
          'expl': [for (final e in m.explanation) e.toJson()],
        },
      ));
    }
    await db.batch((b) {
      b.insertAll(db.puzzles, [for (final p in puzzles) _companion(p)], mode: InsertMode.insertOrIgnore);
    });
    return puzzles.length;
  }

  Stream<List<PuzzlePack>> watchPacks() => db.select(db.puzzlePacks).watch();

  Future<void> deletePack(String id) => db.transaction(() async {
    await (db.delete(db.puzzles)..where((t) => t.packId.equals(id))).go();
    await (db.delete(db.puzzlePacks)..where((t) => t.id.equals(id))).go();
  });

  Future<void> installPack(PackInfo info, String csv) => db.transaction(() async {
    await (db.delete(db.puzzles)..where((t) => t.packId.equals(info.id))).go();
    final count = await insertCsv(csv, source: 'pack', packId: info.id);
    await db.into(db.puzzlePacks).insertOnConflictUpdate(PuzzlePacksCompanion.insert(
      id: info.id,
      theme: info.theme,
      ratingMin: info.min,
      ratingMax: info.max,
      count: count,
      bytes: utf8.encode(csv).length,
      version: info.version,
      downloadedAt: DateTime.now(),
    ));
  });
}

class PackInfo {
  const PackInfo({required this.id, required this.theme, required this.min, required this.max, required this.count, required this.bytes, required this.version, required this.file});
  final String id;
  final String theme;
  final int min;
  final int max;
  final int count;
  final int bytes;
  final int version;
  final String file;

  factory PackInfo.fromJson(Map<String, Object?> j) => PackInfo(
    id: j['id']! as String,
    theme: j['theme']! as String,
    min: j['min']! as int,
    max: j['max']! as int,
    count: j['count']! as int,
    bytes: j['bytes']! as int,
    version: j['version']! as int,
    file: j['file']! as String,
  );
}
