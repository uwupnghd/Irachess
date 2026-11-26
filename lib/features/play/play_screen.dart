import 'dart:async';
import 'dart:math';

import 'package:dartchess/dartchess.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/chess/chess_utils.dart';
import '../../core/chess/notation.dart';
import '../../core/providers.dart';
import '../../core/settings/settings.dart';
import '../../core/ui/widgets/board_view.dart';
import '../../core/ui/widgets/common.dart';
import '../../l10n/gen/app_localizations.dart';
import '../games/domain/pgn_import.dart';
import 'game_state.dart';

/// Nivel 1–8 → Skill Level de Stockfish y tiempo por jugada.
(int skill, Duration time) levelParams(int level) =>
    ([0, 2, 4, 7, 10, 13, 16, 20][level - 1], Duration(milliseconds: 100 + level * 60));

String endText(AppLocalizations l, GameEnd e) => switch (e) {
  GameEnd.checkmate => l.resultCheckmate,
  GameEnd.stalemate => l.resultStalemate,
  GameEnd.repetition => l.resultRepetition,
  GameEnd.fiftyMoves => l.resultFiftyMoves,
  GameEnd.material => l.resultMaterial,
  GameEnd.resigned => l.resultResigned,
};

class PlayScreen extends ConsumerStatefulWidget {
  const PlayScreen({super.key});

  @override
  ConsumerState<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends ConsumerState<PlayScreen> {
  int _level = 3;
  Side? _choice = Side.white;
  LiveGame? _game;
  Side _side = Side.white;
  bool _thinking = false;
  String? _error;
  int? _savedId;

  void _start() {
    setState(() {
      _side = _choice ?? (Random().nextBool() ? Side.white : Side.black);
      _game = LiveGame();
      _savedId = null;
      _error = null;
    });
    if (_side == Side.black) _engineMove();
  }

  Future<void> _engineMove() async {
    final g = _game!;
    setState(() => _thinking = true);
    try {
      final engine = await ref.read(engineProvider.future);
      final (skill, time) = levelParams(_level);
      final uci = await engine.bestMove(g.position.fen, skill: skill, time: time);
      if (!mounted || _game != g) return;
      final move = uci == null ? null : parseUciMove(g.position, uci);
      if (move != null) {
        setState(() => g.play(move));
        _feedback();
      }
    } catch (e) {
      if (mounted) setState(() => _error = AppLocalizations.of(context).engineUnavailable('$e'));
    } finally {
      if (mounted) setState(() => _thinking = false);
    }
    if (g.end != null) await _save();
  }

  void _feedback() {
    final s = ref.read(settingsProvider);
    if (s.sound) SystemSound.play(SystemSoundType.click);
  }

  Future<void> _onMove(NormalMove move) async {
    final g = _game!;
    setState(() => g.play(move));
    _feedback();
    if (g.end != null) {
      await _save();
    } else {
      await _engineMove();
    }
  }

  Future<void> _save() async {
    if (_savedId != null) return;
    final l = AppLocalizations.of(context);
    final g = _game!;
    if (g.moves.isEmpty) return;
    final now = DateTime.now();
    final date = '${now.year}.${now.month.toString().padLeft(2, '0')}.${now.day.toString().padLeft(2, '0')}';
    final engineName = '${l.engineName} · ${l.playLevel(_level)}';
    final pgn = g.pgn(
      white: _side == Side.white ? l.you : engineName,
      black: _side == Side.black ? l.you : engineName,
      date: date,
    );
    final parsed = PgnImporter.parse(pgn).single;
    final (id, _) = await ref
        .read(gamesRepositoryProvider)
        .insert(parsed, source: 'engine', externalId: '${now.millisecondsSinceEpoch}', userSide: _side);
    if (mounted) setState(() => _savedId = id);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final g = _game;
    return Scaffold(
      appBar: AppBar(title: Text(l.playTitle)),
      body: g == null ? _setup(l) : _board(l, g),
    );
  }

  Widget _setup(AppLocalizations l) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: ListView(padding: const EdgeInsets.all(16), children: [
        SectionTitle(l.playLevel(_level)),
        Slider(
          value: _level.toDouble(),
          min: 1,
          max: 8,
          divisions: 7,
          label: '$_level',
          onChanged: (v) => setState(() => _level = v.round()),
        ),
        SectionTitle(l.playColor),
        SegmentedButton<Side?>(
          segments: [
            ButtonSegment(value: Side.white, label: Text(l.sideWhite)),
            ButtonSegment(value: Side.black, label: Text(l.sideBlack)),
            ButtonSegment(value: null, label: Text(l.playRandom)),
          ],
          selected: {_choice},
          onSelectionChanged: (s) => setState(() => _choice = s.first),
        ),
        const SizedBox(height: 24),
        FilledButton.icon(onPressed: _start, icon: const Icon(Icons.play_arrow), label: Text(l.playStart)),
      ]),
    ),
  );

  Widget _board(AppLocalizations l, LiveGame g) {
    final t = Theme.of(context).textTheme;
    final end = g.end;
    final String status;
    if (end != null) {
      final win = (g.result == '1-0' && _side == Side.white) || (g.result == '0-1' && _side == Side.black);
      final head = g.result == '1/2-1/2' ? l.playDraw : (win ? l.playYouWin : l.playYouLose);
      status = '$head · ${endText(l, end)}';
    } else {
      status = _thinking ? l.playThinking : l.playYourMove;
    }
    final panel = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Semantics(liveRegion: true, child: Text(status, style: t.titleMedium)),
      if (_error != null) Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
      const SizedBox(height: 8),
      Text(
        localizeSan([for (var i = 0; i < g.sans.length; i++) i.isEven ? '${i ~/ 2 + 1}. ${g.sans[i]}' : g.sans[i]].join(' '), l.localeName),
        style: t.bodySmall,
      ),
      const SizedBox(height: 12),
      Wrap(spacing: 8, runSpacing: 8, children: [
        if (end == null)
          OutlinedButton.icon(
            onPressed: () async {
              setState(() => g.resign(_side));
              await _save();
            },
            icon: const Icon(Icons.flag),
            label: Text(l.playResign),
          )
        else ...[
          if (_savedId != null)
            FilledButton.icon(
              onPressed: () => context.go('/analyze/game/$_savedId'),
              icon: const Icon(Icons.insights),
              label: Text(l.playAnalyze),
            ),
          OutlinedButton(onPressed: () => setState(() => _game = null), child: Text(l.playStart)),
        ],
      ]),
    ]);
    return LayoutBuilder(builder: (context, c) {
      final wide = c.maxWidth >= 840;
      final board = BoardView(
        fen: g.position.fen,
        orientation: _side,
        lastMove: g.moves.isEmpty ? null : g.moves.last,
        movable: end == null && !_thinking && g.position.turn == _side ? _side : null,
        onMove: _onMove,
        size: wide ? (c.maxHeight - 32).clamp(240.0, c.maxWidth - 360) : c.maxWidth - 16,
      );
      if (wide) {
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(padding: const EdgeInsets.all(16), child: board),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: panel)),
        ]);
      }
      return ListView(padding: const EdgeInsets.all(8), children: [board, Padding(padding: const EdgeInsets.all(8), child: panel)]);
    });
  }
}
