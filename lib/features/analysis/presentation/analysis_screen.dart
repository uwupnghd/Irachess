import 'dart:async';

import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/chess/chess_utils.dart';
import '../../../core/chess/notation.dart';
import '../../../core/db/database.dart';
import '../../../core/providers.dart';
import '../../../core/settings/settings.dart';
import '../../../core/ui/theme.dart';
import '../../../core/ui/widgets/board_view.dart';
import '../../../core/ui/widgets/class_badge.dart';
import '../../../core/ui/widgets/common.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../games/domain/pgn_import.dart';
import '../data/analysis_service.dart';
import '../domain/annotated_pgn.dart';
import '../domain/game_report.dart';
import '../domain/win_chances.dart';
import 'eval_widgets.dart';
import 'explain_text.dart';
import 'move_table.dart';
import 'summary_view.dart';

class GameDetail {
  const GameDetail(this.row, this.game, this.report);
  final Game row;
  final ParsedGame game;
  final GameReport? report;
  Side? get userSide => row.userSide == null ? null : Side.values.byName(row.userSide!);
}

final gameDetailProvider = FutureProvider.autoDispose.family<GameDetail, int>((ref, id) async {
  final row = await ref.watch(gamesRepositoryProvider).getGame(id);
  if (row == null) throw StateError('not found');
  final game = PgnImporter.parse(row.pgn).first;
  final report = await ref.watch(analysisServiceProvider).loadReport(id);
  return GameDetail(row, game, report);
});

class AnalysisScreen extends ConsumerWidget {
  const AnalysisScreen({super.key, required this.gameId});
  final int gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final detail = ref.watch(gameDetailProvider(gameId));
    return detail.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(appBar: AppBar(), body: ErrorView(l.errorGeneric('$e'))),
      data: (d) => _AnalysisView(detail: d),
    );
  }
}

class _AnalysisView extends ConsumerStatefulWidget {
  const _AnalysisView({required this.detail});
  final GameDetail detail;

