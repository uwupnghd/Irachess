import 'package:dartchess/dartchess.dart';

import '../../../core/chess/chess_utils.dart';

/// Una media jugada de la línea principal.
class PlyData {
  const PlyData({required this.san, required this.uci, required this.fenBefore, this.clock, this.comment});

  final String san;

  /// UCI estándar (enroque como e1g1).
  final String uci;
  final String fenBefore;

  /// Reloj restante tras la jugada (`[%clk]`), si el PGN lo trae.
  final Duration? clock;
  final String? comment;
}

class ParsedGame {
  const ParsedGame({required this.headers, required this.startFen, required this.plies, required this.pgn});

  final Map<String, String> headers;
  final String startFen;
  final List<PlyData> plies;

  /// PGN saneado de esta partida (lo que se guarda).
  final String pgn;

  String header(String key) => headers[key] ?? '?';
  String get white => header('White');
  String get black => header('Black');
  String get result => headers['Result'] ?? '*';

  /// Posición inicial + posición tras cada media jugada.
  List<Position> positions() {
    final out = <Position>[positionFromFen(startFen)];
    for (final ply in plies) {
      out.add(out.last.play(parseUciMove(out.last, ply.uci)!));
    }
    return out;
  }

  /// Incremento en segundos según la cabecera TimeControl ("600+5").
  int get incrementSeconds {
    final tc = headers['TimeControl'];
    if (tc == null || !tc.contains('+')) return 0;
    return int.tryParse(tc.split('+').last) ?? 0;
  }
}

/// Error de importación con un código traducible.
class PgnImportException implements Exception {
  const PgnImportException(this.code, {this.game, this.ply, this.san});

  /// empty | tooLarge | noMoves | tooManyGames | illegalMove | badFen | tooLong
  final String code;
  final int? game;
  final int? ply;
  final String? san;

  @override
  String toString() => 'PgnImportException($code, game: $game, ply: $ply, san: $san)';
}

class PgnImporter {
  static const maxBytes = 2 * 1024 * 1024;
  static const maxGames = 500;
  static const maxPlies = 600;
  static const _maxHeader = 200;

  /// Quita BOM y caracteres de control (salvo saltos de línea y tabuladores).
  static String sanitize(String raw) => raw
      .replaceAll('﻿', '')
      .replaceAll('\r\n', '\n')
      .replaceAll('\r', '\n')
      .replaceAll(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]'), '');

  /// Parsea uno o varios PGN. Lanza [PgnImportException] si algo no es válido.
  static List<ParsedGame> parse(String raw) {
    if (raw.length > maxBytes) throw const PgnImportException('tooLarge');
    final text = sanitize(raw).trim();
    if (text.isEmpty) throw const PgnImportException('empty');
    final lazy = PgnGame.parseMultiGameLazy(text);
    if (lazy.length > maxGames) throw const PgnImportException('tooManyGames');
    final games = <ParsedGame>[];
    for (var i = 0; i < lazy.length; i++) {
      final game = _parseOne(lazy[i].toPgnGame(), i);
      if (game.plies.isNotEmpty) games.add(game);
    }
    if (games.isEmpty) throw const PgnImportException('noMoves');
    return games;
  }

  static ParsedGame _parseOne(PgnGame<PgnNodeData> game, int index) {
    final headers = {
      for (final e in game.headers.entries)
        e.key: e.value.length > _maxHeader ? e.value.substring(0, _maxHeader) : e.value,
    };
    final Position start;
    try {
      start = PgnGame.startingPosition(headers);
    } on Object {
      throw PgnImportException('badFen', game: index);
    }
    if (start.rule != Rule.chess) throw PgnImportException('badFen', game: index);
    final plies = <PlyData>[];
    var pos = start;
    for (final data in game.moves.mainline()) {
      if (plies.length >= maxPlies) throw PgnImportException('tooLong', game: index);
      final move = pos.parseSan(data.san);
      if (move is! NormalMove) {
        throw PgnImportException('illegalMove', game: index, ply: plies.length, san: data.san);
      }
      final comments = data.comments?.map(PgnComment.fromPgn).toList() ?? const [];
      final text = comments.map((c) => c.text).whereType<String>().join(' ');
      plies.add(PlyData(
        san: pos.makeSanUnchecked(move).$2,
        uci: standardUci(pos, move),
        fenBefore: pos.fen,
        clock: comments.map((c) => c.clock).whereType<Duration>().firstOrNull,
        comment: text.isEmpty ? null : text,
      ));
      pos = pos.playUnchecked(move);
    }
    final clean = PgnGame(headers: headers, moves: game.moves, comments: game.comments).makePgn();
    return ParsedGame(headers: headers, startFen: start.fen, plies: plies, pgn: clean);
  }
}
