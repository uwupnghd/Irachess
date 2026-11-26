import 'dart:async';

import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/chess/notation.dart';
import '../../../core/providers.dart';
import '../../../core/settings/settings.dart';
import '../../../core/ui/widgets/board_view.dart';
import '../../../core/ui/widgets/common.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../analysis/domain/game_report.dart';
import '../../analysis/presentation/explain_text.dart';
import '../domain/puzzle.dart';
import 'puzzles_home.dart';

class PuzzleScreen extends ConsumerStatefulWidget {
  const PuzzleScreen({super.key, required this.theme});
  final String theme;

  @override
  ConsumerState<PuzzleScreen> createState() => _PuzzleScreenState();
}

enum _Feedback { none, correct, wrong, solved, failed }

class _PuzzleScreenState extends ConsumerState<PuzzleScreen> {
  PuzzleRun? _run;
  String? _fen;
  Move? _lastMove;
  bool _loading = true;
  bool _empty = false;
  _Feedback _feedback = _Feedback.none;
  int _hints = 0;
  bool _recorded = false;
  double? _rating;
  double? _delta;
  int _streak = 0;
  final _watch = Stopwatch();
  String? _opponent;

  @override
  void initState() {
    super.initState();
    _next();
  }

  Future<void> _next() async {
    setState(() => _loading = true);
    final repo = ref.read(puzzleRepositoryProvider);
    await repo.ensureBaseLoaded();
    final rating = await repo.currentRating();
    final streak = await repo.currentStreak();
    final p = await repo.next(theme: widget.theme, rating: rating.rating);
    String? opponent;
    if (p?.gameId != null) {
      final g = await ref.read(gamesRepositoryProvider).getGame(p!.gameId!);
      if (g != null) opponent = g.userSide == 'white' ? g.black : g.white;
    }
    if (!mounted) return;
    setState(() {
      _loading = false;
      _empty = p == null;
      _run = p == null ? null : PuzzleRun(p);
      _fen = _run?.position.fen;
      _lastMove = _run?.lastMove;
      _feedback = _Feedback.none;
      _hints = 0;
      _recorded = false;
      _rating = rating.rating;
      _delta = null;
      _streak = streak;
      _opponent = opponent;
      _watch
        ..reset()
        ..start();
    });
  }

  void _feel(bool good) {
    final s = ref.read(settingsProvider);
    if (s.haptics) good ? HapticFeedback.lightImpact() : HapticFeedback.heavyImpact();
    if (s.sound) SystemSound.play(SystemSoundType.click);
  }

  Future<void> _record({required bool solved}) async {
    if (_recorded) return;
    _recorded = true;
    _watch.stop();
    final run = _run!;
    final (after, delta) = await ref
        .read(puzzleRepositoryProvider)
        .recordAttempt(run.puzzle, solved: solved && run.mistakes == 0, hints: _hints, time: _watch.elapsed);
    ref.invalidate(puzzleOverviewProvider);
    if (mounted) {
      setState(() {
        _rating = after.rating;
        _delta = delta;
        _streak = solved && run.mistakes == 0 && _hints == 0 ? _streak + 1 : 0;
      });
    }
  }

  Future<void> _onMove(NormalMove move) async {
    final run = _run!;
    final before = run.position;
    final (step, reply) = run.play(move);
    switch (step) {
      case PuzzleStep.wrong:
        _feel(false);
        setState(() => _feedback = _Feedback.wrong);
      case PuzzleStep.correct:
      case PuzzleStep.solved:
        _feel(true);
        setState(() {
          _fen = before.play(move).fen;
          _lastMove = move;
          _feedback = step == PuzzleStep.solved && reply == null ? _Feedback.solved : _Feedback.correct;
        });
        if (reply != null) {
          await Future<void>.delayed(const Duration(milliseconds: 450));
          if (!mounted) return;
          setState(() {
            _fen = run.position.fen;
            _lastMove = reply;
            if (run.done) _feedback = _Feedback.solved;
          });
        }
        if (run.done) await _record(solved: true);
    }
  }

