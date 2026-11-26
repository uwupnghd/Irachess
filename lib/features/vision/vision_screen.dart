import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dartchess/dartchess.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/db/database.dart';
import '../../core/providers.dart';
import '../../core/settings/settings.dart';
import '../../core/ui/theme.dart';
import '../../core/ui/widgets/common.dart';
import '../../core/util/ids.dart';
import '../../l10n/gen/app_localizations.dart';
import 'vision_game.dart';

class VisionStats {
  const VisionStats(this.bestByMode, this.misses, this.sessions);
  final Map<String, int> bestByMode;
  final List<(String, int)> misses;
  final int sessions;
}

final visionStatsProvider = FutureProvider.autoDispose((ref) async {
  final db = ref.watch(databaseProvider);
  final rows = await db.select(db.visionSessions).get();
  final best = <String, int>{};
  for (final r in rows) {
    if (r.score > (best[r.mode] ?? 0)) best[r.mode] = r.score;
  }
  final misses = topMisses([
    for (final r in rows) [for (final m in jsonDecode(r.misses) as List<Object?>) (m! as List<Object?>).cast<String>()],
  ]);
  return VisionStats(best, misses, rows.length);
});

class VisionScreen extends ConsumerStatefulWidget {
  const VisionScreen({super.key});

  @override
  ConsumerState<VisionScreen> createState() => _VisionScreenState();
}

class _VisionScreenState extends ConsumerState<VisionScreen> {
  Side _side = Side.white;
  bool _coords = true;
  VisionMode _mode = VisionMode.time30;

  VisionGame? _game;
  final _watch = Stopwatch();
  Timer? _ticker;
  int _ticks = 0;

  // El cronómetro da precisión; los ticks garantizan el avance aunque el reloj
  // del sistema no cambie (pruebas con tiempo simulado).
  Duration get _elapsed => Duration(milliseconds: max(_watch.elapsedMilliseconds, _ticks * 100));
  bool _finished = false;
  int? _previousBest;
  (Square, bool)? _flash;

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _start() {
    final stats = ref.read(visionStatsProvider).value;
    setState(() {
      _game = VisionGame(_mode);
      _finished = false;
      _flash = null;
      _previousBest = stats?.bestByMode[_mode.name] ?? 0;
    });
    _watch
      ..reset()
      ..start();
    _ticks = 0;
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _ticks++;
      if (_game!.finished(_elapsed)) {
        _finish();
      } else {
        setState(() {});
      }
    });
  }

  Future<void> _finish() async {
    _ticker?.cancel();
    _watch.stop();
    final g = _game!;
    setState(() => _finished = true);
    final db = ref.read(databaseProvider);
    await db.into(db.visionSessions).insert(VisionSessionsCompanion.insert(
      id: uuidV4(),
      mode: _mode.name,
      side: _side.name,
      coords: _coords,
      score: g.score,
      errors: g.errors,
      durationMs: _elapsed.inMilliseconds,
      misses: jsonEncode([for (final (t, s) in g.misses) [t.name, s.name]]),
      startedAt: DateTime.now().subtract(_elapsed),
    ));
    ref.invalidate(visionStatsProvider);
  }

  void _tap(Square sq) {
    final g = _game;
    if (g == null || _finished) return;
    final ok = g.tap(sq);
    final s = ref.read(settingsProvider);
    if (s.haptics) ok ? HapticFeedback.selectionClick() : HapticFeedback.vibrate();
    setState(() => _flash = (sq, ok));
    Future<void>.delayed(const Duration(milliseconds: 250), () {
      if (mounted && _flash?.$1 == sq) setState(() => _flash = null);
    });
    if (g.finished(_elapsed)) _finish();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.visionTitle)),
      body: _game == null ? _setup(l) : _session(l),
    );
  }

  Widget _setup(AppLocalizations l) {
    final stats = ref.watch(visionStatsProvider).value;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Text(l.visionIntro, style: Theme.of(context).textTheme.bodyLarge),
          SectionTitle(l.visionSide),
          SegmentedButton<Side>(
            segments: [
              ButtonSegment(value: Side.white, label: Text(l.sideWhite)),
              ButtonSegment(value: Side.black, label: Text(l.sideBlack)),
            ],
            selected: {_side},
            onSelectionChanged: (s) => setState(() => _side = s.first),
          ),
          SectionTitle(l.visionMode),
          SegmentedButton<VisionMode>(
            segments: [
              ButtonSegment(value: VisionMode.time30, label: Text(l.visionMode30)),
              ButtonSegment(value: VisionMode.time60, label: Text(l.visionMode60)),
              ButtonSegment(value: VisionMode.hits20, label: Text(l.visionModeHits)),
            ],
            selected: {_mode},
            onSelectionChanged: (s) => setState(() => _mode = s.first),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l.visionCoords),
            value: _coords,
            onChanged: (v) => setState(() => _coords = v),
          ),
          if (stats != null) Text(l.visionBest(stats.bestByMode[_mode.name] ?? 0)),
          const SizedBox(height: 16),
          FilledButton.icon(onPressed: _start, icon: const Icon(Icons.play_arrow), label: Text(l.visionStart)),
          if (stats != null && stats.misses.isNotEmpty) ...[
            SectionTitle(l.visionMisses),
            Text(stats.misses.map((m) => '${m.$1} (${m.$2})').join(' · ')),
          ],
        ]),
      ),
    );
  }

  Widget _session(AppLocalizations l) {
    final g = _game!;
    final t = Theme.of(context).textTheme;
    final left = _mode.seconds == null ? null : (_mode.seconds! - _elapsed.inMilliseconds / 1000).clamp(0, 999);
    final header = Column(children: [
      Semantics(
        liveRegion: true,
        label: l.visionTapSquare(g.target.name),
        child: ExcludeSemantics(
          child: Text(
            _finished ? (g.score > (_previousBest ?? 0) ? l.visionNewRecord : l.visionScore(g.score)) : g.target.name,
            style: t.displayMedium!.copyWith(fontWeight: FontWeight.bold, color: brandIndigo),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Wrap(spacing: 16, alignment: WrapAlignment.center, children: [
        Text(l.visionScore(g.score), style: t.titleMedium),
        Text(l.visionErrors(g.errors), style: t.titleMedium),
        if (left != null)
          Text(l.visionTime(left.ceil()), style: t.titleMedium)
        else
          Text('${g.score}/${_mode.target}', style: t.titleMedium),
      ]),
      if (left != null) ...[
        const SizedBox(height: 8),
        LinearProgressIndicator(value: left / _mode.seconds!),
      ],
    ]);
    final results = !_finished
        ? const SizedBox.shrink()
        : Column(children: [
            const SizedBox(height: 12),
            Text(l.visionResultTime((_elapsed.inMilliseconds / 1000).toStringAsFixed(1)), style: t.titleMedium),
            Text(l.visionBest(g.score > (_previousBest ?? 0) ? g.score : _previousBest ?? 0)),
            Text(g.misses.isEmpty ? l.visionNoMisses : '${l.visionMisses}: ${g.misses.map((m) => m.$1.name).toSet().join(', ')}'),
            const SizedBox(height: 12),
            Wrap(spacing: 8, children: [
              FilledButton.icon(onPressed: _start, icon: const Icon(Icons.replay), label: Text(l.visionAgain)),
              OutlinedButton(onPressed: () => setState(() => _game = null), child: Text(l.close)),
            ]),
          ]);
    return LayoutBuilder(builder: (context, c) {
      final wide = c.maxWidth >= 840;
      final size = wide ? (c.maxHeight - 32).clamp(240.0, c.maxWidth - 360) : c.maxWidth - 16;
      final board = CoordinateBoard(
        size: size.toDouble(),
        orientation: _side,
        showCoordinates: _coords,
        flash: _flash,
        onTap: _tap,
      );
      if (wide) {
        return Row(children: [
          Padding(padding: const EdgeInsets.all(16), child: board),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [header, results]))),
        ]);
      }
      return ListView(padding: const EdgeInsets.all(8), children: [header, const SizedBox(height: 8), board, results]);
    });
  }
}

