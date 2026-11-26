import 'engine_channel_stub.dart'
    if (dart.library.io) 'engine_channel_io.dart'
    if (dart.library.js_interop) 'engine_channel_web.dart'
    as impl;

/// Canal de texto UCI con un motor (proceso, FFI o Web Worker).
abstract interface class EngineChannel {
  Stream<String> get lines;
  void send(String command);
  Future<void> close();
}

/// Abre el motor adecuado para la plataforma actual.
Future<EngineChannel> openEngineChannel() => impl.openEngineChannel();

/// Hilos recomendados: la mitad de los núcleos (máx. 4) para cuidar la batería.
int defaultEngineThreads() => impl.defaultEngineThreads();
