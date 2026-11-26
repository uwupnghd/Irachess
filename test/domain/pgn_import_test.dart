import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/features/games/domain/pgn_import.dart';

import '../fixtures/games.dart';

void main() {
  test('variantes, comentarios, NAG y relojes', () {
    final g = PgnImporter.parse(pgnWithEverything).single;
    expect(g.white, 'Ana');
    expect(g.result, '*'); // partida incompleta
    expect(g.plies.map((p) => p.san), ['e4', 'e5', 'Nf3', 'Nc6', 'Bb5', 'a6']);
    expect(g.plies[0].clock, const Duration(minutes: 5));
    expect(g.plies[1].clock, const Duration(minutes: 4, seconds: 58));
    expect(g.plies[2].comment, 'Lo normal');
    expect(g.incrementSeconds, 2);
    expect(g.positions(), hasLength(7));
    expect(g.pgn, contains('( 2. f4'));
  });

  test('varias partidas', () {
    final games = PgnImporter.parse(twoGames);
    expect(games, hasLength(2));
    expect(games[1].plies.map((p) => p.uci), ['e2e4', 'c7c5']);
  });

  test('enroque en UCI estándar', () {
    final g = PgnImporter.parse('1. e4 e5 2. Nf3 Nc6 3. Bc4 Bc5 4. O-O *').single;
    expect(g.plies.last.uci, 'e1g1');
  });

  test('errores claros', () {
    expect(() => PgnImporter.parse('   '), throwsA(isA<PgnImportException>().having((e) => e.code, 'code', 'empty')));
    expect(
      () => PgnImporter.parse('1. e4 e5 2. Ke3 *'),
      throwsA(isA<PgnImportException>().having((e) => e.code, 'code', 'illegalMove').having((e) => e.ply, 'ply', 2)),
    );
    expect(() => PgnImporter.parse('[White "x"]\n\n*'), throwsA(isA<PgnImportException>()));
    expect(() => PgnImporter.parse('1. e4 ' * 400000), throwsA(isA<PgnImportException>()));
    expect(
      () => PgnImporter.parse('[FEN "esto no es un fen"]\n\n1. e4 *'),
      throwsA(isA<PgnImportException>().having((e) => e.code, 'code', 'badFen')),
    );
  });

  test('saneado de caracteres de control y cabeceras largas', () {
    final g = PgnImporter.parse('﻿[White "Ana\u0007"]\r\n[Black "${'x' * 500}"]\r\n\r\n1. e4 *').single;
    expect(g.white, 'Ana');
    expect(g.black.length, 200);
  });
}