  Future<void> _showSolution() async {
    final run = _run!;
    await _record(solved: false);
    while (!run.done) {
      final m = run.expectedMove;
      if (m == null) break;
      final before = run.position;
      final (_, reply) = run.play(m);
      setState(() {
        _fen = before.play(m).fen;
        _lastMove = m;
      });
      await Future<void>.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      if (reply != null) {
        setState(() {
          _fen = run.position.fen;
          _lastMove = reply;
        });
        await Future<void>.delayed(const Duration(milliseconds: 600));
        if (!mounted) return;
      }
    }
    setState(() => _feedback = _Feedback.failed);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final title = l.themeName(widget.theme);
    if (_loading) return Scaffold(appBar: AppBar(title: Text(title)), body: const Center(child: CircularProgressIndicator()));
    if (_empty) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: EmptyState(icon: Icons.extension_off, title: title, body: widget.theme == 'own' ? l.puzzleMyErrorsEmpty : l.puzzleNoMore),
      );
    }
    final run = _run!;
    final p = run.puzzle;
    final expected = run.expectedMove;
    final shapes = <Shape>{};
    if (!run.done && expected != null && _hints >= 1) {
      shapes.add(Circle(color: const Color(0xCCF2A541), orig: expected.from));
      if (_hints >= 2) shapes.add(Arrow(color: const Color(0xCCF2A541), orig: expected.from, dest: expected.to));
    }
    final sideName = run.userSide == Side.white ? l.sideWhite : l.sideBlack;
    final (msg, color) = switch (_feedback) {
      _Feedback.none => (l.puzzleYourTurn(sideName), null),
      _Feedback.correct => (l.puzzleCorrect, const Color(0xFF2E9E5B)),
      _Feedback.wrong => (l.puzzleWrong, scheme.error),
      _Feedback.solved => (l.puzzleSolved, const Color(0xFF2E9E5B)),
      _Feedback.failed => (l.puzzleFailed, scheme.error),
    };
    final note = p.note;
    final info = <Widget>[
      Semantics(
        liveRegion: true,
        child: Text(msg, style: t.titleMedium!.copyWith(color: color, fontWeight: FontWeight.bold)),
      ),
      const SizedBox(height: 8),
      if (_rating != null)
        Text(_delta == null
            ? l.puzzleRating(_rating!.round())
            : l.puzzleRatingChange(_rating!.round(), '${_delta! >= 0 ? '+' : ''}${_delta!.round()}')),
      Text(l.puzzleStreak(_streak)),
      if (_opponent != null) Text(l.puzzleFromGame(_opponent!)),
      if (_hints >= 1 && expected != null && !run.done)
        Text(l.puzzleHintText(run.position.board.roleAt(expected.from)!.name, expected.from.name)),
      if (run.done && note != null) ...[
        const SizedBox(height: 8),
        Text(l.puzzleExplainOwn(localizeSan('${note['played']}', l.localeName), localizeSan('${note['best']}', l.localeName)), style: t.bodyLarge),
        Text(renderExplanation(l, [
          for (final e in (note['expl'] as List<Object?>? ?? const [])) ExplPart.fromJson(e! as Map<String, Object?>),
        ])),
      ],
      if (run.done && note == null && p.themes.isNotEmpty)
        Text(p.themes.where(puzzleThemes.contains).map(l.themeName).join(' · '), style: t.bodySmall),
      const SizedBox(height: 12),
      Wrap(spacing: 8, runSpacing: 8, children: [
        if (!run.done) ...[
          OutlinedButton.icon(
            onPressed: _hints >= 2 ? null : () => setState(() => _hints++),
            icon: const Icon(Icons.lightbulb_outline),
            label: Text(l.puzzleHint),
          ),
          OutlinedButton.icon(onPressed: _showSolution, icon: const Icon(Icons.visibility), label: Text(l.puzzleSolution)),
        ] else
          FilledButton.icon(onPressed: _next, icon: const Icon(Icons.skip_next), label: Text(l.next)),
      ]),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: LayoutBuilder(builder: (context, c) {
        final wide = c.maxWidth >= 840;
        final board = BoardView(
          fen: _fen!,
          orientation: run.userSide,
          lastMove: _lastMove,
          shapes: shapes,
          movable: run.done ? null : run.userSide,
          onMove: _onMove,
          size: wide ? (c.maxHeight - 32).clamp(240.0, c.maxWidth - 360) : c.maxWidth - 16,
        );
        if (wide) {
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: const EdgeInsets.all(16), child: board),
            Expanded(child: ListView(padding: const EdgeInsets.all(16), children: info)),
          ]);
        }
        return ListView(padding: const EdgeInsets.all(8), children: [
          board,
          Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: info)),
        ]);
      }),
    );
  }
}
