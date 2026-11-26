import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/providers.dart';
import '../../core/settings/settings.dart';
import 'remote_store.dart';
import 'sync_service.dart';

final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

/// Email de la cuenta conectada (null si no hay sesión). El token de
/// refresco se guarda en el almacenamiento seguro del sistema.
final accountProvider = AsyncNotifierProvider<AccountNotifier, String?>(AccountNotifier.new);

class AccountNotifier extends AsyncNotifier<String?> {
  static const _kRefresh = 'irachess.refresh', _kEmail = 'irachess.email';

  FlutterSecureStorage get _store => ref.read(secureStorageProvider);
  SupabaseAuth get _auth => SupabaseAuth(ref.read(dioProvider));

  @override
  Future<String?> build() async {
    if (!syncConfigured) return null;
    return await _store.read(key: _kRefresh) == null ? null : _store.read(key: _kEmail);
  }

  Future<void> sendCode(String email) => _auth.sendCode(email);

  Future<void> verify(String email, String code) async {
    final (_, refresh) = await _auth.verify(email, code);
    await _store.write(key: _kRefresh, value: refresh);
    await _store.write(key: _kEmail, value: email);
    state = AsyncData(email);
  }

  Future<void> signOut() async {
    await _store.delete(key: _kRefresh);
    await _store.delete(key: _kEmail);
    state = const AsyncData(null);
  }

  /// Sincroniza ahora. Devuelve (enviados, recibidos).
  Future<(int, int)> sync() async {
    final saved = await _store.read(key: _kRefresh);
    if (saved == null) throw StateError('no session');
    final (access, refresh) = await _auth.refresh(saved);
    await _store.write(key: _kRefresh, value: refresh);
    final service = SyncService(
      ref.read(databaseProvider),
      SupabaseStore(ref.read(dioProvider), () async => access),
      ref.read(sharedPrefsProvider),
      ref.read(puzzleRepositoryProvider),
    );
    return service.sync();
  }
}
