import 'package:chessground/chessground.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/engine/uci_engine.dart';
import '../../core/network/http.dart';
import '../../core/providers.dart';
import '../../core/settings/settings.dart';
import '../../core/ui/theme.dart';
import '../../core/ui/widgets/common.dart';
import '../../l10n/gen/app_localizations.dart';
import '../onboarding/onboarding_screen.dart';
import '../sync/account.dart';
import '../sync/remote_store.dart';
import 'data_export.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final s = ref.watch(settingsProvider);
    final n = ref.read(settingsProvider.notifier);
    Future<void> set(Settings Function(Settings) f) => n.update(f);
    return Scaffold(
      appBar: AppBar(title: Text(l.settingsTitle)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(padding: const EdgeInsets.all(16), children: [
            SectionTitle(l.settingsLanguage),
            SegmentedButton<String?>(
              segments: [
                ButtonSegment(value: null, label: Text(l.languageSystem)),
                const ButtonSegment(value: 'es', label: Text('Español')),
                const ButtonSegment(value: 'en', label: Text('English')),
              ],
              selected: {s.locale},
              onSelectionChanged: (v) => set((s) => s.copyWith(locale: () => v.first)),
            ),
            SectionTitle(l.settingsTheme),
            SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(value: ThemeMode.system, label: Text(l.themeSystem)),
                ButtonSegment(value: ThemeMode.light, label: Text(l.themeLight)),
                ButtonSegment(value: ThemeMode.dark, label: Text(l.themeDark)),
              ],
              selected: {s.themeMode},
              onSelectionChanged: (v) => set((s) => s.copyWith(themeMode: v.first)),
            ),
            SectionTitle(l.settingsBoard),
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (final MapEntry(key: id, value: scheme) in boardThemes.entries)
                ChoiceChip(
                  avatar: _Swatch(scheme.lightSquare, scheme.darkSquare),
                  label: Text(l.boardThemeName(id)),
                  selected: s.boardTheme == id,
                  onSelected: (_) => set((s) => s.copyWith(boardTheme: id)),
                ),
            ]),
            SectionTitle(l.settingsPieces),
            DropdownButton<PieceSet>(
              value: s.pieceSet,
              isExpanded: true,
              items: [for (final p in allowedPieceSets) DropdownMenuItem(value: p, child: Text(p.label))],
              onChanged: (v) => set((s) => s.copyWith(pieceSet: v)),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l.settingsCoordinates),
              value: s.coordinates,
              onChanged: (v) => set((s) => s.copyWith(coordinates: v)),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l.settingsSound),
              value: s.sound,
              onChanged: (v) => set((s) => s.copyWith(sound: v)),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l.settingsHaptics),
              value: s.haptics,
              onChanged: (v) => set((s) => s.copyWith(haptics: v)),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l.settingsColorBlind),
              subtitle: Text(l.settingsColorBlindHint),
              value: s.colorBlind,
              onChanged: (v) => set((s) => s.copyWith(colorBlind: v)),
            ),
            SectionTitle(l.settingsEngine),
            SegmentedButton<EnginePreset>(
              segments: [
                ButtonSegment(value: EnginePreset.fast, label: Text(l.presetFast)),
                ButtonSegment(value: EnginePreset.normal, label: Text(l.presetNormal)),
                ButtonSegment(value: EnginePreset.deep, label: Text(l.presetDeep)),
              ],
              selected: {s.preset},
              onSelectionChanged: (v) => set((s) => s.copyWith(preset: v.first)),
            ),
            Padding(padding: const EdgeInsets.only(top: 4), child: Text(l.presetHint, style: Theme.of(context).textTheme.bodySmall)),
            SectionTitle('${l.settingsDailyGoal}: ${s.dailyGoal}'),
            Slider(
              value: s.dailyGoal.toDouble(),
              min: 1,
              max: 50,
              divisions: 49,
              label: '${s.dailyGoal}',
              onChanged: (v) => set((s) => s.copyWith(dailyGoal: v.round())),
            ),
            SectionTitle(l.settingsLevel),
            DropdownButton<PlayerLevel>(
              value: s.level,
              isExpanded: true,
              items: [for (final v in PlayerLevel.values) DropdownMenuItem(value: v, child: Text(levelName(l, v)))],
              onChanged: (v) => set((s) => s.copyWith(level: v)),
            ),
            SectionTitle(l.settingsUsernames),
            _UserField(label: 'Lichess', value: s.lichessUser, onSaved: (v) => set((s) => s.copyWith(lichessUser: v))),
            const SizedBox(height: 8),
            _UserField(label: 'Chess.com', value: s.chesscomUser, onSaved: (v) => set((s) => s.copyWith(chesscomUser: v))),
            SectionTitle(l.settingsAccount),
            const _AccountSection(),
            SectionTitle(l.settingsData),
            Wrap(spacing: 8, runSpacing: 8, children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.file_download_outlined),
                label: Text(l.exportData),
                onPressed: () async => exportText(
                  'irachess_export.json',
                  await exportAllJson(ref.read(databaseProvider), ref.read(settingsProvider)),
                  mime: 'application/json',
                ),
              ),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                icon: const Icon(Icons.delete_forever_outlined),
                label: Text(l.deleteAll),
                onPressed: () async {
                  final ok = await showDialog<bool>(
                    context: context,
                    builder: (c) => AlertDialog(
                      content: Text(l.deleteAllConfirm),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(c, false), child: Text(l.cancel)),
                        FilledButton(onPressed: () => Navigator.pop(c, true), child: Text(l.delete)),
                      ],
                    ),
                  );
                  if (!(ok ?? false)) return;
                  await ref.read(databaseProvider).wipe();
                  final prefs = ref.read(sharedPrefsProvider);
                  for (final k in prefs.getKeys().where((k) => k.startsWith('sync.'))) {
                    await prefs.remove(k);
                  }
                  if (context.mounted) showSnack(context, l.deletedAll);
                },
              ),
            ]),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.info_outline),
              title: Text(l.settingsAbout),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go('/settings/about'),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.light, this.dark);
  final Color light;
  final Color dark;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: 18,
    child: Column(children: [
      Expanded(child: Row(children: [Expanded(child: ColoredBox(color: light)), Expanded(child: ColoredBox(color: dark))])),
      Expanded(child: Row(children: [Expanded(child: ColoredBox(color: dark)), Expanded(child: ColoredBox(color: light))])),
    ]),
  );
}

