// Worker de Drift para la web. Compilar con:
// dart compile js -O4 tool/drift_worker.dart -o web/drift_worker.js
import 'package:drift/wasm.dart';

void main() => WasmDatabase.workerMainForOpen();
