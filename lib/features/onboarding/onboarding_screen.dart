import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/settings/settings.dart';
import '../../l10n/gen/app_localizations.dart';

String levelName(AppLocalizations l, PlayerLevel v) => switch (v) {
  PlayerLevel.beginner => l.levelBeginner,
  PlayerLevel.novice => l.levelNovice,
  PlayerLevel.intermediate => l.levelIntermediate,
  PlayerLevel.advanced => l.levelAdvanced,
};

/// Primera ejecución: qué hace la app, idioma, nivel y cómo empezar.
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final s = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final t = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: ListView(padding: const EdgeInsets.all(24), children: [
              Center(child: Image.asset('assets/logo.png', width: 96, height: 96, semanticLabel: l.appTitle)),
              const SizedBox(height: 16),
              Text(l.onboardWelcome, style: t.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Text(l.onboardBody, style: t.bodyLarge, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              SegmentedButton<String?>(
                segments: const [
                  ButtonSegment(value: 'es', label: Text('Español')),
                  ButtonSegment(value: 'en', label: Text('English')),
                ],
                selected: {s.locale ?? Localizations.localeOf(context).languageCode},
                onSelectionChanged: (v) => notifier.update((s) => s.copyWith(locale: () => v.first)),
              ),
              const SizedBox(height: 24),
              Text(l.onboardLevel, style: t.titleMedium),
              RadioGroup<PlayerLevel>(
                groupValue: s.level,
                onChanged: (v) => notifier.update((s) => s.copyWith(level: v)),
                child: Column(children: [
                  for (final v in PlayerLevel.values)
                    RadioListTile<PlayerLevel>(value: v, title: Text(levelName(l, v))),
                ]),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(leading: const Icon(Icons.tips_and_updates_outlined), title: Text(l.onboardHowTo)),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () async {
                  await notifier.update((s) => s.copyWith(onboarded: true));
                  if (context.mounted) context.go('/analyze');
                },
                child: Text(l.onboardStart),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
