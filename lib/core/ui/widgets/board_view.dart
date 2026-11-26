import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/gen/app_localizations.dart';
import '../../chess/chess_utils.dart';
import '../../settings/settings.dart';
import '../theme.dart';

/// Tablero interactivo o de solo lectura sobre chessground.
class BoardView extends ConsumerStatefulWidget {
  const BoardView({
    super.key,
    required this.fen,
    this.orientation = Side.white,
    this.lastMove,
    this.shapes = const {},
    this.annotations = const {},
    this.movable,
    this.onMove,
    this.size,
  });

  final String fen;
  final Side orientation;
  final Move? lastMove;
  final Set<Shape> shapes;
  final Map<Square, Annotation> annotations;

  /// Bando que puede mover (null = solo lectura).
  final Side? movable;
  final void Function(NormalMove move)? onMove;
  final double? size;

  @override
  ConsumerState<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends ConsumerState<BoardView> {
  late final ChessboardController _controller = ChessboardController(game: _game());

  GameData _game() {
    final pos = positionFromFen(widget.fen);
    return GameData(
      fen: pos.fen,
      lastMove: widget.lastMove,
      playerSide: switch (widget.movable) {
        null => PlayerSide.none,
        Side.white => PlayerSide.white,
        Side.black => PlayerSide.black,
      },
      sideToMove: pos.turn,
      kingSquareInCheck: pos.isCheck ? pos.board.kingOf(pos.turn) : null,
      validMoves: widget.movable == null ? const {} : makeLegalMoves(pos),
    );
  }

  @override
  void didUpdateWidget(BoardView old) {
    super.didUpdateWidget(old);
    if (old.fen != widget.fen || old.movable != widget.movable || old.lastMove != widget.lastMove) {
      _controller.updatePosition(_game(), resetPremove: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onMove(Move move, {bool? viaDragAndDrop}) {
    final pos = positionFromFen(widget.fen);
    if (move is! NormalMove) return;
    final normalized = pos.normalizeMove(move);
    if (normalized is NormalMove && pos.isLegal(normalized)) {
      if (ref.read(settingsProvider).haptics) HapticFeedback.selectionClick();
      widget.onMove?.call(normalized);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(settingsProvider);
    return LayoutBuilder(builder: (context, c) {
      final size = widget.size ?? (c.maxWidth < c.maxHeight ? c.maxWidth : c.maxHeight);
      return Semantics(
        label: describePosition(AppLocalizations.of(context), widget.fen),
        child: Chessboard(
          size: size,
          controller: _controller,
          orientation: widget.orientation,
          onMove: _onMove,
          shapes: widget.shapes,
          annotations: widget.annotations,
          settings: ChessboardSettings(
            colorScheme: boardThemes[s.boardTheme] ?? boardThemes['slate']!,
            pieceAssets: s.pieceSet.assets,
            enableCoordinates: s.coordinates,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            animationDuration: const Duration(milliseconds: 180),
            enablePremoves: false,
          ),
        ),
      );
    });
  }
}

/// Descripción de la posición para lectores de pantalla.
String describePosition(AppLocalizations l, String fen) {
  final board = positionFromFen(fen).board;
  String side(Side s) {
    final pieces = <String>[];
    for (final role in [Role.king, Role.queen, Role.rook, Role.bishop, Role.knight, Role.pawn]) {
      final squares = board.piecesOf(s, role).squares.map((q) => q.name).join(', ');
      if (squares.isNotEmpty) pieces.add('${l.pieceName(role.name)} $squares');
    }
    return pieces.join('; ');
  }

  return '${l.sideWhite}: ${side(Side.white)}. ${l.sideBlack}: ${side(Side.black)}.';
}
