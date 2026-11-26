import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/settings/settings.dart';
import 'remote_store.dart';
import 'sync_service.dart';

/// Email de la cuenta conectada (null si no hay sesión). El token de
/// refresco vive solo en memoria: nunca se escribe en disco, así que al
/// cerrar la app hay que volver a entrar con el código por email.
final accountProvider = AsyncNotifierProvider<AccountNotifier, String?>(AccountNotifier.new);

class AccountNotifier extends AsyncNotifier<String?> {
  String? _refresh;

  SupabaseAuth get _auth => SupabaseAuth(ref.read(dioProvider));

  @override
  Future<String?> build() async => null;

  Future<void> sendCode(String email) => _auth.sendCode(email);

  Future<void> verify(String email, String code) async {
    final (_, refresh) = await _auth.verify(email, code);
    _refresh = refresh;
    state = AsyncData(email);
  }

  Future<void> signOut() async {
    _refresh = null;
    state = const AsyncData(null);
  }

  /// Sincroniza ahora. Devuelve (enviados, recibidos).
  Future<(int, int)> sync() async {
    final saved = _refresh;
    if (saved == null) throw StateError('no session');
    final (access, refresh) = await _auth.refresh(saved);
    _refresh = refresh;
    final service = SyncService(
      ref.read(databaseProvider),
      SupabaseStore(ref.read(dioProvider), () async => access),
      ref.read(sharedPrefsProvider),
      ref.read(puzzleRepositoryProvider),
    );
    return service.sync();
  }
}
