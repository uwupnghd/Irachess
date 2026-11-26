import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'IraChess'**
  String get appTitle;

  /// No description provided for @navAnalyze.
  ///
  /// In es, this message translates to:
  /// **'Analizar'**
  String get navAnalyze;

  /// No description provided for @navPuzzles.
  ///
  /// In es, this message translates to:
  /// **'Problemas'**
  String get navPuzzles;

  /// No description provided for @navVision.
  ///
  /// In es, this message translates to:
  /// **'Visión'**
  String get navVision;

  /// No description provided for @navProgress.
  ///
  /// In es, this message translates to:
  /// **'Progreso'**
  String get navProgress;

  /// No description provided for @navSettings.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get navSettings;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get close;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Borrar'**
  String get delete;

  /// No description provided for @ok.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get ok;

  /// No description provided for @next.
  ///
  /// In es, this message translates to:
  /// **'Siguiente'**
  String get next;

  /// No description provided for @share.
  ///
  /// In es, this message translates to:
  /// **'Compartir'**
  String get share;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando…'**
  String get loading;

  /// No description provided for @errorGeneric.
  ///
  /// In es, this message translates to:
  /// **'Algo salió mal: {error}'**
  String errorGeneric(String error);

  /// No description provided for @gamesTitle.
  ///
  /// In es, this message translates to:
  /// **'Mis partidas'**
  String get gamesTitle;

  /// No description provided for @gamesEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay partidas'**
  String get gamesEmptyTitle;

  /// No description provided for @gamesEmptyBody.
  ///
  /// In es, this message translates to:
  /// **'Pega un PGN, importa tus partidas o juega contra el motor para empezar a aprender de ellas.'**
  String get gamesEmptyBody;

  /// No description provided for @actionPastePgn.
  ///
  /// In es, this message translates to:
  /// **'Pegar PGN'**
  String get actionPastePgn;

  /// No description provided for @actionOpenFile.
  ///
  /// In es, this message translates to:
  /// **'Abrir archivo PGN'**
  String get actionOpenFile;

  /// No description provided for @actionImportOnline.
  ///
  /// In es, this message translates to:
  /// **'Importar de Lichess / Chess.com'**
  String get actionImportOnline;

  /// No description provided for @actionPlayEngine.
  ///
  /// In es, this message translates to:
  /// **'Jugar contra el motor'**
  String get actionPlayEngine;

  /// No description provided for @gameVs.
  ///
  /// In es, this message translates to:
  /// **'{white} vs {black}'**
  String gameVs(String white, String black);

  /// No description provided for @notAnalyzed.
  ///
  /// In es, this message translates to:
  /// **'Sin analizar'**
  String get notAnalyzed;

  /// No description provided for @accuracyShort.
  ///
  /// In es, this message translates to:
  /// **'Precisión {value} %'**
  String accuracyShort(String value);

  /// No description provided for @deleteGameConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar esta partida y su análisis?'**
  String get deleteGameConfirm;

  /// No description provided for @importTitle.
  ///
  /// In es, this message translates to:
  /// **'Importar PGN'**
  String get importTitle;

  /// No description provided for @importHint.
  ///
  /// In es, this message translates to:
  /// **'Pega aquí el PGN de tu partida…'**
  String get importHint;

  /// No description provided for @importButton.
  ///
  /// In es, this message translates to:
  /// **'Importar'**
  String get importButton;

  /// No description provided for @importWhichSide.
  ///
  /// In es, this message translates to:
  /// **'¿Con qué color jugabas?'**
  String get importWhichSide;

  /// No description provided for @sideWhite.
  ///
  /// In es, this message translates to:
  /// **'Blancas'**
  String get sideWhite;

  /// No description provided for @sideBlack.
  ///
  /// In es, this message translates to:
  /// **'Negras'**
  String get sideBlack;

  /// No description provided for @sideUnknown.
  ///
  /// In es, this message translates to:
  /// **'No lo sé'**
  String get sideUnknown;

  /// No description provided for @importErrorEmpty.
  ///
  /// In es, this message translates to:
  /// **'El PGN está vacío.'**
  String get importErrorEmpty;

  /// No description provided for @importErrorTooLarge.
  ///
  /// In es, this message translates to:
  /// **'El PGN es demasiado grande (máximo 2 MB).'**
  String get importErrorTooLarge;

  /// No description provided for @importErrorNoMoves.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron jugadas en el PGN.'**
  String get importErrorNoMoves;

  /// No description provided for @importErrorTooManyGames.
  ///
  /// In es, this message translates to:
  /// **'Demasiadas partidas en un solo archivo (máximo 500).'**
  String get importErrorTooManyGames;

  /// No description provided for @importErrorIllegal.
  ///
  /// In es, this message translates to:
  /// **'Jugada ilegal «{san}» en la partida {game}, jugada {move}.'**
  String importErrorIllegal(String san, int game, int move);

  /// No description provided for @importErrorBadFen.
  ///
  /// In es, this message translates to:
  /// **'La posición inicial (FEN) no es válida o es de una variante no soportada.'**
  String get importErrorBadFen;

  /// No description provided for @importErrorTooLong.
  ///
  /// In es, this message translates to:
  /// **'La partida es demasiado larga (máximo 300 jugadas).'**
  String get importErrorTooLong;

  /// No description provided for @importedCount.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{No había partidas nuevas} =1{1 partida importada} other{{count} partidas importadas}}'**
  String importedCount(int count);

  /// No description provided for @analyzeButton.
  ///
  /// In es, this message translates to:
  /// **'Analizar partida'**
  String get analyzeButton;

  /// No description provided for @analyzing.
  ///
  /// In es, this message translates to:
  /// **'Analizando… {done}/{total}'**
  String analyzing(int done, int total);

  /// No description provided for @engineUnavailable.
  ///
  /// In es, this message translates to:
  /// **'No se pudo iniciar el motor: {error}'**
  String engineUnavailable(String error);

  /// No description provided for @tabMoves.
  ///
  /// In es, this message translates to:
  /// **'Jugadas'**
  String get tabMoves;

  /// No description provided for @tabSummary.
  ///
  /// In es, this message translates to:
  /// **'Resumen'**
  String get tabSummary;

  /// No description provided for @bestMoveWas.
  ///
  /// In es, this message translates to:
  /// **'Mejor: {san}'**
  String bestMoveWas(String san);

  /// No description provided for @alternatives.
  ///
  /// In es, this message translates to:
  /// **'Alternativas del motor'**
  String get alternatives;

  /// No description provided for @tryIt.
  ///
  /// In es, this message translates to:
  /// **'Pruébalo tú'**
  String get tryIt;

  /// No description provided for @tryItPrompt.
  ///
  /// In es, this message translates to:
  /// **'Busca la mejor jugada para {side}'**
  String tryItPrompt(String side);

  /// No description provided for @tryItCorrect.
  ///
  /// In es, this message translates to:
  /// **'¡Correcto! {san} era la mejor.'**
  String tryItCorrect(String san);

  /// No description provided for @tryItWrong.
  ///
  /// In es, this message translates to:
  /// **'{san} no es la mejor. Inténtalo otra vez.'**
  String tryItWrong(String san);

  /// No description provided for @tryItReveal.
  ///
  /// In es, this message translates to:
  /// **'Ver solución'**
  String get tryItReveal;

  /// No description provided for @startPosition.
  ///
  /// In es, this message translates to:
  /// **'Posición inicial'**
  String get startPosition;

  /// No description provided for @flipBoard.
  ///
  /// In es, this message translates to:
  /// **'Girar tablero'**
  String get flipBoard;

  /// No description provided for @firstMove.
  ///
  /// In es, this message translates to:
  /// **'Primera jugada'**
  String get firstMove;

  /// No description provided for @prevMove.
  ///
  /// In es, this message translates to:
  /// **'Jugada anterior'**
  String get prevMove;

  /// No description provided for @nextMove.
  ///
  /// In es, this message translates to:
  /// **'Jugada siguiente'**
  String get nextMove;

  /// No description provided for @lastMove.
  ///
  /// In es, this message translates to:
  /// **'Última jugada'**
  String get lastMove;

  /// No description provided for @evalGraph.
  ///
  /// In es, this message translates to:
  /// **'Ventaja'**
  String get evalGraph;

  /// No description provided for @moveOf.
  ///
  /// In es, this message translates to:
  /// **'{number}. {san}'**
  String moveOf(int number, String san);

  /// No description provided for @moveOfBlack.
  ///
  /// In es, this message translates to:
  /// **'{number}… {san}'**
  String moveOfBlack(int number, String san);

  /// No description provided for @clsBrilliant.
  ///
  /// In es, this message translates to:
  /// **'Brillante'**
  String get clsBrilliant;

  /// No description provided for @clsGreat.
  ///
  /// In es, this message translates to:
  /// **'Genial'**
  String get clsGreat;

  /// No description provided for @clsBook.
  ///
  /// In es, this message translates to:
  /// **'Teoría'**
  String get clsBook;

  /// No description provided for @clsBest.
  ///
  /// In es, this message translates to:
  /// **'Mejor'**
  String get clsBest;

  /// No description provided for @clsExcellent.
  ///
  /// In es, this message translates to:
  /// **'Excelente'**
  String get clsExcellent;

  /// No description provided for @clsGood.
  ///
  /// In es, this message translates to:
  /// **'Buena'**
  String get clsGood;

  /// No description provided for @clsInaccuracy.
  ///
  /// In es, this message translates to:
  /// **'Imprecisión'**
  String get clsInaccuracy;

  /// No description provided for @clsMiss.
  ///
  /// In es, this message translates to:
  /// **'Omisión'**
  String get clsMiss;

  /// No description provided for @clsMistake.
  ///
  /// In es, this message translates to:
  /// **'Error'**
  String get clsMistake;

  /// No description provided for @clsBlunder.
  ///
  /// In es, this message translates to:
  /// **'Error grave'**
  String get clsBlunder;

  /// No description provided for @clsForced.
  ///
  /// In es, this message translates to:
  /// **'Forzada'**
  String get clsForced;

  /// No description provided for @pieceName.
  ///
  /// In es, this message translates to:
  /// **'{piece, select, pawn{peón} knight{caballo} bishop{alfil} rook{torre} queen{dama} king{rey} other{pieza}}'**
  String pieceName(String piece);

  /// No description provided for @explForced.
  ///
  /// In es, this message translates to:
  /// **'Era la única jugada legal.'**
  String get explForced;

  /// No description provided for @explBook.
  ///
  /// In es, this message translates to:
  /// **'Jugada de teoría ({opening}).'**
  String explBook(String opening);

  /// No description provided for @explBookPlain.
  ///
  /// In es, this message translates to:
  /// **'Jugada de teoría.'**
  String get explBookPlain;

  /// No description provided for @explBrilliant.
  ///
  /// In es, this message translates to:
  /// **'¡Brillante! Entregas material a cambio de una ventaja mayor.'**
  String get explBrilliant;

  /// No description provided for @explGreat.
  ///
  /// In es, this message translates to:
  /// **'La única buena jugada en esta posición. ¡Bien visto!'**
  String get explGreat;

  /// No description provided for @explBest.
  ///
  /// In es, this message translates to:
  /// **'La mejor jugada según el motor.'**
  String get explBest;

  /// No description provided for @explGoodAlt.
  ///
  /// In es, this message translates to:
  /// **'Buena jugada. El motor prefería {best}.'**
  String explGoodAlt(String best);

  /// No description provided for @explMiss.
  ///
  /// In es, this message translates to:
  /// **'Tu rival acababa de cometer un error y no lo aprovechaste.'**
  String get explMiss;

  /// No description provided for @explAllowsMate.
  ///
  /// In es, this message translates to:
  /// **'Esto permite mate en {n}: {line}.'**
  String explAllowsMate(int n, String line);

  /// No description provided for @explHanging.
  ///
  /// In es, this message translates to:
  /// **'{reply} gana tu {piece, select, pawn{peón} knight{caballo} bishop{alfil} rook{torre} queen{dama} king{rey} other{pieza}} de {square}, que había quedado sin defensa.'**
  String explHanging(String reply, String piece, String square);

  /// No description provided for @explFork.
  ///
  /// In es, this message translates to:
  /// **'Tras tu jugada, {reply} es una horquilla: ataca a la vez tu {piece1, select, pawn{peón} knight{caballo} bishop{alfil} rook{torre} queen{dama} king{rey} other{pieza}} y tu {piece2, select, pawn{peón} knight{caballo} bishop{alfil} rook{torre} queen{dama} king{rey} other{pieza}}.'**
  String explFork(String reply, String piece1, String piece2);

  /// No description provided for @explPin.
  ///
  /// In es, this message translates to:
  /// **'{reply} clava tu {piece, select, pawn{peón} knight{caballo} bishop{alfil} rook{torre} queen{dama} king{rey} other{pieza}} de {square} contra tu {behind, select, pawn{peón} knight{caballo} bishop{alfil} rook{torre} queen{dama} king{rey} other{pieza}}.'**
  String explPin(String reply, String piece, String square, String behind);

  /// No description provided for @explDiscovered.
  ///
  /// In es, this message translates to:
  /// **'{reply} descubre un ataque contra tu {piece, select, pawn{peón} knight{caballo} bishop{alfil} rook{torre} queen{dama} king{rey} other{pieza}}.'**
  String explDiscovered(String reply, String piece);

  /// No description provided for @explLosesMaterial.
  ///
  /// In es, this message translates to:
  /// **'Pierdes {n} puntos de material tras {line}.'**
  String explLosesMaterial(int n, String line);

  /// No description provided for @explEvalDrop.
  ///
  /// In es, this message translates to:
  /// **'Tu evaluación pasa de {before} a {after}.'**
  String explEvalDrop(String before, String after);

  /// No description provided for @explMissedMate.
  ///
  /// In es, this message translates to:
  /// **'Tenías mate en {n} empezando con {best}.'**
  String explMissedMate(int n, String best);

  /// No description provided for @explBestWins.
  ///
  /// In es, this message translates to:
  /// **'Era mejor {best}: ganabas {piece, select, pawn{un peón} knight{un caballo} bishop{un alfil} rook{una torre} queen{la dama} king{el rey} other{material}}.'**
  String explBestWins(String best, String piece);

  /// No description provided for @explBestFork.
  ///
  /// In es, this message translates to:
  /// **'Era mejor {best}: una horquilla que ataca {piece1, select, pawn{el peón} knight{el caballo} bishop{el alfil} rook{la torre} queen{la dama} king{el rey} other{la pieza}} y {piece2, select, pawn{el peón} knight{el caballo} bishop{el alfil} rook{la torre} queen{la dama} king{el rey} other{la pieza}} del rival.'**
  String explBestFork(String best, String piece1, String piece2);

  /// No description provided for @explBestPin.
  ///
  /// In es, this message translates to:
  /// **'Era mejor {best}, que clava {piece, select, pawn{el peón} knight{el caballo} bishop{el alfil} rook{la torre} queen{la dama} king{el rey} other{la pieza}} rival.'**
  String explBestPin(String best, String piece);

  /// No description provided for @explBestDiscovered.
  ///
  /// In es, this message translates to:
  /// **'Era mejor {best}, con un ataque descubierto contra {piece, select, pawn{el peón} knight{el caballo} bishop{el alfil} rook{la torre} queen{la dama} king{el rey} other{la pieza}} rival.'**
  String explBestDiscovered(String best, String piece);

  /// No description provided for @explBestCheck.
  ///
  /// In es, this message translates to:
  /// **'Era mejor {best}: un jaque que mantiene la iniciativa.'**
  String explBestCheck(String best);

  /// No description provided for @explBestCastle.
  ///
  /// In es, this message translates to:
  /// **'Era mejor {best}: poner el rey a salvo enrocando.'**
  String explBestCastle(String best);

  /// No description provided for @explBestGeneric.
  ///
  /// In es, this message translates to:
  /// **'Era mejor {best}.'**
  String explBestGeneric(String best);

  /// No description provided for @recHanging.
  ///
  /// In es, this message translates to:
  /// **'Antes de cada jugada, comprueba qué piezas quedan sin defensa. Practica problemas de «pieza colgada».'**
  String get recHanging;

  /// No description provided for @recFork.
  ///
  /// In es, this message translates to:
  /// **'Practica problemas de horquillas: aparecieron en tus errores.'**
  String get recFork;

  /// No description provided for @recPin.
  ///
  /// In es, this message translates to:
  /// **'Repasa clavadas y ataques descubiertos con problemas de esos temas.'**
  String get recPin;

  /// No description provided for @recMate.
  ///
  /// In es, this message translates to:
  /// **'Entrena patrones de mate (mate en 1 y en 2): hubo mates que se te escaparon o que permitiste.'**
  String get recMate;

  /// No description provided for @recOpening.
  ///
  /// In es, this message translates to:
  /// **'Repasa la apertura {opening}: varios errores llegaron pronto.'**
  String recOpening(String opening);

  /// No description provided for @recOpeningPlain.
  ///
  /// In es, this message translates to:
  /// **'Repasa tus aperturas: varios errores llegaron pronto.'**
  String get recOpeningPlain;

  /// No description provided for @recEndgame.
  ///
  /// In es, this message translates to:
  /// **'Practica finales: cometiste errores cuando quedaban pocas piezas.'**
  String get recEndgame;

  /// No description provided for @recMiss.
  ///
  /// In es, this message translates to:
  /// **'Cuando tu rival se equivoque, busca jaques, capturas y amenazas para castigarlo.'**
  String get recMiss;

  /// No description provided for @recKeepGoing.
  ///
  /// In es, this message translates to:
  /// **'¡Buena partida! Sigue analizando partidas para descubrir tus patrones.'**
  String get recKeepGoing;

  /// No description provided for @summaryAccuracy.
  ///
  /// In es, this message translates to:
  /// **'Precisión'**
  String get summaryAccuracy;

  /// No description provided for @summaryOpening.
  ///
  /// In es, this message translates to:
  /// **'Apertura'**
  String get summaryOpening;

  /// No description provided for @summaryLeftBook.
  ///
  /// In es, this message translates to:
  /// **'Saliste de la teoría en la jugada {move} ({san}). Jugadas de libro: {book}.'**
  String summaryLeftBook(int move, String san, String book);

  /// No description provided for @summaryOpponentLeftBook.
  ///
  /// In es, this message translates to:
  /// **'Tu rival salió de la teoría en la jugada {move} ({san}).'**
  String summaryOpponentLeftBook(int move, String san);

  /// No description provided for @summaryInBook.
  ///
  /// In es, this message translates to:
  /// **'Toda la partida siguió la teoría.'**
  String get summaryInBook;

  /// No description provided for @summaryNoOpening.
  ///
  /// In es, this message translates to:
  /// **'Apertura sin nombre o posición inicial no estándar.'**
  String get summaryNoOpening;

  /// No description provided for @summaryPhases.
  ///
  /// In es, this message translates to:
  /// **'Rendimiento por fase'**
  String get summaryPhases;

  /// No description provided for @phaseOpening.
  ///
  /// In es, this message translates to:
  /// **'Apertura'**
  String get phaseOpening;

  /// No description provided for @phaseMiddlegame.
  ///
  /// In es, this message translates to:
  /// **'Medio juego'**
  String get phaseMiddlegame;

  /// No description provided for @phaseEndgame.
  ///
  /// In es, this message translates to:
  /// **'Final'**
  String get phaseEndgame;

  /// No description provided for @summaryWorstPhase.
  ///
  /// In es, this message translates to:
  /// **'Donde más fallaste: {phase}'**
  String summaryWorstPhase(String phase);

  /// No description provided for @summaryPhaseLine.
  ///
  /// In es, this message translates to:
  /// **'{moves} jugadas · precisión {acc} % · {errors} errores'**
  String summaryPhaseLine(int moves, String acc, int errors);

  /// No description provided for @summaryCritical.
  ///
  /// In es, this message translates to:
  /// **'Momentos críticos'**
  String get summaryCritical;

  /// No description provided for @summaryRecommendations.
  ///
  /// In es, this message translates to:
  /// **'Qué practicar'**
  String get summaryRecommendations;

  /// No description provided for @summaryCounts.
  ///
  /// In es, this message translates to:
  /// **'Clasificación de jugadas'**
  String get summaryCounts;

  /// No description provided for @tableNumber.
  ///
  /// In es, this message translates to:
  /// **'N.º'**
  String get tableNumber;

  /// No description provided for @tableEval.
  ///
  /// In es, this message translates to:
  /// **'Eval.'**
  String get tableEval;

  /// No description provided for @tableBest.
  ///
  /// In es, this message translates to:
  /// **'Mejor'**
  String get tableBest;

  /// No description provided for @tableTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo'**
  String get tableTime;

  /// No description provided for @filterAll.
  ///
  /// In es, this message translates to:
  /// **'Todas'**
  String get filterAll;

  /// No description provided for @filterMyErrors.
  ///
  /// In es, this message translates to:
  /// **'Mis errores'**
  String get filterMyErrors;

  /// No description provided for @filterBlunders.
  ///
  /// In es, this message translates to:
  /// **'Errores graves'**
  String get filterBlunders;

  /// No description provided for @exportPgn.
  ///
  /// In es, this message translates to:
  /// **'Exportar PGN anotado'**
  String get exportPgn;

  /// No description provided for @puzzlesTitle.
  ///
  /// In es, this message translates to:
  /// **'Problemas'**
  String get puzzlesTitle;

  /// No description provided for @puzzleRating.
  ///
  /// In es, this message translates to:
  /// **'Rating {rating}'**
  String puzzleRating(int rating);

  /// No description provided for @puzzleStreak.
  ///
  /// In es, this message translates to:
  /// **'Racha: {n}'**
  String puzzleStreak(int n);

  /// No description provided for @puzzleStart.
  ///
  /// In es, this message translates to:
  /// **'Empezar'**
  String get puzzleStart;

  /// No description provided for @puzzleThemes.
  ///
  /// In es, this message translates to:
  /// **'Temas'**
  String get puzzleThemes;

  /// No description provided for @themeName.
  ///
  /// In es, this message translates to:
  /// **'{theme, select, mateIn1{Mate en 1} mateIn2{Mate en 2} mateIn3{Mate en 3} fork{Horquilla} pin{Clavada} skewer{Enfilada} discoveredAttack{Ataque descubierto} hangingPiece{Pieza colgada} sacrifice{Sacrificio} backRankMate{Mate del pasillo} trappedPiece{Pieza atrapada} doubleCheck{Jaque doble} endgame{Finales} promotion{Coronación} mix{Mezcla} own{Mis errores} other{Otro}}'**
  String themeName(String theme);

  /// No description provided for @puzzleMyErrorsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Analiza partidas para generar problemas con tus propios errores.'**
  String get puzzleMyErrorsEmpty;

  /// No description provided for @puzzleYourTurn.
  ///
  /// In es, this message translates to:
  /// **'Juegan {side}: encuentra la mejor jugada'**
  String puzzleYourTurn(String side);

  /// No description provided for @puzzleCorrect.
  ///
  /// In es, this message translates to:
  /// **'¡Correcto! Sigue.'**
  String get puzzleCorrect;

  /// No description provided for @puzzleWrong.
  ///
  /// In es, this message translates to:
  /// **'No es la jugada. Prueba otra vez.'**
  String get puzzleWrong;

  /// No description provided for @puzzleSolved.
  ///
  /// In es, this message translates to:
  /// **'¡Resuelto!'**
  String get puzzleSolved;

  /// No description provided for @puzzleFailed.
  ///
  /// In es, this message translates to:
  /// **'No resuelto. Mira la solución y sigue practicando.'**
  String get puzzleFailed;

  /// No description provided for @puzzleHint.
  ///
  /// In es, this message translates to:
  /// **'Pista'**
  String get puzzleHint;

  /// No description provided for @puzzleHintText.
  ///
  /// In es, this message translates to:
  /// **'Mueve {piece, select, pawn{el peón} knight{el caballo} bishop{el alfil} rook{la torre} queen{la dama} king{el rey} other{la pieza}} de {square}.'**
  String puzzleHintText(String piece, String square);

  /// No description provided for @puzzleSolution.
  ///
  /// In es, this message translates to:
  /// **'Solución'**
  String get puzzleSolution;

  /// No description provided for @puzzleNoMore.
  ///
  /// In es, this message translates to:
  /// **'No hay más problemas con estos filtros. Descarga paquetes o cambia de tema.'**
  String get puzzleNoMore;

  /// No description provided for @puzzleFromGame.
  ///
  /// In es, this message translates to:
  /// **'De tu partida contra {opponent}'**
  String puzzleFromGame(String opponent);

  /// No description provided for @puzzleExplainOwn.
  ///
  /// In es, this message translates to:
  /// **'En la partida jugaste {played}. La mejor era {best}.'**
  String puzzleExplainOwn(String played, String best);

  /// No description provided for @puzzleRatingChange.
  ///
  /// In es, this message translates to:
  /// **'Rating: {rating} ({delta})'**
  String puzzleRatingChange(int rating, String delta);

  /// No description provided for @packsTitle.
  ///
  /// In es, this message translates to:
  /// **'Paquetes sin conexión'**
  String get packsTitle;

  /// No description provided for @packsUsed.
  ///
  /// In es, this message translates to:
  /// **'Espacio usado: {size}'**
  String packsUsed(String size);

  /// No description provided for @packDownload.
  ///
  /// In es, this message translates to:
  /// **'Descargar'**
  String get packDownload;

  /// No description provided for @packDownloaded.
  ///
  /// In es, this message translates to:
  /// **'Descargado'**
  String get packDownloaded;

  /// No description provided for @packCount.
  ///
  /// In es, this message translates to:
  /// **'{count} problemas · {min}–{max}'**
  String packCount(int count, int min, int max);

  /// No description provided for @packError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo descargar: {error}'**
  String packError(String error);

  /// No description provided for @packsOfflineNote.
  ///
  /// In es, this message translates to:
  /// **'Los problemas descargados funcionan en modo avión. Ya incluyes {count} problemas de base.'**
  String packsOfflineNote(int count);

  /// No description provided for @packsIndexError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo obtener la lista de paquetes. Comprueba tu conexión.'**
  String get packsIndexError;

  /// No description provided for @visionTitle.
  ///
  /// In es, this message translates to:
  /// **'Visión'**
  String get visionTitle;

  /// No description provided for @visionIntro.
  ///
  /// In es, this message translates to:
  /// **'Aparece el nombre de una casilla: tócala lo más rápido posible.'**
  String get visionIntro;

  /// No description provided for @visionSide.
  ///
  /// In es, this message translates to:
  /// **'Ver el tablero desde'**
  String get visionSide;

  /// No description provided for @visionCoords.
  ///
  /// In es, this message translates to:
  /// **'Mostrar coordenadas'**
  String get visionCoords;

  /// No description provided for @visionMode.
  ///
  /// In es, this message translates to:
  /// **'Sesión'**
  String get visionMode;

  /// No description provided for @visionMode30.
  ///
  /// In es, this message translates to:
  /// **'30 s'**
  String get visionMode30;

  /// No description provided for @visionMode60.
  ///
  /// In es, this message translates to:
  /// **'60 s'**
  String get visionMode60;

  /// No description provided for @visionModeHits.
  ///
  /// In es, this message translates to:
  /// **'20 aciertos'**
  String get visionModeHits;

  /// No description provided for @visionStart.
  ///
  /// In es, this message translates to:
  /// **'Empezar'**
  String get visionStart;

  /// No description provided for @visionScore.
  ///
  /// In es, this message translates to:
  /// **'Aciertos: {n}'**
  String visionScore(int n);

  /// No description provided for @visionErrors.
  ///
  /// In es, this message translates to:
  /// **'Fallos: {n}'**
  String visionErrors(int n);

  /// No description provided for @visionTime.
  ///
  /// In es, this message translates to:
  /// **'{seconds} s'**
  String visionTime(int seconds);

  /// No description provided for @visionBest.
  ///
  /// In es, this message translates to:
  /// **'Récord: {n}'**
  String visionBest(int n);

  /// No description provided for @visionNewRecord.
  ///
  /// In es, this message translates to:
  /// **'¡Nuevo récord!'**
  String get visionNewRecord;

  /// No description provided for @visionMisses.
  ///
  /// In es, this message translates to:
  /// **'Casillas que más fallas'**
  String get visionMisses;

  /// No description provided for @visionAgain.
  ///
  /// In es, this message translates to:
  /// **'Otra vez'**
  String get visionAgain;

  /// No description provided for @visionTapSquare.
  ///
  /// In es, this message translates to:
  /// **'Toca la casilla {square}'**
  String visionTapSquare(String square);

  /// No description provided for @visionResultTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo: {time} s'**
  String visionResultTime(String time);

  /// No description provided for @visionNoMisses.
  ///
  /// In es, this message translates to:
  /// **'¡Sin fallos!'**
  String get visionNoMisses;

  /// No description provided for @progressTitle.
  ///
  /// In es, this message translates to:
  /// **'Progreso'**
  String get progressTitle;

  /// No description provided for @progressAccuracy.
  ///
  /// In es, this message translates to:
  /// **'Tu precisión por partida'**
  String get progressAccuracy;

  /// No description provided for @progressPuzzleRating.
  ///
  /// In es, this message translates to:
  /// **'Rating de problemas'**
  String get progressPuzzleRating;

  /// No description provided for @progressOpenings.
  ///
  /// In es, this message translates to:
  /// **'Tus aperturas'**
  String get progressOpenings;

  /// No description provided for @progressErrorTypes.
  ///
  /// In es, this message translates to:
  /// **'Tipos de error más frecuentes'**
  String get progressErrorTypes;

  /// No description provided for @errTactical.
  ///
  /// In es, this message translates to:
  /// **'Tácticos'**
  String get errTactical;

  /// No description provided for @errOpening.
  ///
  /// In es, this message translates to:
  /// **'De apertura'**
  String get errOpening;

  /// No description provided for @errEndgame.
  ///
  /// In es, this message translates to:
  /// **'De finales'**
  String get errEndgame;

  /// No description provided for @errOther.
  ///
  /// In es, this message translates to:
  /// **'Otros'**
  String get errOther;

  /// No description provided for @progressStreak.
  ///
  /// In es, this message translates to:
  /// **'{n, plural, =1{Racha diaria: 1 día} other{Racha diaria: {n} días}}'**
  String progressStreak(int n);

  /// No description provided for @progressDailyGoal.
  ///
  /// In es, this message translates to:
  /// **'Objetivo de hoy: {done}/{goal} problemas'**
  String progressDailyGoal(int done, int goal);

  /// No description provided for @progressEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay datos. Analiza partidas y resuelve problemas.'**
  String get progressEmpty;

  /// No description provided for @progressVision.
  ///
  /// In es, this message translates to:
  /// **'Visión: récord {best} · {sessions} sesiones'**
  String progressVision(String best, int sessions);

  /// No description provided for @openingStats.
  ///
  /// In es, this message translates to:
  /// **'{games} partidas · {win} % V · {draw} % T · {loss} % D'**
  String openingStats(int games, int win, int draw, int loss);

  /// No description provided for @openingAcc.
  ///
  /// In es, this message translates to:
  /// **'precisión media {acc} %'**
  String openingAcc(String acc);

  /// No description provided for @onlineTitle.
  ///
  /// In es, this message translates to:
  /// **'Importar partidas'**
  String get onlineTitle;

  /// No description provided for @onlineUsername.
  ///
  /// In es, this message translates to:
  /// **'Nombre de usuario'**
  String get onlineUsername;

  /// No description provided for @onlineMax.
  ///
  /// In es, this message translates to:
  /// **'Cuántas partidas recientes'**
  String get onlineMax;

  /// No description provided for @onlineImport.
  ///
  /// In es, this message translates to:
  /// **'Importar'**
  String get onlineImport;

  /// No description provided for @onlineNotFound.
  ///
  /// In es, this message translates to:
  /// **'No existe el usuario «{user}».'**
  String onlineNotFound(String user);

  /// No description provided for @onlineRateLimited.
  ///
  /// In es, this message translates to:
  /// **'Demasiadas peticiones. Espera un minuto y vuelve a intentarlo.'**
  String get onlineRateLimited;

  /// No description provided for @onlineNetwork.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión o el servidor no responde.'**
  String get onlineNetwork;

  /// No description provided for @onlinePrivacy.
  ///
  /// In es, this message translates to:
  /// **'Solo se leen datos públicos. IraChess nunca te pedirá tu contraseña.'**
  String get onlinePrivacy;

  /// No description provided for @onlineProgress.
  ///
  /// In es, this message translates to:
  /// **'Descargando… {n} partidas'**
  String onlineProgress(int n);

  /// No description provided for @playTitle.
  ///
  /// In es, this message translates to:
  /// **'Jugar contra el motor'**
  String get playTitle;

  /// No description provided for @playLevel.
  ///
  /// In es, this message translates to:
  /// **'Nivel {level}'**
  String playLevel(int level);

  /// No description provided for @playColor.
  ///
  /// In es, this message translates to:
  /// **'Tu color'**
  String get playColor;

  /// No description provided for @playRandom.
  ///
  /// In es, this message translates to:
  /// **'Al azar'**
  String get playRandom;

  /// No description provided for @playStart.
  ///
  /// In es, this message translates to:
  /// **'Empezar partida'**
  String get playStart;

  /// No description provided for @playResign.
  ///
  /// In es, this message translates to:
  /// **'Rendirse'**
  String get playResign;

  /// No description provided for @playAnalyze.
  ///
  /// In es, this message translates to:
  /// **'Analizar partida'**
  String get playAnalyze;

  /// No description provided for @playYouWin.
  ///
  /// In es, this message translates to:
  /// **'¡Ganaste!'**
  String get playYouWin;

  /// No description provided for @playYouLose.
  ///
  /// In es, this message translates to:
  /// **'Perdiste'**
  String get playYouLose;

  /// No description provided for @playDraw.
  ///
  /// In es, this message translates to:
  /// **'Tablas'**
  String get playDraw;

  /// No description provided for @playThinking.
  ///
  /// In es, this message translates to:
  /// **'El motor piensa…'**
  String get playThinking;

  /// No description provided for @playYourMove.
  ///
  /// In es, this message translates to:
  /// **'Tu turno'**
  String get playYourMove;

  /// No description provided for @resultCheckmate.
  ///
  /// In es, this message translates to:
  /// **'Jaque mate'**
  String get resultCheckmate;

  /// No description provided for @resultStalemate.
  ///
  /// In es, this message translates to:
  /// **'Tablas por ahogado'**
  String get resultStalemate;

  /// No description provided for @resultRepetition.
  ///
  /// In es, this message translates to:
  /// **'Tablas por triple repetición'**
  String get resultRepetition;

  /// No description provided for @resultFiftyMoves.
  ///
  /// In es, this message translates to:
  /// **'Tablas por la regla de los 50 movimientos'**
  String get resultFiftyMoves;

  /// No description provided for @resultMaterial.
  ///
  /// In es, this message translates to:
  /// **'Tablas por material insuficiente'**
  String get resultMaterial;

  /// No description provided for @resultResigned.
  ///
  /// In es, this message translates to:
  /// **'Abandono'**
  String get resultResigned;

  /// No description provided for @engineName.
  ///
  /// In es, this message translates to:
  /// **'IraChess (motor)'**
  String get engineName;

  /// No description provided for @you.
  ///
  /// In es, this message translates to:
  /// **'Tú'**
  String get you;

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get settingsLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In es, this message translates to:
  /// **'Del sistema'**
  String get languageSystem;

  /// No description provided for @settingsTheme.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get settingsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In es, this message translates to:
  /// **'Del sistema'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get themeDark;

  /// No description provided for @settingsBoard.
  ///
  /// In es, this message translates to:
  /// **'Tablero'**
  String get settingsBoard;

  /// No description provided for @settingsPieces.
  ///
  /// In es, this message translates to:
  /// **'Piezas'**
  String get settingsPieces;

  /// No description provided for @settingsCoordinates.
  ///
  /// In es, this message translates to:
  /// **'Mostrar coordenadas en el tablero'**
  String get settingsCoordinates;

  /// No description provided for @settingsSound.
  ///
  /// In es, this message translates to:
  /// **'Sonidos de movimiento'**
  String get settingsSound;

  /// No description provided for @settingsHaptics.
  ///
  /// In es, this message translates to:
  /// **'Vibración'**
  String get settingsHaptics;

  /// No description provided for @settingsColorBlind.
  ///
  /// In es, this message translates to:
  /// **'Modo daltónico'**
  String get settingsColorBlind;

  /// No description provided for @settingsColorBlindHint.
  ///
  /// In es, this message translates to:
  /// **'Usa colores distinguibles para todas las clasificaciones.'**
  String get settingsColorBlindHint;

  /// No description provided for @settingsEngine.
  ///
  /// In es, this message translates to:
  /// **'Profundidad de análisis'**
  String get settingsEngine;

  /// No description provided for @presetFast.
  ///
  /// In es, this message translates to:
  /// **'Rápido'**
  String get presetFast;

  /// No description provided for @presetNormal.
  ///
  /// In es, this message translates to:
  /// **'Normal'**
  String get presetNormal;

  /// No description provided for @presetDeep.
  ///
  /// In es, this message translates to:
  /// **'Profundo'**
  String get presetDeep;

  /// No description provided for @presetHint.
  ///
  /// In es, this message translates to:
  /// **'Más profundo = más preciso, pero más lento y gasta más batería.'**
  String get presetHint;

  /// No description provided for @settingsDailyGoal.
  ///
  /// In es, this message translates to:
  /// **'Objetivo diario de problemas'**
  String get settingsDailyGoal;

  /// No description provided for @settingsUsernames.
  ///
  /// In es, this message translates to:
  /// **'Tus usuarios'**
  String get settingsUsernames;

  /// No description provided for @settingsLevel.
  ///
  /// In es, this message translates to:
  /// **'Tu nivel'**
  String get settingsLevel;

  /// No description provided for @settingsData.
  ///
  /// In es, this message translates to:
  /// **'Tus datos'**
  String get settingsData;

  /// No description provided for @exportData.
  ///
  /// In es, this message translates to:
  /// **'Exportar todo (JSON)'**
  String get exportData;

  /// No description provided for @deleteAll.
  ///
  /// In es, this message translates to:
  /// **'Borrar todos mis datos'**
  String get deleteAll;

  /// No description provided for @deleteAllConfirm.
  ///
  /// In es, this message translates to:
  /// **'Se borrarán todas tus partidas, análisis y progreso de este dispositivo. No se puede deshacer.'**
  String get deleteAllConfirm;

  /// No description provided for @deletedAll.
  ///
  /// In es, this message translates to:
  /// **'Datos borrados'**
  String get deletedAll;

  /// No description provided for @settingsAccount.
  ///
  /// In es, this message translates to:
  /// **'Cuenta y sincronización (opcional)'**
  String get settingsAccount;

  /// No description provided for @accountNotConfigured.
  ///
  /// In es, this message translates to:
  /// **'La sincronización no está configurada en esta compilación. Todo se guarda solo en este dispositivo.'**
  String get accountNotConfigured;

  /// No description provided for @accountEmail.
  ///
  /// In es, this message translates to:
  /// **'Email'**
  String get accountEmail;

  /// No description provided for @accountSendCode.
  ///
  /// In es, this message translates to:
  /// **'Enviar código'**
  String get accountSendCode;

  /// No description provided for @accountCode.
  ///
  /// In es, this message translates to:
  /// **'Código recibido'**
  String get accountCode;

  /// No description provided for @accountVerify.
  ///
  /// In es, this message translates to:
  /// **'Verificar'**
  String get accountVerify;

  /// No description provided for @accountSignedIn.
  ///
  /// In es, this message translates to:
  /// **'Conectado como {email}'**
  String accountSignedIn(String email);

  /// No description provided for @accountSignOut.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get accountSignOut;

  /// No description provided for @accountSyncNow.
  ///
  /// In es, this message translates to:
  /// **'Sincronizar ahora'**
  String get accountSyncNow;

  /// No description provided for @accountSynced.
  ///
  /// In es, this message translates to:
  /// **'Sincronizado: {up} enviados, {down} recibidos'**
  String accountSynced(int up, int down);

  /// No description provided for @settingsAbout.
  ///
  /// In es, this message translates to:
  /// **'Acerca de IraChess'**
  String get settingsAbout;

  /// No description provided for @aboutBody.
  ///
  /// In es, this message translates to:
  /// **'IraChess es software libre bajo la licencia GPL-3.0. Usa Stockfish (GPL-3.0), dartchess y chessground de Lichess (GPL-3.0), el libro de aperturas y los problemas de Lichess (CC0). Este programa se ofrece SIN NINGUNA GARANTÍA.'**
  String get aboutBody;

  /// No description provided for @sourceCode.
  ///
  /// In es, this message translates to:
  /// **'Código fuente'**
  String get sourceCode;

  /// No description provided for @licenses.
  ///
  /// In es, this message translates to:
  /// **'Licencias de terceros'**
  String get licenses;

  /// No description provided for @privacy.
  ///
  /// In es, this message translates to:
  /// **'Privacidad'**
  String get privacy;

  /// No description provided for @privacyBody.
  ///
  /// In es, this message translates to:
  /// **'IraChess guarda tus datos solo en este dispositivo. Solo se conecta a internet para importar partidas públicas de Lichess o Chess.com, descargar paquetes de problemas y, si activas una cuenta, sincronizar tu progreso. No hay anuncios ni analíticas. Puedes exportar o borrar todo en cualquier momento.'**
  String get privacyBody;

  /// No description provided for @onboardWelcome.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido a IraChess'**
  String get onboardWelcome;

  /// No description provided for @onboardBody.
  ///
  /// In es, this message translates to:
  /// **'Aprende de tus propias partidas: te explicamos cada error en lenguaje sencillo y qué jugada era mejor. También tienes problemas sin conexión y un entrenador de visión del tablero.'**
  String get onboardBody;

  /// No description provided for @onboardLevel.
  ///
  /// In es, this message translates to:
  /// **'¿Cuál es tu nivel?'**
  String get onboardLevel;

  /// No description provided for @levelBeginner.
  ///
  /// In es, this message translates to:
  /// **'Empezando (menos de 800)'**
  String get levelBeginner;

  /// No description provided for @levelNovice.
  ///
  /// In es, this message translates to:
  /// **'Aficionado (800–1200)'**
  String get levelNovice;

  /// No description provided for @levelIntermediate.
  ///
  /// In es, this message translates to:
  /// **'Intermedio (1200–1600)'**
  String get levelIntermediate;

  /// No description provided for @levelAdvanced.
  ///
  /// In es, this message translates to:
  /// **'Avanzado (1600 o más)'**
  String get levelAdvanced;

  /// No description provided for @onboardStart.
  ///
  /// In es, this message translates to:
  /// **'Empezar'**
  String get onboardStart;

  /// No description provided for @onboardHowTo.
  ///
  /// In es, this message translates to:
  /// **'Pega un PGN en «Analizar», elige con qué color jugabas y pulsa «Analizar partida».'**
  String get onboardHowTo;

  /// No description provided for @boardThemeName.
  ///
  /// In es, this message translates to:
  /// **'{theme, select, slate{Pizarra} sand{Arena} sage{Salvia} plum{Ciruela} other{Tablero}}'**
  String boardThemeName(String theme);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
