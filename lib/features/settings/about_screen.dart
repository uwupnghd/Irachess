import 'package:material_ui/material_ui.dart';

import '../../core/ui/widgets/common.dart';
import '../../l10n/gen/app_localizations.dart';

const sourceUrl = 'https://github.com/uwupnghd/irachess';
const appVersion = '1.0.0';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(l.settingsAbout)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Center(child: Image.asset('assets/logo.png', width: 80, height: 80, semanticLabel: l.appTitle)),
            const SizedBox(height: 8),
            Text('${l.appTitle} $appVersion', style: t.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text(l.aboutBody),
            SectionTitle(l.sourceCode),
            const SelectableText(sourceUrl),
            SectionTitle(l.privacy),
            Text(l.privacyBody),
            const SizedBox(height: 24),
            FilledButton.tonalIcon(
              icon: const Icon(Icons.gavel),
              label: Text(l.licenses),
              onPressed: () => showLicensePage(
                context: context,
                applicationName: l.appTitle,
                applicationVersion: appVersion,
                applicationIcon: Image.asset('assets/logo.png', width: 48, height: 48),
                applicationLegalese: 'GPL-3.0 · $sourceUrl',
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
