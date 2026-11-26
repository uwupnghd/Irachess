import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

import 'engine_channel.dart';

/// Stockfish 19 lite mono-hilo (stockfish.js, GPL-3.0) en un Web Worker.
Future<EngineChannel> openEngineChannel() async => _WorkerChannel(web.Worker('engine/stockfish-19-lite-single.js'.toJS));

class _WorkerChannel implements EngineChannel {
  _WorkerChannel(this._worker) {
    _worker.onmessage = (web.MessageEvent e) {
      final data = e.data;
      if (data.isA<JSString>()) _lines.add((data as JSString).toDart);
    }.toJS;
  }

  final web.Worker _worker;
  final _lines = StreamController<String>.broadcast();

  @override
  Stream<String> get lines => _lines.stream;

  @override
  void send(String command) => _worker.postMessage(command.toJS);

  @override
  Future<void> close() async {
    _worker.terminate();
    await _lines.close();
  }
}
