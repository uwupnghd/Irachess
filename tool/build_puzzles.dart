// Genera el lote base (assets/puzzles/base.csv) y los paquetes descargables
// (puzzle_packs/) desde la base de puzzles de Lichess (CC0).
// Uso: zstd -dc lichess_db_puzzle.csv.zst | dart run tool/build_puzzles.dart
import 'dart:convert';
import 'dart:io';

const themes = [
  'mateIn1', 'mateIn2', 'mateIn3', 'backRankMate', 'fork', 'pin', 'skewer',
  'discoveredAttack', 'hangingPiece', 'sacrifice', 'trappedPiece', 'endgame',
];
const bands = {'a': (400, 1000), 'b': (1000, 1500), 'c': (1500, 2100)};
const basePerBucket = 40;
const packSize = 400;

Future<void> main() async {
  final base = <String, List<String>>{};
  final packs = <String, List<String>>{};
  var full = 0;
  final total = themes.length * bands.length;
  await for (final line in stdin.transform(utf8.decoder).transform(const LineSplitter()).skip(1)) {
    final c = line.split(',');
    if (c.length < 8) continue;
    final rating = int.parse(c[3]), rd = int.parse(c[4]), pop = int.parse(c[5]), plays = int.parse(c[6]);
    if (rd > 90 || pop < 85 || plays < 1000) continue;
    final band = bands.entries.where((b) => rating >= b.value.$1 && rating < b.value.$2).firstOrNull?.key;
    if (band == null) continue;
    final tags = c[7].split(' ');
    final theme = themes.where(tags.contains).firstOrNull;
    if (theme == null) continue;
    final key = '$theme-$band';
    final row = [c[0], c[1], c[2], c[3], c[5], c[7]].join(',');
    final b = base.putIfAbsent(key, () => []);
    if (b.length < basePerBucket) {
      b.add(row);
      continue;
    }
    final p = packs.putIfAbsent(key, () => []);
    if (p.length < packSize) {
      p.add(row);
      if (p.length == packSize && ++full == total) break;
    }
  }
  File('assets/puzzles/base.csv').writeAsStringSync('${base.values.expand((r) => r).join('\n')}\n');
  Directory('puzzle_packs').createSync(recursive: true);
  final index = <Map<String, Object>>[];
  for (final MapEntry(:key, :value) in packs.entries) {
    final body = '${value.join('\n')}\n';
    File('puzzle_packs/$key.csv').writeAsStringSync(body);
    final (theme, band) = (key.substring(0, key.lastIndexOf('-')), key.substring(key.lastIndexOf('-') + 1));
    index.add({
      'id': key,
      'theme': theme,
      'min': bands[band]!.$1,
      'max': bands[band]!.$2,
      'count': value.length,
      'bytes': utf8.encode(body).length,
      'version': 1,
      'file': '$key.csv',
    });
  }
  index.sort((a, b) => (a['id']! as String).compareTo(b['id']! as String));
  File('puzzle_packs/index.json').writeAsStringSync(const JsonEncoder.withIndent('  ').convert(index));
  stdout.writeln('base: ${base.values.fold<int>(0, (s, r) => s + r.length)}; paquetes: ${index.length}');
}
