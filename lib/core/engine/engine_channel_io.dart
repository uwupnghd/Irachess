import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:multistockfish/multistockfish.dart';
import 'package:path/path.dart' as p;

import 'engine_channel.dart';

int defaultEngineThreads() => (Platform.numberOfProcessors ~/ 2).clamp(1, 4);

Future<EngineChannel> openEngineChannel() async {
  if (Platform.isAndroid || Platform.isIOS) {
    return _MobileChannel(await Stockfish.create());
  }
  final exe = findDesktopEngine();
  if (exe == null) {
    throw StateError('No se encontró Stockfish. Coloca el ejecutable junto a la app o define IRACHESS_STOCKFISH.');
  }
  return _ProcessChannel(await Process.start(exe, const []));
}

/// Busca Stockfish en escritorio: variable de entorno, junto al ejecutable
/// (carpeta `engine/`) o en el PATH.
String? findDesktopEngine() {
  final name = Platform.isWindows ? 'stockfish.exe' : 'stockfish';
  final exeDir = p.dirname(Platform.resolvedExecutable);
  final candidates = [
    Platform.environment['IRACHESS_STOCKFISH'],
    p.join(exeDir, 'engine', name),
    p.join(exeDir, name),
    if (Platform.isMacOS) p.join(exeDir, '..', 'Resources', name),
    ...?Platform.environment['PATH']?.split(Platform.isWindows ? ';' : ':').map((d) => p.join(d, name)),
    '/usr/games/stockfish',
  ];
  for (final c in candidates) {
    if (c != null && File(c).existsSync()) return c;
  }
  return null;
}

class _MobileChannel implements EngineChannel {
  _MobileChannel(this._sf);
  final Stockfish _sf;

  @override
  Stream<String> get lines => _sf.stdout;

  @override
  void send(String command) => _sf.stdin = command;

  @override
  Future<void> close() => _sf.dispose();
}

class _ProcessChannel implements EngineChannel {
  _ProcessChannel(this._process)
    : lines = _process.stdout.transform(utf8.decoder).transform(const LineSplitter()).asBroadcastStream();
  final Process _process;

  @override
  final Stream<String> lines;

  @override
  void send(String command) => _process.stdin.writeln(command);

  @override
  Future<void> close() async {
    _process.stdin.writeln('quit');
    await _process.exitCode.timeout(const Duration(seconds: 2), onTimeout: () {
      _process.kill();
      return -1;
    });
  }
}
