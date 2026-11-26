import 'dart:io' as io;

import 'package:dartchess/dartchess.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/core/chess/chess_utils.dart';
import 'package:irachess/features/openings/opening_book.dart';

List<Position> line(List<String> ucis) {
  final out = <Position>[Chess.initial];
  for (final u in ucis) {
    out.add(out.last.play(parseUciMove(out.last, u)!));
  }
  return out;
}

void main() {
  final book = OpeningBook.parse(io.File('assets/openings.tsv').readAsStringSync());

  test('el libro se carga completo', () {
    expect(book.size, greaterThan(3000));
  });

  test('identifica la Najdorf', () {
    final r = book.identify(line('e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6'.split(' ')));
    expect(r.opening!.eco, 'B90');
    expect(r.opening!.name, 'Sicilian Defense: Najdorf Variation');
    expect(r.opening!.family, 'Sicilian Defense');
    expect(r.exitPly, isNull);
  });

  test('detecta la salida de teoría y las jugadas de libro', () {
    // 1.e4 e5 2.Nf3 Nc6 3.Bb5 (Ruy López) y luego 3...Ra7?? fuera de libro
    final r = book.identify(line('e2e4 e7e5 g1f3 b8c6 f1b5 a8b8 b5c6'.split(' ')));
    expect(r.opening!.name, startsWith('Ruy Lopez'));
    expect(r.exitPly, isNotNull);
    expect(r.exitPly, greaterThanOrEqualTo(5));
    expect(r.bookMoves, contains('a6'));
  });

  test('transposiciones: se identifica por posición', () {
    final a = book.identify(line('d2d4 d7d5 c2c4 e7e6'.split(' ')));
    final b = book.identify(line('c2c4 e7e6 d2d4 d7d5'.split(' ')));
    expect(a.opening!.name, "Queen's Gambit Declined");
    expect(b.opening!.name, a.opening!.name);
  });

  test('partida desde FEN no estándar: sin teoría', () {
    final start = positionFromFen('4k3/8/8/8/8/8/4P3/4K3 w - - 0 1');
    final r = book.identify([start, start.play(parseUciMove(start, 'e2e4')!)]);
    expect(r.opening, isNull);
    expect(r.exitPly, isNull);
  });
}
