// Genera assets/openings.tsv (eco \t nombre \t jugadas UCI) a partir del
// dataset CC0 lichess-org/chess-openings. Uso: dart run tool/build_openings.dart
import 'dart:io';

import 'package:dartchess/dartchess.dart' hide File;

const _base = 'https://raw.githubusercontent.com/lichess-org/chess-openings/master/';

Future<void> main() async {
  final client = HttpClient();
  final out = StringBuffer();
  var count = 0;
  for (final vol in ['a', 'b', 'c', 'd', 'e']) {
    final req = await client.getUrl(Uri.parse('$_base$vol.tsv'));
    final res = await req.close();
    final body = await res.transform(const SystemEncoding().decoder).join();
    for (final line in body.split('\n').skip(1)) {
      final cols = line.split('\t');
      if (cols.length < 3) continue;
      Position pos = Chess.initial;
      final ucis = <String>[];
      for (final san in PgnGame.parsePgn(cols[2]).moves.mainline().map((d) => d.san)) {
        final move = pos.parseSan(san)!;
        ucis.add(move.uci);
        pos = pos.play(move);
      }
      out.writeln('${cols[0]}\t${cols[1]}\t${ucis.join(' ')}');
      count++;
    }
  }
  client.close();
  File('assets/openings.tsv').writeAsStringSync(out.toString());
  stdout.writeln('$count aperturas');
}