  @override
  ConsumerState<_AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends ConsumerState<_AnalysisView> {
  late final List<Position> _positions = widget.detail.game.positions();
  late GameReport? _report = widget.detail.report;
  late Side? _userSide = widget.detail.userSide;
  late Side _orientation = _userSide ?? Side.white;
  int _index = 0;
  MoveFilter _filter = MoveFilter.all;
  AnalysisProgress? _progress;
  AnalysisCancel? _cancel;
  String? _error;

  // "Pruébalo tú"
  bool _trying = false;
  bool _revealed = false;
  String? _tryFeedback;
  bool _tryOk = false;

  final _focus = FocusNode();

  int get _n => _positions.length - 1;
  MoveReport? get _move => _report != null && _index > 0 ? _report!.moves[_index - 1] : null;

  @override
  void dispose() {
    _cancel?.cancelled = true;
    ref.read(engineProvider).whenData((e) => e.stop());
    _focus.dispose();
    super.dispose();
  }

  void _go(int i) => setState(() {
    _index = i.clamp(0, _n);
    _trying = false;
    _revealed = false;
    _tryFeedback = null;
  });

  Future<void> _analyse() async {
    final l = AppLocalizations.of(context);
    final cancel = AnalysisCancel();
    setState(() {
      _cancel = cancel;
      _error = null;
      _progress = AnalysisProgress(0, _positions.length);
    });
    try {
      final service = ref.read(analysisServiceProvider);
      final row = widget.detail.row.copyWith(userSide: Value(_userSide?.name));
      await for (final p in service.analyse(row, widget.detail.game, ref.read(settingsProvider).preset, cancel)) {
        if (!mounted) return;
        setState(() {
          _progress = p;
          if (p.report != null) _report = p.report;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = l.errorGeneric('$e'));
    } finally {
      if (mounted) {
        setState(() {
          _progress = null;
          _cancel = null;
        });
      }
    }
  }

  void _stop() {
    _cancel?.cancelled = true;
    ref.read(engineProvider).whenData((e) => e.stop());
    setState(() {
      _progress = null;
      _cancel = null;
    });
  }

  Future<void> _setUserSide(Side? side) async {
    setState(() {
      _userSide = side;
      if (side != null) _orientation = side;
    });
    await ref.read(gamesRepositoryProvider).setUserSide(widget.detail.row.id, side);
  }

  void _onTryMove(NormalMove move) {
    final m = _move!;
    final pos = positionFromFen(m.fenBefore);
    final uci = standardUci(pos, move);
    final l = AppLocalizations.of(context);
    final san = localizeSan(pos.makeSanUnchecked(move).$2, l.localeName);
    final best = m.alternatives.first;
    final bestW = winPercent(cp: best.cp, mate: best.mate);
    final ok = m.alternatives.any((a) => a.uci == uci && bestW - winPercent(cp: a.cp, mate: a.mate) <= Thresholds.excellent);
    if (ref.read(settingsProvider).haptics) HapticFeedback.lightImpact();
    setState(() {
      _tryOk = ok;
      _revealed = ok;
      _tryFeedback = ok ? l.tryItCorrect(san) : l.tryItWrong(san);
    });
  }

  Future<void> _export() async {
    final l = AppLocalizations.of(context);
    final g = widget.detail.game;
    final pgn = annotatedPgn(g, _report!, (m) {
      final best = m.best?.san;
      final extra = m.cls.isBad && best != null ? ' ${l.bestMoveWas(best)}.' : '';
      return '${className(l, m.cls)}.$extra';
    });
    await exportText('irachess_${g.white}_vs_${g.black}.pgn'.replaceAll(RegExp(r'[^\w.]+'), '_'), pgn);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent e) {
    if (e is! KeyDownEvent && e is! KeyRepeatEvent) return KeyEventResult.ignored;
    switch (e.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        _go(_index - 1);
      case LogicalKeyboardKey.arrowRight:
        _go(_index + 1);
      case LogicalKeyboardKey.home || LogicalKeyboardKey.arrowUp:
        _go(0);
      case LogicalKeyboardKey.end || LogicalKeyboardKey.arrowDown:
        _go(_n);
      case LogicalKeyboardKey.keyF:
        setState(() => _orientation = _orientation.opposite);
      default:
        return KeyEventResult.ignored;
    }
    return KeyEventResult.handled;
  }

  Widget _board(double size) {
    final m = _move;
    final s = ref.watch(settingsProvider);
    final shapes = <Shape>{};
    final annotations = <Square, Annotation>{};
    String fen;
    Move? last;
    Side? movable;
    if (_trying && m != null) {
      fen = m.fenBefore;
      movable = positionFromFen(fen).turn;
      if (_revealed) {
        final b = NormalMove.fromUci(m.best!.uci);
        shapes.add(Arrow(color: const Color(0xCC2E9E5B), orig: b.from, dest: b.to));
        movable = null;
      }
    } else {
      fen = _positions[_index].fen;
      if (_index > 0) {
        final played = NormalMove.fromUci(widget.detail.game.plies[_index - 1].uci);
        last = played;
        if (m != null) {
          final style = classStyle(m.cls, colorBlind: s.colorBlind);
          annotations[played.to] = Annotation(symbol: style.symbol, color: style.color);
          final best = m.best;
          if (best != null && best.uci != m.uci && m.cls != MoveClass.book) {
            final b = NormalMove.fromUci(best.uci);
            shapes.add(Arrow(color: style.color.withValues(alpha: 0.75), orig: played.from, dest: played.to, scale: 0.8));
            shapes.add(Arrow(color: const Color(0xCC2E9E5B), orig: b.from, dest: b.to));
          }
        }
      }
    }
    return BoardView(
      fen: fen,
      orientation: _orientation,
      lastMove: last,
      shapes: shapes,
      annotations: annotations,
      movable: movable,
      onMove: _onTryMove,
      size: size,
    );
  }

  Widget _evalBar(double height) {
    final r = _report;
    if (r == null) return const SizedBox(width: 22);
    final m = _move;
    final whiteWin = m == null ? r.startWhiteWin : m.whiteWinAfter;
    final label = m == null ? '' : evalText(cp: m.cpAfter, mate: m.mateAfter);
    return SizedBox(height: height, child: EvalBar(whiteWin: whiteWin, label: label, orientation: _orientation));
  }

  Widget _navBar(AppLocalizations l) => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    IconButton(tooltip: l.flipBoard, icon: const Icon(Icons.swap_vert), onPressed: () => setState(() => _orientation = _orientation.opposite)),
    IconButton(tooltip: l.firstMove, icon: const Icon(Icons.first_page), onPressed: _index > 0 ? () => _go(0) : null),
    IconButton(tooltip: l.prevMove, iconSize: 32, icon: const Icon(Icons.chevron_left), onPressed: _index > 0 ? () => _go(_index - 1) : null),
    IconButton(tooltip: l.nextMove, iconSize: 32, icon: const Icon(Icons.chevron_right), onPressed: _index < _n ? () => _go(_index + 1) : null),
    IconButton(tooltip: l.lastMove, icon: const Icon(Icons.last_page), onPressed: _index < _n ? () => _go(_n) : null),
    if (_report != null) IconButton(tooltip: l.exportPgn, icon: const Icon(Icons.ios_share), onPressed: _export),
  ]);

  Widget _moveCard(AppLocalizations l) {
    final t = Theme.of(context).textTheme;
    final m = _move;
    if (_report == null) return _analyseCard(l);
    if (m == null) {
      return Card(child: ListTile(title: Text(l.startPosition), subtitle: Text(widget.detail.game.result)));
    }
    final card = Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(moveLabel(l, m), style: t.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(width: 12),
            ClassChip(m.cls),
            const Spacer(),
            Text(evalText(cp: m.cpAfter, mate: m.mateAfter), style: t.titleSmall),
          ]),
          const SizedBox(height: 8),
          Text(renderExplanation(l, m.explanation), style: t.bodyLarge),
          if (m.alternatives.isNotEmpty && m.cls != MoveClass.book) ...[
            const SizedBox(height: 8),
            Text(l.alternatives, style: t.labelMedium),
            for (final a in m.alternatives)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  '${_altEval(a, m)}  ${localizeSan(a.line.take(6).join(' '), l.localeName)}',
                  style: t.bodySmall!.copyWith(fontFamily: 'monospace'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
          if (m.cls.isBad && m.best != null) ...[
            const SizedBox(height: 8),
            if (_trying) ...[
              Text(
                _tryFeedback ?? l.tryItPrompt(m.whiteMoved ? l.sideWhite : l.sideBlack),
                style: t.bodyMedium!.copyWith(
                  color: _tryFeedback == null ? null : (_tryOk ? const Color(0xFF2E9E5B) : Theme.of(context).colorScheme.error),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Wrap(spacing: 8, children: [
                if (!_revealed) TextButton(onPressed: () => setState(() => _revealed = true), child: Text(l.tryItReveal)),
                TextButton(onPressed: () => _go(_index), child: Text(l.close)),
              ]),
            ] else
              FilledButton.tonalIcon(
                onPressed: () => setState(() {
                  _trying = true;
                  _tryFeedback = null;
                }),
                icon: const Icon(Icons.psychology_alt),
                label: Text(l.tryIt),
              ),
          ],
        ]),
      ),
    );
    return GestureDetector(
      onHorizontalDragEnd: (d) {
        final v = d.primaryVelocity ?? 0;
        if (v > 200) _go(_index - 1);
        if (v < -200) _go(_index + 1);
      },
      child: card,
    );
  }

