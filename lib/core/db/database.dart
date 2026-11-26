import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

/// Partidas del usuario. `deleted` es una lápida para la sincronización.
@TableIndex(name: 'games_created', columns: {#createdAt})
class Games extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get source => text()(); // pgn | lichess | chesscom | engine
  TextColumn get externalId => text().nullable()();
  TextColumn get pgn => text()();
  TextColumn get white => text()();
  TextColumn get black => text()();
  TextColumn get result => text()();
  TextColumn get date => text().nullable()();
  TextColumn get timeControl => text().nullable()();
  TextColumn get userSide => text().nullable()(); // white | black
  TextColumn get eco => text().nullable()();
  TextColumn get openingName => text().nullable()();
  IntColumn get plies => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {source, externalId},
  ];
}

/// Caché de evaluaciones por posición (se reutiliza entre partidas).
class PositionEvals extends Table {
  TextColumn get epd => text()();
  TextColumn get engine => text()();
  TextColumn get preset => text()();
  TextColumn get lines => text()(); // JSON
  @override
  Set<Column> get primaryKey => {epd, engine, preset};
}

/// Informe completo de una partida analizada + resumen para estadísticas.
class GameAnalyses extends Table {
  IntColumn get gameId => integer().references(Games, #id, onDelete: KeyAction.cascade)();
  TextColumn get engine => text()();
  TextColumn get preset => text()();
  RealColumn get accuracyWhite => real().nullable()();
  RealColumn get accuracyBlack => real().nullable()();
  RealColumn get userAccuracy => real().nullable()();
  IntColumn get userInaccuracies => integer().withDefault(const Constant(0))();
  IntColumn get userMistakes => integer().withDefault(const Constant(0))();
  IntColumn get userBlunders => integer().withDefault(const Constant(0))();
  TextColumn get report => text()(); // JSON de GameReport
  DateTimeColumn get createdAt => dateTime()();
  @override
  Set<Column> get primaryKey => {gameId};
}

@TableIndex(name: 'puzzles_rating', columns: {#rating})
@DataClassName('PuzzleRow')
class Puzzles extends Table {
  TextColumn get id => text()();
  TextColumn get fen => text()();
  TextColumn get moves => text()(); // UCI separadas por espacios
  IntColumn get rating => integer()();
  IntColumn get popularity => integer().withDefault(const Constant(0))();
  TextColumn get themes => text()(); // " fork pin mateIn2 " (con espacios en los bordes)
  TextColumn get source => text()(); // base | pack | own
  TextColumn get packId => text().nullable()();
  IntColumn get gameId => integer().nullable()();
  IntColumn get ply => integer().nullable()();
  TextColumn get note => text().nullable()(); // JSON (problemas propios)
  @override
  Set<Column> get primaryKey => {id};
}

class PuzzlePacks extends Table {
  TextColumn get id => text()();
  TextColumn get theme => text()();
  IntColumn get ratingMin => integer()();
  IntColumn get ratingMax => integer()();
  IntColumn get count => integer()();
  IntColumn get bytes => integer()();
  IntColumn get version => integer()();
  DateTimeColumn get downloadedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

/// Registro de solo inserción (sync idempotente por id).
@TableIndex(name: 'attempts_time', columns: {#attemptedAt})
class PuzzleAttempts extends Table {
  TextColumn get id => text()();
  TextColumn get puzzleId => text()();
  BoolColumn get solved => boolean()();
  IntColumn get hintsUsed => integer().withDefault(const Constant(0))();
  IntColumn get timeMs => integer()();
  IntColumn get puzzleRating => integer()();
  RealColumn get ratingAfter => real()();
  RealColumn get rdAfter => real()();
  RealColumn get volAfter => real()();
  DateTimeColumn get attemptedAt => dateTime()();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class VisionSessions extends Table {
  TextColumn get id => text()();
  TextColumn get mode => text()(); // time30 | time60 | hits20
  TextColumn get side => text()();
  BoolColumn get coords => boolean()();
  IntColumn get score => integer()();
  IntColumn get errors => integer()();
  IntColumn get durationMs => integer()();
  TextColumn get misses => text()(); // JSON [[objetivo, tocada], ...]
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Games, PositionEvals, GameAnalyses, Puzzles, PuzzlePacks, PuzzleAttempts, VisionSessions])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  static QueryExecutor _open() => driftDatabase(
    name: 'irachess',
    // Datos de la app (no la carpeta Documentos del usuario).
    native: const DriftNativeOptions(databaseDirectory: getApplicationSupportDirectory),
    web: DriftWebOptions(sqlite3Wasm: Uri.parse('sqlite3.wasm'), driftWorker: Uri.parse('drift_worker.js')),
  );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async => customStatement('PRAGMA foreign_keys = ON'),
  );

  /// Borra todos los datos del usuario (Ajustes → Borrar todo).
  Future<void> wipe() => transaction(() async {
    for (final table in allTables) {
      await delete(table).go();
    }
  });
}
