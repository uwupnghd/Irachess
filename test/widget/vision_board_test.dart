import 'package:dartchess/dartchess.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:irachess/features/vision/vision_screen.dart';

import '../helpers.dart';

void main() {
  testWidgets('tablero de Visión: tocar una casilla devuelve su nombre (blancas y negras)', (tester) async {
    final taps = <Square>[];
    await pumpLocalized(tester, CoordinateBoard(size: 320, orientation: Side.white, showCoordinates: true, onTap: taps.add));
    // Esquina inferior izquierda = a1 con blancas.
    await tester.tapAt(const Offset(10, 310));
    expect(taps.single, Square.a1);
    expect(find.bySemanticsLabel('e4'), findsOneWidget);

    taps.clear();
    await pumpLocalized(tester, CoordinateBoard(size: 320, orientation: Side.black, showCoordinates: false, onTap: taps.add));
    await tester.tapAt(const Offset(10, 310));
    expect(taps.single, Square.h8);
    await disposeTree(tester);
  });

  testWidgets('sesión de Visión: aciertos y fallos actualizan el marcador', (tester) async {
    await pumpLocalized(tester, const VisionScreen());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Empezar'));
    await tester.pump();
    // El objetivo aparece como texto grande; tocamos esa casilla.
    final target = tester.widgetList<Text>(find.byType(Text)).map((t) => t.data).whereType<String>().firstWhere((s) => RegExp(r'^[a-h][1-8]$').hasMatch(s));
    // Toca el centro de la casilla objetivo (tablero orientado a blancas).
    final box = tester.getRect(find.byType(CoordinateBoard));
    final sq = Square.parse(target)!;
    final cell = box.width / 8;
    await tester.tapAt(box.topLeft + Offset((sq.file + 0.5) * cell, (7 - sq.rank + 0.5) * cell));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Aciertos: 1'), findsOneWidget);
    await tester.pump(const Duration(seconds: 31));
    await tester.pumpAndSettle();
    expect(find.text('Otra vez', skipOffstage: false), findsOneWidget);
    await disposeTree(tester);
  });
}
