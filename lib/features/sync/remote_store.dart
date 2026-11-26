import 'package:dio/dio.dart';

import '../../core/network/http.dart';

typedef RemoteRow = Map<String, Object?>;

/// Almacén remoto. Las filas usan nombres de columna en snake_case.
/// `server_at` lo pone el servidor y sirve para descargar solo lo nuevo.
abstract interface class RemoteStore {
  Future<void> upsert(String table, List<RemoteRow> rows, {required bool merge});
  Future<List<RemoteRow>> since(String table, DateTime? serverAt);
}

/// Configuración opcional: --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
bool get syncConfigured => supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

/// Supabase por REST (PostgREST + GoTrue) sin SDK: menos dependencias.
class SupabaseStore implements RemoteStore {
  SupabaseStore(this._dio, this._token);
  final Dio _dio;
  final Future<String> Function() _token;

  Future<Options> _opts([Map<String, String> extra = const {}]) async => Options(headers: {
    'apikey': supabaseAnonKey,
    'Authorization': 'Bearer ${await _token()}',
    ...extra,
  });

  @override
  Future<void> upsert(String table, List<RemoteRow> rows, {required bool merge}) async {
    if (rows.isEmpty) return;
    final conflict = table == 'games' ? 'user_id,source,external_id' : 'id';
    final opts = await _opts({'Prefer': 'resolution=${merge ? 'merge' : 'ignore'}-duplicates,return=minimal'});
    await withRetry(() => _dio.post<void>('$supabaseUrl/rest/v1/$table', queryParameters: {'on_conflict': conflict}, data: rows, options: opts));
  }

  @override
  Future<List<RemoteRow>> since(String table, DateTime? serverAt) async {
    final opts = await _opts();
    final res = await withRetry(() => _dio.get<List<Object?>>(
      '$supabaseUrl/rest/v1/$table',
      queryParameters: {
        'select': '*',
        'order': 'server_at.asc',
        if (serverAt != null) 'server_at': 'gt.${serverAt.toUtc().toIso8601String()}',
      },
      options: opts,
    ));
    return [for (final r in res.data ?? const <Object?>[]) (r! as Map).cast<String, Object?>()];
  }
}

/// Sesión con código por email (GoTrue). Nunca se guarda contraseña.
class SupabaseAuth {
  SupabaseAuth(this._dio);
  final Dio _dio;
  Options get _opts => Options(headers: {'apikey': supabaseAnonKey});

  Future<void> sendCode(String email) => withRetry(() => _dio.post<void>('$supabaseUrl/auth/v1/otp', data: {'email': email, 'create_user': true}, options: _opts));

  /// Devuelve (accessToken, refreshToken).
  Future<(String, String)> verify(String email, String code) async {
    final res = await withRetry(() => _dio.post<Map<String, Object?>>('$supabaseUrl/auth/v1/verify', data: {'type': 'email', 'email': email, 'token': code}, options: _opts));
    return (res.data!['access_token']! as String, res.data!['refresh_token']! as String);
  }

  Future<(String, String)> refresh(String refreshToken) async {
    final res = await withRetry(() => _dio.post<Map<String, Object?>>('$supabaseUrl/auth/v1/token',
        queryParameters: {'grant_type': 'refresh_token'}, data: {'refresh_token': refreshToken}, options: _opts));
    return (res.data!['access_token']! as String, res.data!['refresh_token']! as String);
  }
}
