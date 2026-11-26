import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../l10n/gen/app_localizations.dart';

/// Barra inferior en móvil, NavigationRail en tableta y barra lateral
/// extendida en escritorio.
class AppShell extends StatelessWidget {
  const AppShell(this.shell, {super.key});
  final StatefulNavigationShell shell;

  static const compact = 600.0;
  static const expanded = 1000.0;

  void _go(int i) => shell.goBranch(i, initialLocation: i == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final items = [
      (Icons.insights_outlined, Icons.insights, l.navAnalyze),
      (Icons.extension_outlined, Icons.extension, l.navPuzzles),
      (Icons.visibility_outlined, Icons.visibility, l.navVision),
      (Icons.trending_up_outlined, Icons.trending_up, l.navProgress),
      (Icons.settings_outlined, Icons.settings, l.navSettings),
    ];
    final width = MediaQuery.sizeOf(context).width;
    if (width < compact) {
      return Scaffold(
        body: shell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: shell.currentIndex,
          onDestinationSelected: _go,
          destinations: [
            for (final (icon, selected, label) in items)
              NavigationDestination(icon: Icon(icon), selectedIcon: Icon(selected), label: label),
          ],
        ),
      );
    }
    return Scaffold(
      body: Row(children: [
        NavigationRail(
          extended: width >= expanded,
          selectedIndex: shell.currentIndex,
          onDestinationSelected: _go,
          labelType: width >= expanded ? NavigationRailLabelType.none : NavigationRailLabelType.all,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Image.asset('assets/logo.png', width: 40, height: 40, semanticLabel: l.appTitle),
          ),
          destinations: [
            for (final (icon, selected, label) in items)
              NavigationRailDestination(icon: Icon(icon), selectedIcon: Icon(selected), label: Text(label)),
          ],
        ),
        const VerticalDivider(width: 1),
        Expanded(child: shell),
      ]),
    );
  }
}
