import 'dart:convert';

import 'package:dartchess/dartchess.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../core/chess/chess_utils.dart';
import '../../../core/db/database.dart';
import '../../../core/engine/uci_engine.dart';
import '../../games/domain/pgn_import.dart';
import '../../openings/opening_book.dart';
import '../domain/game_report.dart';

const engineId = 'sf19';

class AnalysisProgress {
  const AnalysisProgress(this.done, this.total, {this.report});
  final int done;
  final int total;
  final GameReport? report;
  double get fraction => total == 0 ? 1 : done / total;
}

/// Se marca para detener el análisis en curso.
class AnalysisCancel {
  bool cancelled = false;
}

class AnalysisService {
  AnalysisService(this.db, this._engine, this._book, {this.onSaved});

  final AppDatabase db;
  final Future<void> Function(int gameId, GameReport report, Side userSide)? onSaved;
  final Future<UciEngine> Function() _engine;
  final Future<OpeningBook> Function() _book;

  Future<GameReport?> loadReport(int gameId) async {
    final row = await (db.select(db.gameAnalyses)..where((t) => t.gameId.equals(gameId))).getSingleOrNull();
    if (row == null) return null;
    return GameReport.fromJson(jsonDecode(row.report) as Map<String, Object?>);
  }

  Future<List<EngineLine>?> _cached(String epd, EnginePreset preset) async {
    final row = await (db.select(db.positionEvals)
          ..where((t) => t.epd.equals(epd) & t.engine.equals(engineId) & t.preset.equals(preset.name)))
        .getSingleOrNull();
    if (row == null) return null;
    return [for (final l in jsonDecode(row.lines) as List<Object?>) EngineLine.fromJson(l! as Map<String, Object?>)];
  }

  /// Analiza todas las posiciones (reutilizando la caché) y guarda el informe.
  Stream<AnalysisProgress> analyse(Game row, ParsedGame game, EnginePreset preset, AnalysisCancel cancel) async* {
    final positions = game.positions();
    final total = positions.length;
    final evals = <List<EngineLine>>[];
    yield AnalysisProgress(0, total);
    UciEngine? engine;
    for (final pos in positions) {
      if (cancel.cancelled) return;
      if (pos.isGameOver) {
        evals.add(const []);
      } else {
        final epd = epdOf(pos);
        var lines = await _cached(epd, preset);
        if (lines == null) {
          engine ??= await _engine();
          lines = await engine.analyse(pos.fen, preset: preset);
          if (cancel.cancelled) return;
          await db.into(db.positionEvals).insertOnConflictUpdate(PositionEvalsCompanion.insert(
            epd: epd,
            engine: engineId,
            preset: preset.name,
            lines: jsonEncode([for (final l in lines) l.toJson()]),
          ));
        }
        evals.add(lines);
      }
      yield AnalysisProgress(evals.length, total);
    }
    final book = await _book();
    final opening = book.identify(positions);
    final userSide = row.userSide == null ? null : Side.values.byName(row.userSide!);
    // El post-proceso (tácticas, explicaciones, precisión) corre en otro Isolate.
    final report = await compute(
      buildReport,
      ReportInput(game: game, evals: evals, opening: opening, userSide: userSide),
    );
    await _save(row, report, preset, userSide);
    if (userSide != null) await onSaved?.call(row.id, report, userSide);
    yield AnalysisProgress(total, total, report: report);
  }

  Future<void> _save(Game row, GameReport report, EnginePreset preset, Side? userSide) async {
    final counts = userSide == null ? null : report.counts(userSide);
    await db.transaction(() async {
      await db.into(db.gameAnalyses).insertOnConflictUpdate(GameAnalysesCompanion.insert(
        gameId: Value(row.id),
        engine: engineId,
        preset: preset.name,
        accuracyWhite: Value(report.accuracyWhite),
        accuracyBlack: Value(report.accuracyBlack),
        userAccuracy: Value(userSide == null ? null : report.accuracy(userSide)),
        userInaccuracies: Value(counts?[MoveClass.inaccuracy] ?? 0),
        userMistakes: Value((counts?[MoveClass.mistake] ?? 0) + (counts?[MoveClass.miss] ?? 0)),
        userBlunders: Value(counts?[MoveClass.blunder] ?? 0),
        report: jsonEncode(report.toJson()),
        createdAt: DateTime.now(),
      ));
      await (db.update(db.games)..where((t) => t.id.equals(row.id))).write(GamesCompanion(
        eco: Value(report.opening.opening?.eco),
        openingName: Value(report.opening.opening?.name),
      ));
    });
  }
}
