import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/db/database.dart';
import '../../../core/network/http.dart';
import '../../../core/providers.dart';
import '../../../core/ui/widgets/common.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../data/puzzle_repository.dart';

final _packIndexProvider = FutureProvider.autoDispose((ref) => ref.watch(packServiceProvider).fetchIndex());
final _installedProvider = StreamProvider.autoDispose((ref) => ref.watch(puzzleRepositoryProvider).watchPacks());
final _baseCountProvider = FutureProvider.autoDispose((ref) async {
  final repo = ref.watch(puzzleRepositoryProvider);
  await repo.ensureBaseLoaded();
  return repo.countAll();
});

String formatBytes(int b) => b < 1024 * 1024 ? '${(b / 1024).toStringAsFixed(0)} KB' : '${(b / 1024 / 1024).toStringAsFixed(1)} MB';

class PacksScreen extends ConsumerStatefulWidget {
  const PacksScreen({super.key});

  @override
  ConsumerState<PacksScreen> createState() => _PacksScreenState();
}

class _PacksScreenState extends ConsumerState<PacksScreen> {
  final _busy = <String>{};

  Future<void> _download(PackInfo info) async {
    final l = AppLocalizations.of(context);
    setState(() => _busy.add(info.id));
    try {
      await ref.read(packServiceProvider).download(info);
    } on NetError catch (e) {
      if (mounted) showSnack(context, l.packError(e is RateLimited ? l.onlineRateLimited : l.onlineNetwork));
    } finally {
      if (mounted) setState(() => _busy.remove(info.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final index = ref.watch(_packIndexProvider);
    final installed = ref.watch(_installedProvider).value ?? const <PuzzlePack>[];
    final byId = {for (final p in installed) p.id: p};
    final used = installed.fold<int>(0, (s, p) => s + p.bytes);
    final remote = index.value ?? const <PackInfo>[];
    // Paquetes instalados que ya no están en el índice (o sin conexión) también se listan.
    final all = [
      ...remote,
      for (final p in installed)
        if (!remote.any((r) => r.id == p.id))
          PackInfo(id: p.id, theme: p.theme, min: p.ratingMin, max: p.ratingMax, count: p.count, bytes: p.bytes, version: p.version, file: ''),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(l.packsTitle)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Text(l.packsOfflineNote(ref.watch(_baseCountProvider).value ?? 0)),
            const SizedBox(height: 8),
            Text(l.packsUsed(formatBytes(used)), style: Theme.of(context).textTheme.titleSmall),
            if (index.isLoading) const Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator())),
            if (index.hasError)
              ErrorView(l.packsIndexError, onRetry: () => ref.invalidate(_packIndexProvider), retryLabel: l.retry),
            for (final p in all)
              Card(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                  title: Text(l.themeName(p.theme)),
                  subtitle: Text('${l.packCount(p.count, p.min, p.max)} · ${formatBytes(p.bytes)}'),
                  trailing: _busy.contains(p.id)
                      ? const SizedBox.square(dimension: 24, child: CircularProgressIndicator(strokeWidth: 2))
                      : byId.containsKey(p.id)
                          ? IconButton(
                              tooltip: l.delete,
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => ref.read(puzzleRepositoryProvider).deletePack(p.id),
                            )
                          : IconButton(
                              tooltip: l.packDownload,
                              icon: const Icon(Icons.download),
                              onPressed: p.file.isEmpty ? null : () => _download(p),
                            ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
