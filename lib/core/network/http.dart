import 'package:dio/dio.dart';

/// Errores de red con significado para la UI.
sealed class NetError implements Exception {
  const NetError();
}

class NotFound extends NetError {
  const NotFound();
}

class RateLimited extends NetError {
  const RateLimited();
}

class NoConnection extends NetError {
  const NoConnection(this.detail);
  final Object detail;
  @override
  String toString() => 'NoConnection($detail)';
}

Dio buildDio() => Dio(BaseOptions(
  connectTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 60),
  // Identificador genérico: sin datos personales.
  headers: {'User-Agent': 'IraChess/1.0'},
));

/// Ejecuta [request] con reintentos y espera creciente ante fallos de red o
/// errores 5xx. 404 → [NotFound]; 429 → [RateLimited] (no se insiste: las
/// APIs públicas piden esperar un minuto).
Future<Response<T>> withRetry<T>(Future<Response<T>> Function() request, {int attempts = 3}) async {
  for (var i = 0;; i++) {
    try {
      return await request();
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 404) throw const NotFound();
      if (status == 429) throw const RateLimited();
      final transient = status == null || status >= 500;
      if (!transient || i == attempts - 1) throw NoConnection(e.message ?? e.type.name);
      await Future<void>.delayed(Duration(milliseconds: 800 * (1 << i)));
    }
  }
}
