import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/app/app.dart';
import 'package:irachess/core/db/database.dart';
import 'package:irachess/core/providers.dart';
import 'package:irachess/core/settings/settings.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers.dart';

Future<void> pumpApp(WidgetTester tester, Size size, {bool onboarded = true}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final prefs = await testPrefs({'onboarded': onboarded, 'locale': 'es'});
  await tester.pumpWidget(ProviderScope(
    overrides: [
      sharedPrefsProvider.overrideWithValue(prefs),
      databaseProvider.overrideWith((ref) {
        final db = AppDatabase(NativeDatabase.memory());
        ref.onDispose(db.close);
        return db;
      }),
    ],
    child: const IraChessApp(),
  ));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('móvil: barra de navegación inferior', (tester) async {
    await pumpApp(tester, const Size(400, 800));
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Aún no hay partidas'), findsOneWidget);
    await tester.tap(find.text('Visión'));
    await tester.pumpAndSettle();
    expect(find.text('Empezar'), findsOneWidget);
    await disposeTree(tester);
  });

  testWidgets('escritorio: barra lateral', (tester) async {
    await pumpApp(tester, const Size(1280, 800));
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    await disposeTree(tester);
  });

  testWidgets('primera ejecución: bienvenida y elección de nivel', (tester) async {
    await pumpApp(tester, const Size(400, 900), onboarded: false);
    expect(find.text('Bienvenido a IraChess'), findsOneWidget);
    await tester.tap(find.text('Intermedio (1200–1600)'));
    await tester.scrollUntilVisible(find.text('Empezar'), 200);
    await tester.tap(find.text('Empezar'));
    await tester.pumpAndSettle();
    expect(find.text('Mis partidas'), findsOneWidget);
    await disposeTree(tester);
  });
}
