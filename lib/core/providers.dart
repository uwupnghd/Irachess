import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/analysis/data/analysis_service.dart';
import '../features/games/data/games_repository.dart';
import '../features/openings/opening_book.dart';
import '../features/puzzles/data/pack_service.dart';
import '../features/puzzles/data/puzzle_repository.dart';
import 'db/database.dart';
import 'engine/uci_engine.dart';
import 'network/http.dart';
import 'settings/settings.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// El libro se construye fuera del hilo de la UI.
final openingBookProvider = FutureProvider<OpeningBook>((ref) async {
  final tsv = await rootBundle.loadString('assets/openings.tsv');
  return compute(OpeningBook.parse, tsv);
});

/// Un único motor para toda la app (las peticiones se serializan).
final engineProvider = FutureProvider<UciEngine>((ref) async {
  final engine = await UciEngine.start();
  ref.onDispose(engine.dispose);
  return engine;
});

final gamesRepositoryProvider = Provider((ref) => GamesRepository(ref.watch(databaseProvider)));

final analysisServiceProvider = Provider(
  (ref) => AnalysisService(
    ref.watch(databaseProvider),
    () => ref.read(engineProvider.future),
    () => ref.read(openingBookProvider.future),
    // Tras cada análisis se generan los problemas de mis errores.
    onSaved: (gameId, report, side) => ref.read(puzzleRepositoryProvider).generateFromReport(gameId, report, side),
  ),
);

final gamesListProvider = StreamProvider((ref) => ref.watch(gamesRepositoryProvider).watchGames());

final dioProvider = Provider((ref) => buildDio());

final puzzleRepositoryProvider = Provider(
  (ref) => PuzzleRepository(ref.watch(databaseProvider), ref.watch(settingsProvider.select((s) => s.level))),
);

final packServiceProvider = Provider((ref) => PackService(ref.watch(dioProvider), ref.watch(puzzleRepositoryProvider)));
