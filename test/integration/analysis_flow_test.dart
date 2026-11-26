import 'dart:io' as io;

import 'package:dartchess/dartchess.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/core/db/database.dart';
import 'package:irachess/core/engine/uci_engine.dart';
import 'package:irachess/core/settings/settings.dart';
import 'package:irachess/features/analysis/data/analysis_service.dart';
import 'package:irachess/features/analysis/domain/annotated_pgn.dart';
import 'package:irachess/features/analysis/domain/game_report.dart';
import 'package:irachess/features/games/data/games_repository.dart';
import 'package:irachess/features/games/domain/pgn_import.dart';
import 'package:irachess/features/openings/opening_book.dart';
import 'package:irachess/features/puzzles/data/puzzle_repository.dart';

import '../helpers.dart';

const amateurGame = '''
[White "Yo"]
[Black "Rival"]
[Result "0-1"]

1. e4 e5 2. Nf3 Nc6 3. Bc4 Nd4 4. Nxe5 Qg5 5. Nxf7 Qxg2 6. Rf1 Qxe4+ 7. Be2 Nf3# 0-1
''';

void main() {
  test('PGN → análisis → informe guardado → caché → problemas propios → PGN anotado', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final channel = FakeEngineChannel();
    final engine = UciEngine(channel);
    final book = OpeningBook.parse(io.File('assets/openings.tsv').readAsStringSync());
    final puzzles = PuzzleRepository(db, PlayerLevel.novice);
    final service = AnalysisService(db, () async => engine, () async => book, onSaved: puzzles.generateFromReport);
    final games = GamesRepository(db);

    final parsed = PgnImporter.parse(amateurGame).single;
    final (id, isNew) = await games.insert(parsed, source: 'pgn', userSide: Side.white);
    expect(isNew, isTrue);
    // Reimportar la misma partida no la duplica.
    expect((await games.insert(parsed, source: 'pgn')).$2, isFalse);

    final row = (await games.getGame(id))!;
    final progress = await service.analyse(row, parsed, EnginePreset.fast, AnalysisCancel()).toList();
    expect(progress.first.done, 0);
    expect(progress.last.report, isNotNull);
    final report = progress.last.report!;
    expect(report.moves, hasLength(parsed.plies.length));
    expect(report.opening.opening!.name, contains('Italian Game'));
    expect(channel.searches, greaterThan(0));

    // Guardado en la base de datos y recuperable.
    final loaded = (await service.loadReport(id))!;
    expect(loaded.moves.length, report.moves.length);
    expect((await games.getGame(id))!.openingName, report.opening.opening!.name);

    // Segunda vez: todas las posiciones salen de la caché, sin usar el motor.
    final before = channel.searches;
    await service.analyse(row, parsed, EnginePreset.fast, AnalysisCancel()).toList();
    expect(channel.searches, before);

    // Cancelar detiene el análisis sin informe.
    final cancel = AnalysisCancel()..cancelled = true;
    expect((await service.analyse(row, parsed, EnginePreset.normal, cancel).toList()).where((p) => p.report != null), isEmpty);

    // PGN anotado: se puede volver a importar y conserva NAG y evaluaciones.
    final pgn = annotatedPgn(parsed, report, (m) => m.cls.name);
    expect(pgn, contains('[%eval'));
    expect(PgnImporter.parse(pgn).single.plies, hasLength(parsed.plies.length));

    expect(await puzzles.countOwn(), greaterThanOrEqualTo(0));
    await engine.dispose();
    await db.close();
  });

  test('problemas propios a partir de errores reales', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final engine = UciEngine(FakeEngineChannel());
    final book = OpeningBook.parse(io.File('assets/openings.tsv').readAsStringSync());
    final puzzles = PuzzleRepository(db, PlayerLevel.novice);
    final service = AnalysisService(db, () async => engine, () async => book, onSaved: puzzles.generateFromReport);
    // El blanco deja la dama en prise: el motor simulado (material) lo castiga.
    final parsed = PgnImporter.parse('1. e4 e5 2. Qh5 Nc6 3. Qxe5+ Nxe5 *').single;
    final (id, _) = await GamesRepository(db).insert(parsed, source: 'pgn', userSide: Side.white);
    final report = (await service.analyse((await GamesRepository(db).getGame(id))!, parsed, EnginePreset.fast, AnalysisCancel()).last).report!;
    expect(report.moves[4].cls.isError, isTrue);
    expect(await puzzles.countOwn(), greaterThan(0));
    final own = (await puzzles.next(theme: 'own', rating: 1000))!;
    expect(own.source, 'own');
    expect(own.fen, report.moves[4].fenBefore);
    await engine.dispose();
    await db.close();
  });
}
