import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart' show GlobalWidgetsLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../core/settings/settings.dart';
import '../core/ui/theme.dart';
import '../l10n/gen/app_localizations.dart';
import 'licenses.dart';
import 'router.dart';

class IraChessApp extends ConsumerStatefulWidget {
  const IraChessApp({super.key});

  @override
  ConsumerState<IraChessApp> createState() => _IraChessAppState();
}

class _IraChessAppState extends ConsumerState<IraChessApp> {
  @override
  void initState() {
    super.initState();
    registerThirdPartyLicenses();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return MaterialApp.router(
      onGenerateTitle: (c) => AppLocalizations.of(c).appTitle,
      debugShowCheckedModeBanner: kDebugMode,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: settings.themeMode,
      locale: settings.locale == null ? null : Locale(settings.locale!),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // Español por defecto si el idioma del sistema no está soportado.
      localeResolutionCallback: (locale, supported) =>
          supported.where((l) => l.languageCode == locale?.languageCode).firstOrNull ?? const Locale('es'),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