class _UserField extends StatefulWidget {
  const _UserField({required this.label, required this.value, required this.onSaved});
  final String label;
  final String value;
  final ValueChanged<String> onSaved;

  @override
  State<_UserField> createState() => _UserFieldState();
}

class _UserFieldState extends State<_UserField> {
  late final _c = TextEditingController(text: widget.value);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    controller: _c,
    autocorrect: false,
    decoration: InputDecoration(labelText: widget.label, border: const OutlineInputBorder()),
    onChanged: (v) => widget.onSaved(v.trim()),
  );
}

class _AccountSection extends ConsumerStatefulWidget {
  const _AccountSection();

  @override
  ConsumerState<_AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends ConsumerState<_AccountSection> {
  final _email = TextEditingController();
  final _code = TextEditingController();
  bool _codeSent = false;
  bool _busy = false;
  String? _message;

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _run(Future<String?> Function() action) async {
    final l = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final msg = await action();
      if (mounted) setState(() => _message = msg);
    } on NetError catch (e) {
      if (mounted) setState(() => _message = e is RateLimited ? l.onlineRateLimited : l.onlineNetwork);
    } catch (e) {
      if (mounted) setState(() => _message = l.errorGeneric('$e'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    if (!syncConfigured) return Text(l.accountNotConfigured);
    final account = ref.watch(accountProvider);
    final notifier = ref.read(accountProvider.notifier);
    final email = account.value;
    final children = <Widget>[];
    if (email != null) {
      children.addAll([
        Text(l.accountSignedIn(email)),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: [
          FilledButton.tonalIcon(
            onPressed: _busy
                ? null
                : () => _run(() async {
                    final (up, down) = await notifier.sync();
                    return l.accountSynced(up, down);
                  }),
            icon: const Icon(Icons.sync),
            label: Text(l.accountSyncNow),
          ),
          TextButton(onPressed: _busy ? null : notifier.signOut, child: Text(l.accountSignOut)),
        ]),
      ]);
    } else {
      children.addAll([
        TextField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(labelText: l.accountEmail, border: const OutlineInputBorder()),
        ),
        const SizedBox(height: 8),
        if (_codeSent) ...[
          TextField(
            controller: _code,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: l.accountCode, border: const OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
        ],
        FilledButton.tonal(
          onPressed: _busy
              ? null
              : () => _run(() async {
                  if (!_codeSent) {
                    await notifier.sendCode(_email.text.trim());
                    setState(() => _codeSent = true);
                  } else {
                    await notifier.verify(_email.text.trim(), _code.text.trim());
                  }
                  return null;
                }),
          child: Text(_codeSent ? l.accountVerify : l.accountSendCode),
        ),
      ]);
    }
    if (_message != null) children.add(Padding(padding: const EdgeInsets.only(top: 8), child: Text(_message!)));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }
}
