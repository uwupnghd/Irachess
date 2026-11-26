import '../../../core/chess/notation.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../domain/game_report.dart';

/// Traduce un fragmento de explicación o recomendación al idioma actual.
String renderPart(AppLocalizations l, ExplPart p) {
  // Las jugadas se muestran en la notación del idioma (C, A, T, D, R en español).
  String a(String k) => const {'reply', 'best', 'line'}.contains(k) ? localizeSan(p.args[k] ?? '', l.localeName) : p.args[k] ?? '';
  int n() => int.tryParse(a('n')) ?? 0;
  return switch (p.key) {
    'forced' => l.explForced,
    'book' => a('opening').isEmpty ? l.explBookPlain : l.explBook(a('opening')),
    'brilliant' => l.explBrilliant,
    'great' => l.explGreat,
    'best' => l.explBest,
    'goodAlt' => l.explGoodAlt(a('best')),
    'miss' => l.explMiss,
    'allowsMate' => l.explAllowsMate(n(), a('line')),
    'hanging' => l.explHanging(a('reply'), a('piece'), a('square')),
    'fork' => l.explFork(a('reply'), a('piece1'), a('piece2')),
    'pin' => l.explPin(a('reply'), a('piece'), a('square'), a('behind')),
    'discovered' => l.explDiscovered(a('reply'), a('piece')),
    'losesMaterial' => l.explLosesMaterial(n(), a('line')),
    'evalDrop' => l.explEvalDrop(a('before'), a('after')),
    'missedMate' => l.explMissedMate(n(), a('best')),
    'bestWins' => l.explBestWins(a('best'), a('piece')),
    'bestFork' => l.explBestFork(a('best'), a('piece1'), a('piece2')),
    'bestPin' => l.explBestPin(a('best'), a('piece')),
    'bestDiscovered' => l.explBestDiscovered(a('best'), a('piece')),
    'bestCheck' => l.explBestCheck(a('best')),
    'bestCastle' => l.explBestCastle(a('best')),
    'bestGeneric' => l.explBestGeneric(a('best')),
    'recHanging' => l.recHanging,
    'recFork' => l.recFork,
    'recPin' => l.recPin,
    'recMate' => l.recMate,
    'recOpening' => a('opening').isEmpty ? l.recOpeningPlain : l.recOpening(a('opening')),
    'recEndgame' => l.recEndgame,
    'recMiss' => l.recMiss,
    'recKeepGoing' => l.recKeepGoing,
    _ => '',
  };
}

String renderExplanation(AppLocalizations l, List<ExplPart> parts) => parts.map((p) => renderPart(l, p)).join(' ');
