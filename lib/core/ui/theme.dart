import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/analysis/domain/game_report.dart';

/// Identidad propia de IraChess: índigo profundo + acento ámbar.
const brandIndigo = Color(0xFF3B3B98);
const brandAmber = Color(0xFFF2A541);

ThemeData buildTheme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: brandIndigo,
    brightness: brightness,
    secondary: brandAmber,
  );
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    visualDensity: VisualDensity.standard,
    cardTheme: const CardThemeData(margin: EdgeInsets.zero),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(minimumSize: const Size(48, 48)),
    ),
  );
}

ChessboardColorScheme _board(Color light, Color dark) => ChessboardColorScheme(
  lightSquare: light,
  darkSquare: dark,
  background: SolidColorChessboardBackground(lightSquare: light, darkSquare: dark),
  whiteCoordBackground: SolidColorChessboardBackground(lightSquare: light, darkSquare: dark, coordinates: true),
  blackCoordBackground: SolidColorChessboardBackground(
    lightSquare: light,
    darkSquare: dark,
    coordinates: true,
    orientation: Side.black,
  ),
  lastMove: const HighlightDetails(solidColor: Color(0x66F2A541)),
  selected: const HighlightDetails(solidColor: Color(0x553B3B98)),
  validMoves: const Color(0x553B3B98),
  validPremoves: const Color(0x40203085),
);

/// Tableros propios (colores originales).
final boardThemes = <String, ChessboardColorScheme>{
  'slate': _board(const Color(0xFFDEE3EA), const Color(0xFF7D8FA6)),
  'sand': _board(const Color(0xFFF1E6D0), const Color(0xFFC19A6B)),
  'sage': _board(const Color(0xFFE6EBDD), const Color(0xFF8EA383)),
  'plum': _board(const Color(0xFFEDE4F0), const Color(0xFF9479A8)),
};

/// Color y símbolo de cada clasificación. El símbolo y el nombre
/// acompañan siempre al color (accesibilidad).
class ClassStyle {
  const ClassStyle(this.color, this.symbol);
  final Color color;
  final String symbol;
}

ClassStyle classStyle(MoveClass c, {bool colorBlind = false}) {
  // Paleta daltónica: tonos de Okabe-Ito, distinguibles con deuteranopia/protanopia.
  final cb = colorBlind;
  return switch (c) {
    MoveClass.brilliant => ClassStyle(cb ? const Color(0xFF56B4E9) : const Color(0xFF12B5CB), '!!'),
    MoveClass.great => ClassStyle(cb ? const Color(0xFF0072B2) : const Color(0xFF4F7CF7), '!'),
    MoveClass.book => const ClassStyle(Color(0xFF9C7B5B), '≡'),
    MoveClass.best => ClassStyle(cb ? const Color(0xFF009E73) : const Color(0xFF2E9E5B), '★'),
    MoveClass.excellent => ClassStyle(cb ? const Color(0xFF009E73) : const Color(0xFF5DB075), '✓✓'),
    MoveClass.good => ClassStyle(cb ? const Color(0xFF6FA88F) : const Color(0xFF8FB996), '✓'),
    MoveClass.inaccuracy => ClassStyle(cb ? const Color(0xFFF0E442) : const Color(0xFFE8B10C), '?!'),
    MoveClass.miss => ClassStyle(cb ? const Color(0xFFCC79A7) : const Color(0xFFD9668B), '✗'),
    MoveClass.mistake => ClassStyle(cb ? const Color(0xFFE69F00) : const Color(0xFFEE8434), '?'),
    MoveClass.blunder => ClassStyle(cb ? const Color(0xFFD55E00) : const Color(0xFFD43F3A), '??'),
    MoveClass.forced => const ClassStyle(Color(0xFF9E9E9E), '□'),
  };
}
