import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/network/http.dart';
import '../../../core/providers.dart';
import '../../../core/settings/settings.dart';
import '../../../core/ui/widgets/common.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../data/online_importer.dart';

class OnlineImportScreen extends ConsumerStatefulWidget {
  const OnlineImportScreen({super.key});

  @override
  ConsumerState<OnlineImportScreen> createState() => _OnlineImportScreenState();
}

class _OnlineImportScreenState extends ConsumerState<OnlineImportScreen> {
  String _service = 'lichess';
  late final _user = TextEditingController(text: ref.read(settingsProvider).lichessUser);
  int _max = 20;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _user.dispose();
    super.dispose();
  }

  void _switch(String service) {
    final s = ref.read(settingsProvider);
    setState(() {
      _service = service;
      _user.text = service == 'lichess' ? s.lichessUser : s.chesscomUser;
      _error = null;
    });
  }

  Future<void> _import() async {
    final l = AppLocalizations.of(context);
    final user = _user.text.trim();
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final dio = ref.read(dioProvider);
      final games = _service == 'lichess'
          ? await LichessImporter(dio).fetch(user, max: _max)
          : await ChessComImporter(dio).fetch(user, max: _max);
      final repo = ref.read(gamesRepositoryProvider);
      var added = 0;
      for (final g in games) {
        final (_, isNew) = await repo.insert(g.game, source: _service, externalId: g.externalId, userSide: g.userSide);
        if (isNew) added++;
      }
      await ref.read(settingsProvider.notifier).update(
        (s) => _service == 'lichess' ? s.copyWith(lichessUser: user) : s.copyWith(chesscomUser: user),
      );
      if (!mounted) return;
      showSnack(context, l.importedCount(added));
      context.go('/analyze');
    } on NotFound {
      setState(() => _error = l.onlineNotFound(user));
    } on RateLimited {
      setState(() => _error = l.onlineRateLimited);
    } on NetError {
      setState(() => _error = l.onlineNetwork);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.onlineTitle)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: ListView(padding: const EdgeInsets.all(16), children: [
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'lichess', label: Text('Lichess')),
                ButtonSegment(value: 'chesscom', label: Text('Chess.com')),
              ],
              selected: {_service},
              onSelectionChanged: (s) => _switch(s.first),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _user,
              autocorrect: false,
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => _busy ? null : _import(),
              decoration: InputDecoration(
                labelText: l.onlineUsername,
                border: const OutlineInputBorder(),
                errorText: _error,
                errorMaxLines: 3,
              ),
            ),
            SectionTitle(l.onlineMax),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 10, label: Text('10')),
                ButtonSegment(value: 20, label: Text('20')),
                ButtonSegment(value: 50, label: Text('50')),
              ],
              selected: {_max},
              onSelectionChanged: (s) => setState(() => _max = s.first),
            ),
            const SizedBox(height: 16),
            Text(l.onlinePrivacy, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _busy ? null : _import,
              icon: _busy
                  ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.cloud_download),
              label: Text(l.onlineImport),
            ),
          ]),
        ),
      ),
    );
  }
}
