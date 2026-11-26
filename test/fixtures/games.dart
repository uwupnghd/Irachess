/// PGN de prueba: variantes, comentarios, NAG, relojes y partida incompleta.
const pgnWithEverything = '''
[Event "Prueba"]
[Site "?"]
[Date "2026.11.20"]
[White "Ana"]
[Black "Beto"]
[Result "*"]
[TimeControl "300+2"]

{Comentario inicial} 1. e4 {[%clk 0:05:00]} e5 {[%clk 0:04:58]} 2. Nf3 (2. f4 exf4 3. Nf3 (3. Bc4)) {Lo normal} 2... Nc6 {[%clk 0:04:50]}
3. Bb5 \$1 {[%clk 0:04:40]} a6 *
''';

const scholarsMate = '''
[White "Blanco"]
[Black "Negro"]
[Result "1-0"]

1. e4 e5 2. Bc4 Nc6 3. Qh5 Nf6 4. Qxf7# 1-0
''';

const twoGames = '''
[White "A"]
[Black "B"]
[Result "1-0"]

1. d4 d5 2. c4 1-0

[White "C"]
[Black "D"]
[Result "0-1"]

1. e4 c5 0-1
''';
