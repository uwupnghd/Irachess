import 'dart:async';

import 'package:dartchess/dartchess.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/app/app.dart';
import 'package:irachess/core/chess/chess_utils.dart';
import 'package:irachess/core/db/database.dart';
import 'package:irachess/core/engine/engine_channel.dart';
import 'package:irachess/core/providers.dart';
import 'package:irachess/core/settings/settings.dart';
import 'package:irachess/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Motor UCI simulado: evalúa por material y propone la primera captura
/// (o la primera jugada legal). Suficiente para probar todo el flujo.
class FakeEngineChannel implements EngineChannel {
  final _out = StreamController<String>.broadcast();
  String _fen = Chess.initial.fen;
  int searches = 0;

  @override
  Stream<String> get lines => _out.stream;

  @override
  void send(String command) {
    scheduleMicrotask(() {
      if (command == 'isready') _out.add('readyok');
      if (command.startsWith('position fen ')) _fen = command.substring(13);
      if (command.startsWith('go')) {
        searches++;
        final pos = positionFromFen(_fen);
        final moves = [
          for (final e in pos.legalMoves.entries)
            for (final to in e.value.squares) NormalMove(from: e.key, to: to),
        ]..sort((a, b) => (pos.board.occupied.has(b.to) ? 1 : 0) - (pos.board.occupied.has(a.to) ? 1 : 0));
        for (var i = 0; i < moves.length && i < 3; i++) {
          final next = pos.play(moves[i]);
          final cp = (materialBalance(next.board, pos.turn) * 100) - i * 10;
          _out.add('info depth 10 multipv ${i + 1} score cp $cp pv ${standardUci(pos, moves[i])}');
        }
        _out.add('bestmove ${moves.isEmpty ? '(none)' : standardUci(pos, moves.first)}');
      }
    });
  }

  @override
  Future<void> close() => _out.close();
}

Future<SharedPreferences> testPrefs([Map<String, Object> values = const {'onboarded': true}]) async {
  SharedPreferences.setMockInitialValues(values);
  return SharedPreferences.getInstance();
}

/// Envuelve un widget con localización española y Riverpod.
Future<void> pumpLocalized(WidgetTester tester, Widget child, {List<Object> overrides = const [], Size size = const Size(400, 800)}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final prefs = await testPrefs();
  await tester.pumpWidget(ProviderScope(
    overrides: [
      sharedPrefsProvider.overrideWithValue(prefs),
      databaseProvider.overrideWith((ref) {
        final db = AppDatabase(NativeDatabase.memory());
        ref.onDispose(db.close);
        return db;
      }),
      ...overrides.cast(),
    ],
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: appLocalizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  ));
}

/// Desmonta el árbol para que Drift cierre sus consultas reactivas antes de
/// que la prueba compruebe temporizadores pendientes.
Future<void> disposeTree(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(Duration.zero);
}
