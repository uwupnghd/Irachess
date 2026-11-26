import 'dart:convert';

import 'package:dartchess/dartchess.dart';
import 'package:dio/dio.dart';

import '../../../core/network/http.dart';
import '../domain/pgn_import.dart';

/// Partida descargada de un servicio público.
class OnlineGame {
  const OnlineGame(this.game, this.externalId, this.userSide);
  final ParsedGame game;
  final String externalId;
  final Side? userSide;
}

Side? _sideOf(ParsedGame g, String user) {
  final u = user.toLowerCase();
  if (g.white.toLowerCase() == u) return Side.white;
  if (g.black.toLowerCase() == u) return Side.black;
  return null;
}

final _userRe = RegExp(r'^[A-Za-z0-9_-]{2,30}$');

/// Valida el nombre de usuario antes de ponerlo en una URL.
bool validUsername(String u) => _userRe.hasMatch(u);

/// API pública de Lichess: una petición a la vez; 429 → esperar un minuto.
class LichessImporter {
  LichessImporter(this._dio);
  final Dio _dio;

  Future<List<OnlineGame>> fetch(String user, {int max = 20}) async {
    if (!validUsername(user)) throw const NotFound();
    final res = await withRetry(() => _dio.get<String>(
      'https://lichess.org/api/games/user/$user',
      queryParameters: {'max': max, 'clocks': true, 'evals': false, 'opening': false, 'perfType': 'ultraBullet,bullet,blitz,rapid,classical,correspondence'},
      options: Options(responseType: ResponseType.plain, headers: {'Accept': 'application/x-chess-pgn'}),
    ));
    final body = res.data ?? '';
    if (body.trim().isEmpty) return const [];
    return [
      for (final g in PgnImporter.parse(body))
        OnlineGame(g, g.headers['Site'] ?? GamesFingerprint.of(g), _sideOf(g, user)),
    ];
  }
}

/// API pública de Chess.com: archivos mensuales, peticiones en serie.
class ChessComImporter {
  ChessComImporter(this._dio);
  final Dio _dio;

  Future<List<OnlineGame>> fetch(String user, {int max = 20}) async {
    if (!validUsername(user)) throw const NotFound();
    final u = user.toLowerCase();
    final archivesRes = await withRetry(() => _dio.get<String>(
      'https://api.chess.com/pub/player/$u/games/archives',
      options: Options(responseType: ResponseType.plain),
    ));
    final archives = ((jsonDecode(archivesRes.data!) as Map<String, Object?>)['archives'] as List<Object?>? ?? const [])
        .cast<String>()
        .reversed;
    final out = <OnlineGame>[];
    for (final url in archives) {
      if (!url.startsWith('https://api.chess.com/')) continue;
      final res = await withRetry(() => _dio.get<String>(url, options: Options(responseType: ResponseType.plain)));
      final games = ((jsonDecode(res.data!) as Map<String, Object?>)['games'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .reversed;
      for (final j in games) {
        if (j['rules'] != 'chess' || j['pgn'] is! String) continue;
        try {
          final g = PgnImporter.parse(j['pgn']! as String).first;
          out.add(OnlineGame(g, (j['url'] as String?) ?? GamesFingerprint.of(g), _sideOf(g, user)));
        } on PgnImportException {
          continue;
        }
        if (out.length >= max) return out;
      }
    }
    return out;
  }
}

abstract final class GamesFingerprint {
  static String of(ParsedGame g) => '${g.white}|${g.black}|${g.header('Date')}|${g.plies.length}';
}
