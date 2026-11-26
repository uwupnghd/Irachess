import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/core/db/database.dart';
import 'package:irachess/core/settings/settings.dart';
import 'package:irachess/features/games/data/games_repository.dart';
import 'package:irachess/features/games/domain/pgn_import.dart';
import 'package:irachess/features/puzzles/data/puzzle_repository.dart';
import 'package:irachess/features/puzzles/domain/puzzle.dart';
import 'package:irachess/features/sync/remote_store.dart';
import 'package:irachess/features/sync/sync_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Servidor falso con la misma semántica que PostgREST + el esquema SQL.
class FakeRemote implements RemoteStore {
  final tables = <String, Map<String, RemoteRow>>{};
  var _clock = DateTime.utc(2026);

  @override
  Future<void> upsert(String table, List<RemoteRow> rows, {required bool merge}) async {
    final t = tables.putIfAbsent(table, () => {});
    for (final r in rows) {
      final key = table == 'games' ? '${r['source']}|${r['external_id']}' : r['id']! as String;
      if (t.containsKey(key) && !merge) continue;
      _clock = _clock.add(const Duration(seconds: 1));
      t[key] = {...r, 'server_at': _clock.toIso8601String()};
    }
  }

  @override
  Future<List<RemoteRow>> since(String table, DateTime? serverAt) async => [
    for (final r in (tables[table] ?? {}).values)
      if (serverAt == null || DateTime.parse(r['server_at']! as String).isAfter(serverAt)) r,
  ];
}

class Device {
  Device(this.prefs) : db = AppDatabase(NativeDatabase.memory());
  final AppDatabase db;
  final SharedPreferences prefs;
  late final puzzles = PuzzleRepository(db, PlayerLevel.novice);
  late final games = GamesRepository(db);
  SyncService sync(RemoteStore r) => SyncService(db, r, prefs, puzzles);
}

const puzzle = Puzzle(id: 'p1', fen: '8/8/8/8/8/8/8/K6k w - - 0 1', moves: ['a1a2', 'h1h2'], rating: 1200, themes: [], source: 'base');

void main() {
  test('dos dispositivos: sin pérdidas, sin duplicados, gana la última escritura', () async {
    SharedPreferences.setMockInitialValues({});
    final prefsA = await SharedPreferences.getInstance();
    final remote = FakeRemote();
    final a = Device(prefsA);
    // Preferencias separadas para B (el mock es global: usamos claves distintas por instancia).
    final b = Device(_PrefixPrefs(prefsA));

    final game = PgnImporter.parse('[White "Ana"]\n[Black "Beto"]\n\n1. e4 e5 2. Nf3 *').single;
    await a.games.insert(game, source: 'pgn');
    await a.puzzles.recordAttempt(puzzle, solved: true, hints: 0, time: const Duration(seconds: 5));
    await a.puzzles.recordAttempt(puzzle, solved: false, hints: 0, time: const Duration(seconds: 9));
    expect(await a.sync(remote).sync(), (3, 0));

    expect((await b.sync(remote).sync()).$2, 3);
    expect(await b.db.select(b.db.games).get(), hasLength(1));
    expect(await b.db.select(b.db.puzzleAttempts).get(), hasLength(2));
    // El rating se recalculó igual en B que en A.
    expect((await b.puzzles.currentRating()).rating, closeTo((await a.puzzles.currentRating()).rating, 0.001));

    // Sincronizar otra vez no duplica nada.
    await a.sync(remote).sync();
    await b.sync(remote).sync();
    expect(remote.tables['puzzle_attempts'], hasLength(2));
    expect(await a.db.select(a.db.puzzleAttempts).get(), hasLength(2));

    // Conflicto: B cambia el color después que A → gana B.
    final gameA = (await a.db.select(a.db.games).get()).single;
    final gameB = (await b.db.select(b.db.games).get()).single;
    await (a.db.update(a.db.games)..where((t) => t.id.equals(gameA.id)))
        .write(GamesCompanion(userSide: const Value('white'), updatedAt: Value(DateTime.now().add(const Duration(seconds: 1)))));
    await (b.db.update(b.db.games)..where((t) => t.id.equals(gameB.id)))
        .write(GamesCompanion(userSide: const Value('black'), updatedAt: Value(DateTime.now().add(const Duration(seconds: 2)))));
    await a.sync(remote).sync();
    await b.sync(remote).sync();
    await a.sync(remote).sync();
    expect((await a.db.select(a.db.games).get()).single.userSide, 'black');

    // Borrado en A (posterior) se propaga a B como lápida.
    await (a.db.update(a.db.games)..where((t) => t.id.equals(gameA.id)))
        .write(GamesCompanion(deleted: const Value(true), updatedAt: Value(DateTime.now().add(const Duration(seconds: 3)))));
    await a.sync(remote).sync();
    await b.sync(remote).sync();
    expect((await b.db.select(b.db.games).get()).single.deleted, isTrue);

    await a.db.close();
    await b.db.close();
  });
}

/// SharedPreferences con claves prefijadas para simular un segundo dispositivo.
class _PrefixPrefs implements SharedPreferences {
  _PrefixPrefs(this._inner);
  final SharedPreferences _inner;
  @override
  String? getString(String key) => _inner.getString('B.$key');
  @override
  Future<bool> setString(String key, String value) => _inner.setString('B.$key', value);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
