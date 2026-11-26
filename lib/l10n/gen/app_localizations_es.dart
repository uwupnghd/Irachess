// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'IraChess';

  @override
  String get navAnalyze => 'Analizar';

  @override
  String get navPuzzles => 'Problemas';

  @override
  String get navVision => 'Visión';

  @override
  String get navProgress => 'Progreso';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get close => 'Cerrar';

  @override
  String get retry => 'Reintentar';

  @override
  String get delete => 'Borrar';

  @override
  String get ok => 'Aceptar';

  @override
  String get next => 'Siguiente';

  @override
  String get share => 'Compartir';

  @override
  String get loading => 'Cargando…';

  @override
  String errorGeneric(String error) {
    return 'Algo salió mal: $error';
  }

  @override
  String get gamesTitle => 'Mis partidas';

  @override
  String get gamesEmptyTitle => 'Aún no hay partidas';

  @override
  String get gamesEmptyBody =>
      'Pega un PGN, importa tus partidas o juega contra el motor para empezar a aprender de ellas.';

  @override
  String get actionPastePgn => 'Pegar PGN';

  @override
  String get actionOpenFile => 'Abrir archivo PGN';

  @override
  String get actionImportOnline => 'Importar de Lichess / Chess.com';

  @override
  String get actionPlayEngine => 'Jugar contra el motor';

  @override
  String gameVs(String white, String black) {
    return '$white vs $black';
  }

  @override
  String get notAnalyzed => 'Sin analizar';

  @override
  String accuracyShort(String value) {
    return 'Precisión $value %';
  }

  @override
  String get deleteGameConfirm => '¿Borrar esta partida y su análisis?';

  @override
  String get importTitle => 'Importar PGN';

  @override
  String get importHint => 'Pega aquí el PGN de tu partida…';

  @override
  String get importButton => 'Importar';

  @override
  String get importWhichSide => '¿Con qué color jugabas?';

  @override
  String get sideWhite => 'Blancas';

  @override
  String get sideBlack => 'Negras';

  @override
  String get sideUnknown => 'No lo sé';

  @override
  String get importErrorEmpty => 'El PGN está vacío.';

  @override
  String get importErrorTooLarge => 'El PGN es demasiado grande (máximo 2 MB).';

  @override
  String get importErrorNoMoves => 'No se encontraron jugadas en el PGN.';

  @override
  String get importErrorTooManyGames =>
      'Demasiadas partidas en un solo archivo (máximo 500).';

  @override
  String importErrorIllegal(String san, int game, int move) {
    return 'Jugada ilegal «$san» en la partida $game, jugada $move.';
  }

  @override
  String get importErrorBadFen =>
      'La posición inicial (FEN) no es válida o es de una variante no soportada.';

  @override
  String get importErrorTooLong =>
      'La partida es demasiado larga (máximo 300 jugadas).';

  @override
  String importedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count partidas importadas',
      one: '1 partida importada',
      zero: 'No había partidas nuevas',
    );
    return '$_temp0';
  }

  @override
  String get analyzeButton => 'Analizar partida';

  @override
  String analyzing(int done, int total) {
    return 'Analizando… $done/$total';
  }

  @override
  String engineUnavailable(String error) {
    return 'No se pudo iniciar el motor: $error';
  }

  @override
  String get tabMoves => 'Jugadas';

  @override
  String get tabSummary => 'Resumen';

  @override
  String bestMoveWas(String san) {
    return 'Mejor: $san';
  }

  @override
  String get alternatives => 'Alternativas del motor';

  @override
  String get tryIt => 'Pruébalo tú';

  @override
  String tryItPrompt(String side) {
    return 'Busca la mejor jugada para $side';
  }

  @override
  String tryItCorrect(String san) {
    return '¡Correcto! $san era la mejor.';
  }

  @override
  String tryItWrong(String san) {
    return '$san no es la mejor. Inténtalo otra vez.';
  }

  @override
  String get tryItReveal => 'Ver solución';

  @override
  String get startPosition => 'Posición inicial';

  @override
  String get flipBoard => 'Girar tablero';

  @override
  String get firstMove => 'Primera jugada';

  @override
  String get prevMove => 'Jugada anterior';

  @override
  String get nextMove => 'Jugada siguiente';

  @override
  String get lastMove => 'Última jugada';

  @override
  String get evalGraph => 'Ventaja';

  @override
  String moveOf(int number, String san) {
    return '$number. $san';
  }

  @override
  String moveOfBlack(int number, String san) {
    return '$number… $san';
  }

  @override
  String get clsBrilliant => 'Brillante';

  @override
  String get clsGreat => 'Genial';

  @override
  String get clsBook => 'Teoría';

  @override
  String get clsBest => 'Mejor';

  @override
  String get clsExcellent => 'Excelente';

  @override
  String get clsGood => 'Buena';

  @override
  String get clsInaccuracy => 'Imprecisión';

  @override
  String get clsMiss => 'Omisión';

  @override
  String get clsMistake => 'Error';

  @override
  String get clsBlunder => 'Error grave';

  @override
  String get clsForced => 'Forzada';

  @override
  String pieceName(String piece) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'peón',
      'knight': 'caballo',
      'bishop': 'alfil',
      'rook': 'torre',
      'queen': 'dama',
      'king': 'rey',
      'other': 'pieza',
    });
    return '$_temp0';
  }

  @override
  String get explForced => 'Era la única jugada legal.';

  @override
  String explBook(String opening) {
    return 'Jugada de teoría ($opening).';
  }

  @override
  String get explBookPlain => 'Jugada de teoría.';

  @override
  String get explBrilliant =>
      '¡Brillante! Entregas material a cambio de una ventaja mayor.';

  @override
  String get explGreat =>
      'La única buena jugada en esta posición. ¡Bien visto!';

  @override
  String get explBest => 'La mejor jugada según el motor.';

  @override
  String explGoodAlt(String best) {
    return 'Buena jugada. El motor prefería $best.';
  }

  @override
  String get explMiss =>
      'Tu rival acababa de cometer un error y no lo aprovechaste.';

  @override
  String explAllowsMate(int n, String line) {
    return 'Esto permite mate en $n: $line.';
  }

  @override
  String explHanging(String reply, String piece, String square) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'peón',
      'knight': 'caballo',
      'bishop': 'alfil',
      'rook': 'torre',
      'queen': 'dama',
      'king': 'rey',
      'other': 'pieza',
    });
    return '$reply gana tu $_temp0 de $square, que había quedado sin defensa.';
  }

  @override
  String explFork(String reply, String piece1, String piece2) {
    String _temp0 = intl.Intl.selectLogic(piece1, {
      'pawn': 'peón',
      'knight': 'caballo',
      'bishop': 'alfil',
      'rook': 'torre',
      'queen': 'dama',
      'king': 'rey',
      'other': 'pieza',
    });
    String _temp1 = intl.Intl.selectLogic(piece2, {
      'pawn': 'peón',
      'knight': 'caballo',
      'bishop': 'alfil',
      'rook': 'torre',
      'queen': 'dama',
      'king': 'rey',
      'other': 'pieza',
    });
    return 'Tras tu jugada, $reply es una horquilla: ataca a la vez tu $_temp0 y tu $_temp1.';
  }

  @override
  String explPin(String reply, String piece, String square, String behind) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'peón',
      'knight': 'caballo',
      'bishop': 'alfil',
      'rook': 'torre',
      'queen': 'dama',
      'king': 'rey',
      'other': 'pieza',
    });
    String _temp1 = intl.Intl.selectLogic(behind, {
      'pawn': 'peón',
      'knight': 'caballo',
      'bishop': 'alfil',
      'rook': 'torre',
      'queen': 'dama',
      'king': 'rey',
      'other': 'pieza',
    });
    return '$reply clava tu $_temp0 de $square contra tu $_temp1.';
  }

  @override
  String explDiscovered(String reply, String piece) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'peón',
      'knight': 'caballo',
      'bishop': 'alfil',
      'rook': 'torre',
      'queen': 'dama',
      'king': 'rey',
      'other': 'pieza',
    });
    return '$reply descubre un ataque contra tu $_temp0.';
  }

  @override
  String explLosesMaterial(int n, String line) {
    return 'Pierdes $n puntos de material tras $line.';
  }

  @override
  String explEvalDrop(String before, String after) {
    return 'Tu evaluación pasa de $before a $after.';
  }

  @override
  String explMissedMate(int n, String best) {
    return 'Tenías mate en $n empezando con $best.';
  }

  @override
  String explBestWins(String best, String piece) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'un peón',
      'knight': 'un caballo',
      'bishop': 'un alfil',
      'rook': 'una torre',
      'queen': 'la dama',
      'king': 'el rey',
      'other': 'material',
    });
    return 'Era mejor $best: ganabas $_temp0.';
  }

  @override
  String explBestFork(String best, String piece1, String piece2) {
    String _temp0 = intl.Intl.selectLogic(piece1, {
      'pawn': 'el peón',
      'knight': 'el caballo',
      'bishop': 'el alfil',
      'rook': 'la torre',
      'queen': 'la dama',
      'king': 'el rey',
      'other': 'la pieza',
    });
    String _temp1 = intl.Intl.selectLogic(piece2, {
      'pawn': 'el peón',
      'knight': 'el caballo',
      'bishop': 'el alfil',
      'rook': 'la torre',
      'queen': 'la dama',
      'king': 'el rey',
      'other': 'la pieza',
    });
    return 'Era mejor $best: una horquilla que ataca $_temp0 y $_temp1 del rival.';
  }

  @override
  String explBestPin(String best, String piece) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'el peón',
      'knight': 'el caballo',
      'bishop': 'el alfil',
      'rook': 'la torre',
      'queen': 'la dama',
      'king': 'el rey',
      'other': 'la pieza',
    });
    return 'Era mejor $best, que clava $_temp0 rival.';
  }

  @override
  String explBestDiscovered(String best, String piece) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'el peón',
      'knight': 'el caballo',
      'bishop': 'el alfil',
      'rook': 'la torre',
      'queen': 'la dama',
      'king': 'el rey',
      'other': 'la pieza',
    });
    return 'Era mejor $best, con un ataque descubierto contra $_temp0 rival.';
  }

  @override
  String explBestCheck(String best) {
    return 'Era mejor $best: un jaque que mantiene la iniciativa.';
  }

  @override
  String explBestCastle(String best) {
    return 'Era mejor $best: poner el rey a salvo enrocando.';
  }

  @override
  String explBestGeneric(String best) {
    return 'Era mejor $best.';
  }

  @override
  String get recHanging =>
      'Antes de cada jugada, comprueba qué piezas quedan sin defensa. Practica problemas de «pieza colgada».';

  @override
  String get recFork =>
      'Practica problemas de horquillas: aparecieron en tus errores.';

  @override
  String get recPin =>
      'Repasa clavadas y ataques descubiertos con problemas de esos temas.';

  @override
  String get recMate =>
      'Entrena patrones de mate (mate en 1 y en 2): hubo mates que se te escaparon o que permitiste.';

  @override
  String recOpening(String opening) {
    return 'Repasa la apertura $opening: varios errores llegaron pronto.';
  }

  @override
  String get recOpeningPlain =>
      'Repasa tus aperturas: varios errores llegaron pronto.';

  @override
  String get recEndgame =>
      'Practica finales: cometiste errores cuando quedaban pocas piezas.';

  @override
  String get recMiss =>
      'Cuando tu rival se equivoque, busca jaques, capturas y amenazas para castigarlo.';

  @override
  String get recKeepGoing =>
      '¡Buena partida! Sigue analizando partidas para descubrir tus patrones.';

  @override
  String get summaryAccuracy => 'Precisión';

  @override
  String get summaryOpening => 'Apertura';

  @override
  String summaryLeftBook(int move, String san, String book) {
    return 'Saliste de la teoría en la jugada $move ($san). Jugadas de libro: $book.';
  }

  @override
  String summaryOpponentLeftBook(int move, String san) {
    return 'Tu rival salió de la teoría en la jugada $move ($san).';
  }

  @override
  String get summaryInBook => 'Toda la partida siguió la teoría.';

  @override
  String get summaryNoOpening =>
      'Apertura sin nombre o posición inicial no estándar.';

  @override
  String get summaryPhases => 'Rendimiento por fase';

  @override
  String get phaseOpening => 'Apertura';

  @override
  String get phaseMiddlegame => 'Medio juego';

  @override
  String get phaseEndgame => 'Final';

  @override
  String summaryWorstPhase(String phase) {
    return 'Donde más fallaste: $phase';
  }

  @override
  String summaryPhaseLine(int moves, String acc, int errors) {
    return '$moves jugadas · precisión $acc % · $errors errores';
  }

  @override
  String get summaryCritical => 'Momentos críticos';

  @override
  String get summaryRecommendations => 'Qué practicar';

  @override
  String get summaryCounts => 'Clasificación de jugadas';

  @override
  String get tableNumber => 'N.º';

  @override
  String get tableEval => 'Eval.';

  @override
  String get tableBest => 'Mejor';

  @override
  String get tableTime => 'Tiempo';

  @override
  String get filterAll => 'Todas';

  @override
  String get filterMyErrors => 'Mis errores';

  @override
  String get filterBlunders => 'Errores graves';

  @override
  String get exportPgn => 'Exportar PGN anotado';

  @override
  String get puzzlesTitle => 'Problemas';

  @override
  String puzzleRating(int rating) {
    return 'Rating $rating';
  }

  @override
  String puzzleStreak(int n) {
    return 'Racha: $n';
  }

  @override
  String get puzzleStart => 'Empezar';

  @override
  String get puzzleThemes => 'Temas';

  @override
  String themeName(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'mateIn1': 'Mate en 1',
      'mateIn2': 'Mate en 2',
      'mateIn3': 'Mate en 3',
      'fork': 'Horquilla',
      'pin': 'Clavada',
      'skewer': 'Enfilada',
      'discoveredAttack': 'Ataque descubierto',
      'hangingPiece': 'Pieza colgada',
      'sacrifice': 'Sacrificio',
      'backRankMate': 'Mate del pasillo',
      'trappedPiece': 'Pieza atrapada',
      'doubleCheck': 'Jaque doble',
      'endgame': 'Finales',
      'promotion': 'Coronación',
      'mix': 'Mezcla',
      'own': 'Mis errores',
      'other': 'Otro',
    });
    return '$_temp0';
  }

  @override
  String get puzzleMyErrorsEmpty =>
      'Analiza partidas para generar problemas con tus propios errores.';

  @override
  String puzzleYourTurn(String side) {
    return 'Juegan $side: encuentra la mejor jugada';
  }

  @override
  String get puzzleCorrect => '¡Correcto! Sigue.';

  @override
  String get puzzleWrong => 'No es la jugada. Prueba otra vez.';

  @override
  String get puzzleSolved => '¡Resuelto!';

  @override
  String get puzzleFailed =>
      'No resuelto. Mira la solución y sigue practicando.';

  @override
  String get puzzleHint => 'Pista';

  @override
  String puzzleHintText(String piece, String square) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'el peón',
      'knight': 'el caballo',
      'bishop': 'el alfil',
      'rook': 'la torre',
      'queen': 'la dama',
      'king': 'el rey',
      'other': 'la pieza',
    });
    return 'Mueve $_temp0 de $square.';
  }

  @override
  String get puzzleSolution => 'Solución';

  @override
  String get puzzleNoMore =>
      'No hay más problemas con estos filtros. Descarga paquetes o cambia de tema.';

  @override
  String puzzleFromGame(String opponent) {
    return 'De tu partida contra $opponent';
  }

  @override
  String puzzleExplainOwn(String played, String best) {
    return 'En la partida jugaste $played. La mejor era $best.';
  }

  @override
  String puzzleRatingChange(int rating, String delta) {
    return 'Rating: $rating ($delta)';
  }

  @override
  String get packsTitle => 'Paquetes sin conexión';

  @override
  String packsUsed(String size) {
    return 'Espacio usado: $size';
  }

  @override
  String get packDownload => 'Descargar';

  @override
  String get packDownloaded => 'Descargado';

  @override
  String packCount(int count, int min, int max) {
    return '$count problemas · $min–$max';
  }

  @override
  String packError(String error) {
    return 'No se pudo descargar: $error';
  }

  @override
  String packsOfflineNote(int count) {
    return 'Los problemas descargados funcionan en modo avión. Ya incluyes $count problemas de base.';
  }

  @override
  String get packsIndexError =>
      'No se pudo obtener la lista de paquetes. Comprueba tu conexión.';

  @override
  String get visionTitle => 'Visión';

  @override
  String get visionIntro =>
      'Aparece el nombre de una casilla: tócala lo más rápido posible.';

  @override
  String get visionSide => 'Ver el tablero desde';

  @override
  String get visionCoords => 'Mostrar coordenadas';

  @override
  String get visionMode => 'Sesión';

  @override
  String get visionMode30 => '30 s';

  @override
  String get visionMode60 => '60 s';

  @override
  String get visionModeHits => '20 aciertos';

  @override
  String get visionStart => 'Empezar';

  @override
  String visionScore(int n) {
    return 'Aciertos: $n';
  }

  @override
  String visionErrors(int n) {
    return 'Fallos: $n';
  }

  @override
  String visionTime(int seconds) {
    return '$seconds s';
  }

  @override
  String visionBest(int n) {
    return 'Récord: $n';
  }

  @override
  String get visionNewRecord => '¡Nuevo récord!';

  @override
  String get visionMisses => 'Casillas que más fallas';

  @override
  String get visionAgain => 'Otra vez';

  @override
  String visionTapSquare(String square) {
    return 'Toca la casilla $square';
  }

  @override
  String visionResultTime(String time) {
    return 'Tiempo: $time s';
  }

  @override
  String get visionNoMisses => '¡Sin fallos!';

  @override
  String get progressTitle => 'Progreso';

  @override
  String get progressAccuracy => 'Tu precisión por partida';

  @override
  String get progressPuzzleRating => 'Rating de problemas';

  @override
  String get progressOpenings => 'Tus aperturas';

  @override
  String get progressErrorTypes => 'Tipos de error más frecuentes';

  @override
  String get errTactical => 'Tácticos';

  @override
  String get errOpening => 'De apertura';

  @override
  String get errEndgame => 'De finales';

  @override
  String get errOther => 'Otros';

  @override
  String progressStreak(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Racha diaria: $n días',
      one: 'Racha diaria: 1 día',
    );
    return '$_temp0';
  }

  @override
  String progressDailyGoal(int done, int goal) {
    return 'Objetivo de hoy: $done/$goal problemas';
  }

  @override
  String get progressEmpty =>
      'Aún no hay datos. Analiza partidas y resuelve problemas.';

  @override
  String progressVision(String best, int sessions) {
    return 'Visión: récord $best · $sessions sesiones';
  }

  @override
  String openingStats(int games, int win, int draw, int loss) {
    return '$games partidas · $win % V · $draw % T · $loss % D';
  }

  @override
  String openingAcc(String acc) {
    return 'precisión media $acc %';
  }

  @override
  String get onlineTitle => 'Importar partidas';

  @override
  String get onlineUsername => 'Nombre de usuario';

  @override
  String get onlineMax => 'Cuántas partidas recientes';

  @override
  String get onlineImport => 'Importar';

  @override
  String onlineNotFound(String user) {
    return 'No existe el usuario «$user».';
  }

  @override
  String get onlineRateLimited =>
      'Demasiadas peticiones. Espera un minuto y vuelve a intentarlo.';

  @override
  String get onlineNetwork => 'Sin conexión o el servidor no responde.';

  @override
  String get onlinePrivacy =>
      'Solo se leen datos públicos. IraChess nunca te pedirá tu contraseña.';

  @override
  String onlineProgress(int n) {
    return 'Descargando… $n partidas';
  }

  @override
  String get playTitle => 'Jugar contra el motor';

  @override
  String playLevel(int level) {
    return 'Nivel $level';
  }

  @override
  String get playColor => 'Tu color';

  @override
  String get playRandom => 'Al azar';

  @override
  String get playStart => 'Empezar partida';

  @override
  String get playResign => 'Rendirse';

  @override
  String get playAnalyze => 'Analizar partida';

  @override
  String get playYouWin => '¡Ganaste!';

  @override
  String get playYouLose => 'Perdiste';

  @override
  String get playDraw => 'Tablas';

  @override
  String get playThinking => 'El motor piensa…';

  @override
  String get playYourMove => 'Tu turno';

  @override
  String get resultCheckmate => 'Jaque mate';

  @override
  String get resultStalemate => 'Tablas por ahogado';

  @override
  String get resultRepetition => 'Tablas por triple repetición';

  @override
  String get resultFiftyMoves => 'Tablas por la regla de los 50 movimientos';

  @override
  String get resultMaterial => 'Tablas por material insuficiente';

  @override
  String get resultResigned => 'Abandono';

  @override
  String get engineName => 'IraChess (motor)';

  @override
  String get you => 'Tú';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get languageSystem => 'Del sistema';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get themeSystem => 'Del sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get settingsBoard => 'Tablero';

  @override
  String get settingsPieces => 'Piezas';

  @override
  String get settingsCoordinates => 'Mostrar coordenadas en el tablero';

  @override
  String get settingsSound => 'Sonidos de movimiento';

  @override
  String get settingsHaptics => 'Vibración';

  @override
  String get settingsColorBlind => 'Modo daltónico';

  @override
  String get settingsColorBlindHint =>
      'Usa colores distinguibles para todas las clasificaciones.';

  @override
  String get settingsEngine => 'Profundidad de análisis';

  @override
  String get presetFast => 'Rápido';

  @override
  String get presetNormal => 'Normal';

  @override
  String get presetDeep => 'Profundo';

  @override
  String get presetHint =>
      'Más profundo = más preciso, pero más lento y gasta más batería.';

  @override
  String get settingsDailyGoal => 'Objetivo diario de problemas';

  @override
  String get settingsUsernames => 'Tus usuarios';

  @override
  String get settingsLevel => 'Tu nivel';

  @override
  String get settingsData => 'Tus datos';

  @override
  String get exportData => 'Exportar todo (JSON)';

  @override
  String get deleteAll => 'Borrar todos mis datos';

  @override
  String get deleteAllConfirm =>
      'Se borrarán todas tus partidas, análisis y progreso de este dispositivo. No se puede deshacer.';

  @override
  String get deletedAll => 'Datos borrados';

  @override
  String get settingsAccount => 'Cuenta y sincronización (opcional)';

  @override
  String get accountNotConfigured =>
      'La sincronización no está configurada en esta compilación. Todo se guarda solo en este dispositivo.';

  @override
  String get accountEmail => 'Email';

  @override
  String get accountSendCode => 'Enviar código';

  @override
  String get accountCode => 'Código recibido';

  @override
  String get accountVerify => 'Verificar';

  @override
  String accountSignedIn(String email) {
    return 'Conectado como $email';
  }

  @override
  String get accountSignOut => 'Cerrar sesión';

  @override
  String get accountSyncNow => 'Sincronizar ahora';

  @override
  String accountSynced(int up, int down) {
    return 'Sincronizado: $up enviados, $down recibidos';
  }

  @override
  String get settingsAbout => 'Acerca de IraChess';

  @override
  String get aboutBody =>
      'IraChess es software libre bajo la licencia GPL-3.0. Usa Stockfish (GPL-3.0), dartchess y chessground de Lichess (GPL-3.0), el libro de aperturas y los problemas de Lichess (CC0). Este programa se ofrece SIN NINGUNA GARANTÍA.';

  @override
  String get sourceCode => 'Código fuente';

  @override
  String get licenses => 'Licencias de terceros';

  @override
  String get privacy => 'Privacidad';

  @override
  String get privacyBody =>
      'IraChess guarda tus datos solo en este dispositivo. Solo se conecta a internet para importar partidas públicas de Lichess o Chess.com, descargar paquetes de problemas y, si activas una cuenta, sincronizar tu progreso. No hay anuncios ni analíticas. Puedes exportar o borrar todo en cualquier momento.';

  @override
  String get onboardWelcome => 'Bienvenido a IraChess';

  @override
  String get onboardBody =>
      'Aprende de tus propias partidas: te explicamos cada error en lenguaje sencillo y qué jugada era mejor. También tienes problemas sin conexión y un entrenador de visión del tablero.';

  @override
  String get onboardLevel => '¿Cuál es tu nivel?';

  @override
  String get levelBeginner => 'Empezando (menos de 800)';

  @override
  String get levelNovice => 'Aficionado (800–1200)';

  @override
  String get levelIntermediate => 'Intermedio (1200–1600)';

  @override
  String get levelAdvanced => 'Avanzado (1600 o más)';

  @override
  String get onboardStart => 'Empezar';

  @override
  String get onboardHowTo =>
      'Pega un PGN en «Analizar», elige con qué color jugabas y pulsa «Analizar partida».';

  @override
  String boardThemeName(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'slate': 'Pizarra',
      'sand': 'Arena',
      'sage': 'Salvia',
      'plum': 'Ciruela',
      'other': 'Tablero',
    });
    return '$_temp0';
  }
}
