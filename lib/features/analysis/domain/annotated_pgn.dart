import 'package:dartchess/dartchess.dart';

import '../../games/domain/pgn_import.dart';
import 'game_report.dart';

const _nags = {
  MoveClass.brilliant: 3, // !!
  MoveClass.great: 1, // !
  MoveClass.inaccuracy: 6, // ?!
  MoveClass.mistake: 2, // ?
  MoveClass.miss: 2,
  MoveClass.blunder: 4, // ??
};

/// PGN de la línea principal con NAG, `[%eval]` y un comentario por jugada.
String annotatedPgn(ParsedGame game, GameReport report, String Function(MoveReport) comment) {
  final root = PgnNode<PgnNodeData>();
  PgnNode<PgnNodeData> node = root;
  for (final m in report.moves) {
    final ply = game.plies[m.ply];
    final eval = m.mateAfter != null
        ? PgnEvaluation.mate(mate: m.mateAfter)
        : PgnEvaluation.pawns(pawns: (m.cpAfter ?? 0) / 100);
    final text = [if (ply.comment != null) ply.comment!, comment(m)].join(' ');
    final child = PgnChildNode(PgnNodeData(
      san: m.san,
      nags: _nags[m.cls] == null ? null : [_nags[m.cls]!],
      comments: [PgnComment(text: text.isEmpty ? null : text, clock: ply.clock, eval: eval).makeComment()],
    ));
    node.children.add(child);
    node = child;
  }
  final headers = {...game.headers, 'Annotator': 'IraChess'};
  return PgnGame(headers: headers, moves: root, comments: const []).makePgn();
}