  String _altEval(AltMove a, MoveReport m) {
    final sign = m.whiteMoved ? 1 : -1;
    return evalText(cp: a.cp == null ? null : a.cp! * sign, mate: a.mate == null ? null : a.mate! * sign).padLeft(5);
  }

  Widget _analyseCard(AppLocalizations l) {
    final p = _progress;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (p != null) ...[
            Text(l.analyzing(p.done, p.total)),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: p.fraction),
            const SizedBox(height: 8),
            Align(alignment: Alignment.centerRight, child: TextButton(onPressed: _stop, child: Text(l.cancel))),
          ] else ...[
            Text(l.importWhichSide),
            const SizedBox(height: 8),
            SegmentedButton<Side?>(
              segments: [
                ButtonSegment(value: Side.white, label: Text(l.sideWhite)),
                ButtonSegment(value: Side.black, label: Text(l.sideBlack)),
                ButtonSegment(value: null, label: Text(l.sideUnknown)),
              ],
              selected: {_userSide},
              onSelectionChanged: (s) => _setUserSide(s.first),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(onPressed: _analyse, icon: const Icon(Icons.insights), label: Text(l.analyzeButton)),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
          ],
        ]),
      ),
    );
  }

  Widget _tabs(AppLocalizations l, {required bool scrollable}) {
    final r = _report;
    if (r == null) return const SizedBox.shrink();
    final g = widget.detail.game;
    final table = MoveTable(
      moves: r.moves,
      index: _index,
      onSelect: _go,
      filter: _filter,
      onFilter: (f) => setState(() => _filter = f),
      userSide: _userSide,
    );
    final summary = SummaryView(report: r, white: g.white, black: g.black, userSide: _userSide, onSelect: _go);
    return DefaultTabController(
      length: 2,
      child: Column(children: [
        TabBar(tabs: [Tab(text: l.tabMoves), Tab(text: l.tabSummary)]),
        if (scrollable)
          Expanded(child: TabBarView(children: [SingleChildScrollView(child: table), summary]))
        else
          SizedBox(height: 520, child: TabBarView(children: [SingleChildScrollView(child: table), summary])),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final g = widget.detail.game;
    final graph = _report == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: EvalGraph(whiteWins: _report!.whiteWins, index: _index, onSelect: _go, critical: _report!.critical),
          );
    return Focus(
      focusNode: _focus,
      autofocus: true,
      onKeyEvent: _onKey,
      child: Scaffold(
        appBar: AppBar(title: Text(l.gameVs(g.white, g.black), overflow: TextOverflow.ellipsis)),
        body: LayoutBuilder(builder: (context, c) {
          final wide = c.maxWidth >= 900;
          if (wide) {
            final boardSize = (c.maxHeight - 72).clamp(240.0, c.maxWidth - 480);
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(children: [
                  Row(children: [_evalBar(boardSize), const SizedBox(width: 6), _board(boardSize)]),
                  SizedBox(width: boardSize + 28, child: _navBar(l)),
                ]),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    graph,
                    _moveCard(l),
                    Expanded(child: _tabs(l, scrollable: true)),
                  ]),
                ),
              ),
            ]);
          }
          final boardSize = c.maxWidth - 36;
          return ListView(padding: const EdgeInsets.all(8), children: [
            Row(children: [_evalBar(boardSize), const SizedBox(width: 6), _board(boardSize)]),
            _navBar(l),
            graph,
            _moveCard(l),
            _tabs(l, scrollable: false),
          ]);
        }),
      ),
    );
  }
}
