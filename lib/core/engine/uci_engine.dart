import 'dart:async';

import 'engine_channel.dart';

/// Una línea del motor. La puntuación es desde el punto de vista del bando
/// que mueve en la posición analizada.
class EngineLine {
  const EngineLine({required this.pv, this.cp, this.mate, required this.depth});

  final List<String> pv;
  final int? cp;
  final int? mate;
  final int depth;

  String get uci => pv.first;

  Map<String, Object?> toJson() => {'pv': pv, 'cp': cp, 'mate': mate, 'd': depth};

  factory EngineLine.fromJson(Map<String, Object?> j) => EngineLine(
    pv: (j['pv']! as List<Object?>).cast<String>(),
    cp: j['cp'] as int?,
    mate: j['mate'] as int?,
    depth: j['d'] as int? ?? 0,
  );
}

/// Preset de análisis: el motor se detiene en lo primero que ocurra.
enum EnginePreset {
  fast(depth: 12, maxTime: Duration(milliseconds: 250)),
  normal(depth: 16, maxTime: Duration(milliseconds: 600)),
  deep(depth: 20, maxTime: Duration(seconds: 2));

  const EnginePreset({required this.depth, required this.maxTime});
  final int depth;
  final Duration maxTime;
}

/// Parsea una línea `info ... multipv N score cp X ... pv ...`.
(int multipv, EngineLine line)? parseInfoLine(String line) {
  if (!line.startsWith('info ') || !line.contains(' pv ')) return null;
  final t = line.split(' ');
  int? depth, cp, mate;
  var multipv = 1;
  for (var i = 1; i < t.length - 1; i++) {
    switch (t[i]) {
      case 'depth':
        depth = int.tryParse(t[i + 1]);
      case 'multipv':
        multipv = int.tryParse(t[i + 1]) ?? 1;
      case 'score':
        if (t[i + 1] == 'cp') cp = int.tryParse(t[i + 2]);
        if (t[i + 1] == 'mate') mate = int.tryParse(t[i + 2]);
      case 'pv':
        if (depth == null || (cp == null && mate == null)) return null;
        // Los límites (lowerbound/upperbound) se ignoran: son provisionales.
        if (t.contains('lowerbound') || t.contains('upperbound')) return null;
        return (multipv, EngineLine(pv: t.sublist(i + 1), cp: cp, mate: mate, depth: depth));
    }
  }
  return null;
}

/// Cliente UCI sobre cualquier canal (móvil, escritorio o web).
/// Las peticiones se serializan: el motor solo analiza una posición a la vez.
class UciEngine {
  UciEngine(this._channel) {
    _sub = _channel.lines.listen(_onLine);
  }

  final EngineChannel _channel;
  late final StreamSubscription<String> _sub;
  Completer<void>? _ready;
  Completer<List<EngineLine>>? _search;
  final Map<int, EngineLine> _lines = {};
  Future<void> _queue = Future.value();
  int _multiPv = 0;

  static Future<UciEngine> start({int threads = 2, int hashMb = 64}) async {
    final engine = UciEngine(await openEngineChannel());
    engine._channel.send('uci');
    engine._channel.send('setoption name Threads value $threads');
    engine._channel.send('setoption name Hash value $hashMb');
    await engine._isReady();
    return engine;
  }

  Future<void> _isReady() {
    _ready = Completer<void>();
    _channel.send('isready');
    return _ready!.future.timeout(const Duration(seconds: 20));
  }

  void _onLine(String line) {
    if (line == 'readyok') {
      _ready?.complete();
      _ready = null;
    } else if (line.startsWith('bestmove')) {
      final lines = _lines.values.toList()..sort((a, b) => _cmp(b, a));
      _search?.complete(lines);
      _search = null;
    } else {
      final info = parseInfoLine(line);
      if (info != null && _search != null) _lines[info.$1] = info.$2;
    }
  }

  // Ordena por puntuación (mates primero), para ser robusto ante MultiPV.
  static int _cmp(EngineLine a, EngineLine b) {
    double v(EngineLine l) => l.mate != null ? (l.mate! > 0 ? 100000.0 - l.mate! : -100000.0 - l.mate!) : l.cp!.toDouble();
    return v(a).compareTo(v(b));
  }

  /// Analiza [fen] y devuelve hasta [multiPv] líneas, la mejor primero.
  Future<List<EngineLine>> analyse(String fen, {required EnginePreset preset, int multiPv = 3}) {
    final result = _queue.then((_) async {
      if (_multiPv != multiPv) {
        _channel.send('setoption name MultiPV value $multiPv');
        _multiPv = multiPv;
      }
      await _isReady();
      _lines.clear();
      _search = Completer<List<EngineLine>>();
      _channel.send('position fen $fen');
      _channel.send('go depth ${preset.depth} movetime ${preset.maxTime.inMilliseconds}');
      return _search!.future;
    });
    _queue = result.then((_) {}, onError: (_) {});
    return result;
  }

  /// Busca la mejor jugada con nivel limitado (para jugar contra el motor).
  Future<String?> bestMove(String fen, {required int skill, required Duration time}) {
    final result = _queue.then((_) async {
      _channel.send('setoption name Skill Level value $skill');
      if (_multiPv != 1) {
        _channel.send('setoption name MultiPV value 1');
        _multiPv = 1;
      }
      await _isReady();
      _lines.clear();
      _search = Completer<List<EngineLine>>();
      _channel.send('position fen $fen');
      _channel.send('go movetime ${time.inMilliseconds}');
      final lines = await _search!.future;
      _channel.send('setoption name Skill Level value 20');
      return lines.isEmpty ? null : lines.first.uci;
    });
    _queue = result.then((_) {}, onError: (_) {});
    return result;
  }

  /// Detiene la búsqueda en curso (devuelve lo encontrado hasta ahora).
  void stop() {
    if (_search != null) _channel.send('stop');
  }

  Future<void> dispose() async {
    stop();
    await _sub.cancel();
    await _channel.close();
  }
}
