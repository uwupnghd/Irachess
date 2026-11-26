import 'package:dartchess/dartchess.dart';
import 'package:drift/drift.dart';

import '../../../core/db/database.dart';
import '../../../core/util/ids.dart';
import '../domain/pgn_import.dart';

class GameListItem {
  const GameListItem(this.game, this.analysis);
  final Game game;
  final GameAnalyse? analysis;
}

class GamesRepository {
  GamesRepository(this.db);
  final AppDatabase db;

  Stream<List<GameListItem>> watchGames() {
    final q = db.select(db.games).join([
      leftOuterJoin(db.gameAnalyses, db.gameAnalyses.gameId.equalsExp(db.games.id)),
    ])
      ..where(db.games.deleted.equals(false))
      ..orderBy([OrderingTerm.desc(db.games.createdAt)]);
    return q.watch().map((rows) => [
      for (final r in rows) GameListItem(r.readTable(db.games), r.readTableOrNull(db.gameAnalyses)),
    ]);
  }

  Future<Game?> getGame(int id) => (db.select(db.games)..where((g) => g.id.equals(id))).getSingleOrNull();

  /// Identificador estable para no duplicar partidas al reimportar.
  static String fingerprint(ParsedGame g) =>
      stableHash('${g.white}|${g.black}|${g.header('Date')}|${g.startFen}|${g.plies.map((p) => p.uci).join(' ')}');

  /// Inserta la partida si no existe; devuelve (id, esNueva).
  Future<(int, bool)> insert(ParsedGame g, {required String source, String? externalId, Side? userSide}) async {
    final ext = externalId ?? fingerprint(g);
    final existing = await (db.select(db.games)
          ..where((t) => t.source.equals(source) & t.externalId.equals(ext)))
        .getSingleOrNull();
    if (existing != null) {
      if (existing.deleted) {
        await (db.update(db.games)..where((t) => t.id.equals(existing.id)))
            .write(GamesCompanion(deleted: const Value(false), updatedAt: Value(DateTime.now())));
        return (existing.id, true);
      }
      return (existing.id, false);
    }
    final now = DateTime.now();
    final id = await db.into(db.games).insert(GamesCompanion.insert(
      source: source,
      externalId: Value(ext),
      pgn: g.pgn,
      white: g.white,
      black: g.black,
      result: g.result,
      date: Value(g.headers['Date'] ?? g.headers['UTCDate']),
      timeControl: Value(g.headers['TimeControl']),
      userSide: Value(userSide?.name),
      plies: g.plies.length,
      createdAt: now,
      updatedAt: now,
    ));
    return (id, true);
  }

  Future<void> setUserSide(int id, Side? side) => (db.update(db.games)..where((t) => t.id.equals(id)))
      .write(GamesCompanion(userSide: Value(side?.name), updatedAt: Value(DateTime.now())));

  Future<void> setOpening(int id, String? eco, String? name) => (db.update(db.games)..where((t) => t.id.equals(id)))
      .write(GamesCompanion(eco: Value(eco), openingName: Value(name)));

  /// Borrado lógico (lápida) para que la sincronización lo propague.
  Future<void> delete(int id) => db.transaction(() async {
    await (db.delete(db.gameAnalyses)..where((t) => t.gameId.equals(id))).go();
    await (db.delete(db.puzzles)..where((t) => t.gameId.equals(id))).go();
    await (db.update(db.games)..where((t) => t.id.equals(id)))
        .write(GamesCompanion(deleted: const Value(true), updatedAt: Value(DateTime.now())));
  });
}