/// Tablero vacío de 64 casillas tocables (cada una con su nombre para
/// lectores de pantalla).
class CoordinateBoard extends ConsumerWidget {
  const CoordinateBoard({
    super.key,
    required this.size,
    required this.orientation,
    required this.showCoordinates,
    required this.onTap,
    this.flash,
  });

  final double size;
  final Side orientation;
  final bool showCoordinates;
  final ValueChanged<Square> onTap;
  final (Square, bool)? flash;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = boardThemes[ref.watch(settingsProvider).boardTheme] ?? boardThemes['slate']!;
    final cell = size / 8;
    return SizedBox.square(
      dimension: size,
      child: Column(children: [
        for (var row = 0; row < 8; row++)
          Row(children: [
            for (var col = 0; col < 8; col++) _square(row, col, cell, scheme.lightSquare, scheme.darkSquare),
          ]),
      ]),
    );
  }

  Widget _square(int row, int col, double cell, Color light, Color dark) {
    final file = orientation == Side.white ? col : 7 - col;
    final rank = orientation == Side.white ? 7 - row : row;
    final sq = Square(file | (rank << 3));
    final isLight = (file + rank).isOdd;
    var color = isLight ? light : dark;
    if (flash?.$1 == sq) color = flash!.$2 ? const Color(0xFF2E9E5B) : const Color(0xFFD43F3A);
    final label = TextStyle(fontSize: cell * 0.2, fontWeight: FontWeight.bold, color: isLight ? dark : light);
    return Semantics(
      button: true,
      label: sq.name,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => onTap(sq),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: cell,
          height: cell,
          color: color,
          child: !showCoordinates
              ? null
              : Stack(children: [
                  if (col == 0) Positioned(left: 3, top: 2, child: Text(sq.rank.name, style: label)),
                  if (row == 7) Positioned(right: 3, bottom: 1, child: Text(sq.file.name, style: label)),
                ]),
        ),
      ),
    );
  }
}
