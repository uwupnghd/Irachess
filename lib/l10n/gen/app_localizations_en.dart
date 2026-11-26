// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'IraChess';

  @override
  String get navAnalyze => 'Analyze';

  @override
  String get navPuzzles => 'Puzzles';

  @override
  String get navVision => 'Vision';

  @override
  String get navProgress => 'Progress';

  @override
  String get navSettings => 'Settings';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get retry => 'Retry';

  @override
  String get delete => 'Delete';

  @override
  String get ok => 'OK';

  @override
  String get next => 'Next';

  @override
  String get share => 'Share';

  @override
  String get loading => 'Loading…';

  @override
  String errorGeneric(String error) {
    return 'Something went wrong: $error';
  }

  @override
  String get gamesTitle => 'My games';

  @override
  String get gamesEmptyTitle => 'No games yet';

  @override
  String get gamesEmptyBody =>
      'Paste a PGN, import your games or play the engine to start learning from them.';

  @override
  String get actionPastePgn => 'Paste PGN';

  @override
  String get actionOpenFile => 'Open PGN file';

  @override
  String get actionImportOnline => 'Import from Lichess / Chess.com';

  @override
  String get actionPlayEngine => 'Play the engine';

  @override
  String gameVs(String white, String black) {
    return '$white vs $black';
  }

  @override
  String get notAnalyzed => 'Not analyzed';

  @override
  String accuracyShort(String value) {
    return 'Accuracy $value%';
  }

  @override
  String get deleteGameConfirm => 'Delete this game and its analysis?';

  @override
  String get importTitle => 'Import PGN';

  @override
  String get importHint => 'Paste your game\'s PGN here…';

  @override
  String get importButton => 'Import';

  @override
  String get importWhichSide => 'Which side did you play?';

  @override
  String get sideWhite => 'White';

  @override
  String get sideBlack => 'Black';

  @override
  String get sideUnknown => 'I don\'t know';

  @override
  String get importErrorEmpty => 'The PGN is empty.';

  @override
  String get importErrorTooLarge => 'The PGN is too large (2 MB max).';

  @override
  String get importErrorNoMoves => 'No moves were found in the PGN.';

  @override
  String get importErrorTooManyGames => 'Too many games in one file (500 max).';

  @override
  String importErrorIllegal(String san, int game, int move) {
    return 'Illegal move \"$san\" in game $game, move $move.';
  }

  @override
  String get importErrorBadFen =>
      'The starting position (FEN) is invalid or from an unsupported variant.';

  @override
  String get importErrorTooLong => 'The game is too long (300 moves max).';

  @override
  String importedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count games imported',
      one: '1 game imported',
      zero: 'No new games',
    );
    return '$_temp0';
  }

  @override
  String get analyzeButton => 'Analyze game';

  @override
  String analyzing(int done, int total) {
    return 'Analyzing… $done/$total';
  }

  @override
  String engineUnavailable(String error) {
    return 'Couldn\'t start the engine: $error';
  }

  @override
  String get tabMoves => 'Moves';

  @override
  String get tabSummary => 'Summary';

  @override
  String bestMoveWas(String san) {
    return 'Best: $san';
  }

  @override
  String get alternatives => 'Engine alternatives';

  @override
  String get tryIt => 'Try it yourself';

  @override
  String tryItPrompt(String side) {
    return 'Find the best move for $side';
  }

  @override
  String tryItCorrect(String san) {
    return 'Correct! $san was the best move.';
  }

  @override
  String tryItWrong(String san) {
    return '$san isn\'t the best. Try again.';
  }

  @override
  String get tryItReveal => 'Show solution';

  @override
  String get startPosition => 'Starting position';

  @override
  String get flipBoard => 'Flip board';

  @override
  String get firstMove => 'First move';

  @override
  String get prevMove => 'Previous move';

  @override
  String get nextMove => 'Next move';

  @override
  String get lastMove => 'Last move';

  @override
  String get evalGraph => 'Advantage';

  @override
  String moveOf(int number, String san) {
    return '$number. $san';
  }

  @override
  String moveOfBlack(int number, String san) {
    return '$number… $san';
  }

  @override
  String get clsBrilliant => 'Brilliant';

  @override
  String get clsGreat => 'Great';

  @override
  String get clsBook => 'Book';

  @override
  String get clsBest => 'Best';

  @override
  String get clsExcellent => 'Excellent';

  @override
  String get clsGood => 'Good';

  @override
  String get clsInaccuracy => 'Inaccuracy';

  @override
  String get clsMiss => 'Miss';

  @override
  String get clsMistake => 'Mistake';

  @override
  String get clsBlunder => 'Blunder';

  @override
  String get clsForced => 'Forced';

  @override
  String pieceName(String piece) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'pawn',
      'knight': 'knight',
      'bishop': 'bishop',
      'rook': 'rook',
      'queen': 'queen',
      'king': 'king',
      'other': 'piece',
    });
    return '$_temp0';
  }

  @override
  String get explForced => 'It was the only legal move.';

  @override
  String explBook(String opening) {
    return 'Book move ($opening).';
  }

  @override
  String get explBookPlain => 'Book move.';

  @override
  String get explBrilliant =>
      'Brilliant! You give up material for a bigger advantage.';

  @override
  String get explGreat => 'The only good move in this position. Well spotted!';

  @override
  String get explBest => 'The engine\'s top choice.';

  @override
  String explGoodAlt(String best) {
    return 'Good move. The engine preferred $best.';
  }

  @override
  String get explMiss =>
      'Your opponent had just made a mistake and you didn\'t punish it.';

  @override
  String explAllowsMate(int n, String line) {
    return 'This allows mate in $n: $line.';
  }

  @override
  String explHanging(String reply, String piece, String square) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'pawn',
      'knight': 'knight',
      'bishop': 'bishop',
      'rook': 'rook',
      'queen': 'queen',
      'king': 'king',
      'other': 'piece',
    });
    return '$reply wins your $_temp0 on $square, which was left undefended.';
  }

  @override
  String explFork(String reply, String piece1, String piece2) {
    String _temp0 = intl.Intl.selectLogic(piece1, {
      'pawn': 'pawn',
      'knight': 'knight',
      'bishop': 'bishop',
      'rook': 'rook',
      'queen': 'queen',
      'king': 'king',
      'other': 'piece',
    });
    String _temp1 = intl.Intl.selectLogic(piece2, {
      'pawn': 'pawn',
      'knight': 'knight',
      'bishop': 'bishop',
      'rook': 'rook',
      'queen': 'queen',
      'king': 'king',
      'other': 'piece',
    });
    return 'After your move, $reply is a fork: it attacks your $_temp0 and your $_temp1 at once.';
  }

  @override
  String explPin(String reply, String piece, String square, String behind) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'pawn',
      'knight': 'knight',
      'bishop': 'bishop',
      'rook': 'rook',
      'queen': 'queen',
      'king': 'king',
      'other': 'piece',
    });
    String _temp1 = intl.Intl.selectLogic(behind, {
      'pawn': 'pawn',
      'knight': 'knight',
      'bishop': 'bishop',
      'rook': 'rook',
      'queen': 'queen',
      'king': 'king',
      'other': 'piece',
    });
    return '$reply pins your $_temp0 on $square to your $_temp1.';
  }

  @override
  String explDiscovered(String reply, String piece) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'pawn',
      'knight': 'knight',
      'bishop': 'bishop',
      'rook': 'rook',
      'queen': 'queen',
      'king': 'king',
      'other': 'piece',
    });
    return '$reply uncovers an attack on your $_temp0.';
  }

  @override
  String explLosesMaterial(int n, String line) {
    return 'You lose $n points of material after $line.';
  }

  @override
  String explEvalDrop(String before, String after) {
    return 'Your evaluation goes from $before to $after.';
  }

  @override
  String explMissedMate(int n, String best) {
    return 'You had mate in $n starting with $best.';
  }

  @override
  String explBestWins(String best, String piece) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'a pawn',
      'knight': 'a knight',
      'bishop': 'a bishop',
      'rook': 'a rook',
      'queen': 'the queen',
      'king': 'the king',
      'other': 'material',
    });
    return '$best was better: it wins $_temp0.';
  }

  @override
  String explBestFork(String best, String piece1, String piece2) {
    String _temp0 = intl.Intl.selectLogic(piece1, {
      'pawn': 'pawn',
      'knight': 'knight',
      'bishop': 'bishop',
      'rook': 'rook',
      'queen': 'queen',
      'king': 'king',
      'other': 'piece',
    });
    String _temp1 = intl.Intl.selectLogic(piece2, {
      'pawn': 'pawn',
      'knight': 'knight',
      'bishop': 'bishop',
      'rook': 'rook',
      'queen': 'queen',
      'king': 'king',
      'other': 'piece',
    });
    return '$best was better: a fork hitting the opponent\'s $_temp0 and $_temp1.';
  }

  @override
  String explBestPin(String best, String piece) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'pawn',
      'knight': 'knight',
      'bishop': 'bishop',
      'rook': 'rook',
      'queen': 'queen',
      'king': 'king',
      'other': 'piece',
    });
    return '$best was better, pinning the opponent\'s $_temp0.';
  }

  @override
  String explBestDiscovered(String best, String piece) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'pawn',
      'knight': 'knight',
      'bishop': 'bishop',
      'rook': 'rook',
      'queen': 'queen',
      'king': 'king',
      'other': 'piece',
    });
    return '$best was better, with a discovered attack on the opponent\'s $_temp0.';
  }

  @override
  String explBestCheck(String best) {
    return '$best was better: a check that keeps the initiative.';
  }

  @override
  String explBestCastle(String best) {
    return '$best was better: castling to bring your king to safety.';
  }

  @override
  String explBestGeneric(String best) {
    return '$best was better.';
  }

  @override
  String get recHanging =>
      'Before every move, check which pieces are left undefended. Practice \"hanging piece\" puzzles.';

  @override
  String get recFork =>
      'Practice fork puzzles: they showed up in your mistakes.';

  @override
  String get recPin =>
      'Review pins and discovered attacks with puzzles on those themes.';

  @override
  String get recMate =>
      'Train mating patterns (mate in 1 and 2): you missed or allowed mates.';

  @override
  String recOpening(String opening) {
    return 'Review the $opening: several mistakes came early.';
  }

  @override
  String get recOpeningPlain =>
      'Review your openings: several mistakes came early.';

  @override
  String get recEndgame =>
      'Practice endgames: you made mistakes with few pieces left.';

  @override
  String get recMiss =>
      'When your opponent slips, look for checks, captures and threats to punish it.';

  @override
  String get recKeepGoing =>
      'Good game! Keep analyzing games to find your patterns.';

  @override
  String get summaryAccuracy => 'Accuracy';

  @override
  String get summaryOpening => 'Opening';

  @override
  String summaryLeftBook(int move, String san, String book) {
    return 'You left theory on move $move ($san). Book moves: $book.';
  }

  @override
  String summaryOpponentLeftBook(int move, String san) {
    return 'Your opponent left theory on move $move ($san).';
  }

  @override
  String get summaryInBook => 'The whole game followed theory.';

  @override
  String get summaryNoOpening => 'Unnamed opening or non-standard start.';

  @override
  String get summaryPhases => 'Performance by phase';

  @override
  String get phaseOpening => 'Opening';

  @override
  String get phaseMiddlegame => 'Middlegame';

  @override
  String get phaseEndgame => 'Endgame';

  @override
  String summaryWorstPhase(String phase) {
    return 'Where you struggled most: $phase';
  }

  @override
  String summaryPhaseLine(int moves, String acc, int errors) {
    return '$moves moves · $acc% accuracy · $errors errors';
  }

  @override
  String get summaryCritical => 'Critical moments';

  @override
  String get summaryRecommendations => 'What to practice';

  @override
  String get summaryCounts => 'Move classification';

  @override
  String get tableNumber => '#';

  @override
  String get tableEval => 'Eval';

  @override
  String get tableBest => 'Best';

  @override
  String get tableTime => 'Time';

  @override
  String get filterAll => 'All';

  @override
  String get filterMyErrors => 'My mistakes';

  @override
  String get filterBlunders => 'Blunders';

  @override
  String get exportPgn => 'Export annotated PGN';

  @override
  String get puzzlesTitle => 'Puzzles';

  @override
  String puzzleRating(int rating) {
    return 'Rating $rating';
  }

  @override
  String puzzleStreak(int n) {
    return 'Streak: $n';
  }

  @override
  String get puzzleStart => 'Start';

  @override
  String get puzzleThemes => 'Themes';

  @override
  String themeName(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'mateIn1': 'Mate in 1',
      'mateIn2': 'Mate in 2',
      'mateIn3': 'Mate in 3',
      'fork': 'Fork',
      'pin': 'Pin',
      'skewer': 'Skewer',
      'discoveredAttack': 'Discovered attack',
      'hangingPiece': 'Hanging piece',
      'sacrifice': 'Sacrifice',
      'backRankMate': 'Back-rank mate',
      'trappedPiece': 'Trapped piece',
      'doubleCheck': 'Double check',
      'endgame': 'Endgames',
      'promotion': 'Promotion',
      'mix': 'Mix',
      'own': 'My mistakes',
      'other': 'Other',
    });
    return '$_temp0';
  }

  @override
  String get puzzleMyErrorsEmpty =>
      'Analyze games to generate puzzles from your own mistakes.';

  @override
  String puzzleYourTurn(String side) {
    return '$side to move: find the best move';
  }

  @override
  String get puzzleCorrect => 'Correct! Keep going.';

  @override
  String get puzzleWrong => 'That\'s not it. Try again.';

  @override
  String get puzzleSolved => 'Solved!';

  @override
  String get puzzleFailed =>
      'Not solved. Check the solution and keep practicing.';

  @override
  String get puzzleHint => 'Hint';

  @override
  String puzzleHintText(String piece, String square) {
    String _temp0 = intl.Intl.selectLogic(piece, {
      'pawn': 'pawn',
      'knight': 'knight',
      'bishop': 'bishop',
      'rook': 'rook',
      'queen': 'queen',
      'king': 'king',
      'other': 'piece',
    });
    return 'Move the $_temp0 on $square.';
  }

  @override
  String get puzzleSolution => 'Solution';

  @override
  String get puzzleNoMore =>
      'No more puzzles with these filters. Download packs or pick another theme.';

  @override
  String puzzleFromGame(String opponent) {
    return 'From your game against $opponent';
  }

  @override
  String puzzleExplainOwn(String played, String best) {
    return 'In the game you played $played. The best was $best.';
  }

  @override
  String puzzleRatingChange(int rating, String delta) {
    return 'Rating: $rating ($delta)';
  }

  @override
  String get packsTitle => 'Offline packs';

  @override
  String packsUsed(String size) {
    return 'Space used: $size';
  }

  @override
  String get packDownload => 'Download';

  @override
  String get packDownloaded => 'Downloaded';

  @override
  String packCount(int count, int min, int max) {
    return '$count puzzles · $min–$max';
  }

  @override
  String packError(String error) {
    return 'Download failed: $error';
  }

  @override
  String packsOfflineNote(int count) {
    return 'Downloaded puzzles work in airplane mode. $count base puzzles are already included.';
  }

  @override
  String get packsIndexError =>
      'Couldn\'t fetch the pack list. Check your connection.';

  @override
  String get visionTitle => 'Vision';

  @override
  String get visionIntro => 'A square name appears: tap it as fast as you can.';

  @override
  String get visionSide => 'View the board as';

  @override
  String get visionCoords => 'Show coordinates';

  @override
  String get visionMode => 'Session';

  @override
  String get visionMode30 => '30 s';

  @override
  String get visionMode60 => '60 s';

  @override
  String get visionModeHits => '20 hits';

  @override
  String get visionStart => 'Start';

  @override
  String visionScore(int n) {
    return 'Hits: $n';
  }

  @override
  String visionErrors(int n) {
    return 'Misses: $n';
  }

  @override
  String visionTime(int seconds) {
    return '$seconds s';
  }

  @override
  String visionBest(int n) {
    return 'Best: $n';
  }

  @override
  String get visionNewRecord => 'New record!';

  @override
  String get visionMisses => 'Squares you miss most';

  @override
  String get visionAgain => 'Again';

  @override
  String visionTapSquare(String square) {
    return 'Tap square $square';
  }

  @override
  String visionResultTime(String time) {
    return 'Time: $time s';
  }

  @override
  String get visionNoMisses => 'No misses!';

  @override
  String get progressTitle => 'Progress';

  @override
  String get progressAccuracy => 'Your accuracy per game';

  @override
  String get progressPuzzleRating => 'Puzzle rating';

  @override
  String get progressOpenings => 'Your openings';

  @override
  String get progressErrorTypes => 'Most frequent error types';

  @override
  String get errTactical => 'Tactical';

  @override
  String get errOpening => 'Opening';

  @override
  String get errEndgame => 'Endgame';

  @override
  String get errOther => 'Other';

  @override
  String progressStreak(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Daily streak: $n days',
      one: 'Daily streak: 1 day',
    );
    return '$_temp0';
  }

  @override
  String progressDailyGoal(int done, int goal) {
    return 'Today\'s goal: $done/$goal puzzles';
  }

  @override
  String get progressEmpty => 'No data yet. Analyze games and solve puzzles.';

  @override
  String progressVision(String best, int sessions) {
    return 'Vision: best $best · $sessions sessions';
  }

  @override
  String openingStats(int games, int win, int draw, int loss) {
    return '$games games · $win% W · $draw% D · $loss% L';
  }

  @override
  String openingAcc(String acc) {
    return 'average accuracy $acc%';
  }

  @override
  String get onlineTitle => 'Import games';

  @override
  String get onlineUsername => 'Username';

  @override
  String get onlineMax => 'How many recent games';

  @override
  String get onlineImport => 'Import';

  @override
  String onlineNotFound(String user) {
    return 'User \"$user\" doesn\'t exist.';
  }

  @override
  String get onlineRateLimited =>
      'Too many requests. Wait a minute and try again.';

  @override
  String get onlineNetwork => 'No connection or the server isn\'t responding.';

  @override
  String get onlinePrivacy =>
      'Only public data is read. IraChess will never ask for your password.';

  @override
  String onlineProgress(int n) {
    return 'Downloading… $n games';
  }

  @override
  String get playTitle => 'Play the engine';

  @override
  String playLevel(int level) {
    return 'Level $level';
  }

  @override
  String get playColor => 'Your color';

  @override
  String get playRandom => 'Random';

  @override
  String get playStart => 'Start game';

  @override
  String get playResign => 'Resign';

  @override
  String get playAnalyze => 'Analyze game';

  @override
  String get playYouWin => 'You won!';

  @override
  String get playYouLose => 'You lost';

  @override
  String get playDraw => 'Draw';

  @override
  String get playThinking => 'Engine is thinking…';

  @override
  String get playYourMove => 'Your move';

  @override
  String get resultCheckmate => 'Checkmate';

  @override
  String get resultStalemate => 'Draw by stalemate';

  @override
  String get resultRepetition => 'Draw by threefold repetition';

  @override
  String get resultFiftyMoves => 'Draw by the 50-move rule';

  @override
  String get resultMaterial => 'Draw by insufficient material';

  @override
  String get resultResigned => 'Resignation';

  @override
  String get engineName => 'IraChess (engine)';

  @override
  String get you => 'You';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get settingsBoard => 'Board';

  @override
  String get settingsPieces => 'Pieces';

  @override
  String get settingsCoordinates => 'Show board coordinates';

  @override
  String get settingsSound => 'Move sounds';

  @override
  String get settingsHaptics => 'Haptics';

  @override
  String get settingsColorBlind => 'Color-blind mode';

  @override
  String get settingsColorBlindHint =>
      'Uses distinguishable colors for every classification.';

  @override
  String get settingsEngine => 'Analysis depth';

  @override
  String get presetFast => 'Fast';

  @override
  String get presetNormal => 'Normal';

  @override
  String get presetDeep => 'Deep';

  @override
  String get presetHint =>
      'Deeper = more accurate, but slower and uses more battery.';

  @override
  String get settingsDailyGoal => 'Daily puzzle goal';

  @override
  String get settingsUsernames => 'Your usernames';

  @override
  String get settingsLevel => 'Your level';

  @override
  String get settingsData => 'Your data';

  @override
  String get exportData => 'Export everything (JSON)';

  @override
  String get deleteAll => 'Delete all my data';

  @override
  String get deleteAllConfirm =>
      'All your games, analyses and progress on this device will be deleted. This can\'t be undone.';

  @override
  String get deletedAll => 'Data deleted';

  @override
  String get settingsAccount => 'Account and sync (optional)';

  @override
  String get accountNotConfigured =>
      'Sync isn\'t configured in this build. Everything is stored on this device only.';

  @override
  String get accountEmail => 'Email';

  @override
  String get accountSendCode => 'Send code';

  @override
  String get accountCode => 'Code received';

  @override
  String get accountVerify => 'Verify';

  @override
  String accountSignedIn(String email) {
    return 'Signed in as $email';
  }

  @override
  String get accountSignOut => 'Sign out';

  @override
  String get accountSyncNow => 'Sync now';

  @override
  String accountSynced(int up, int down) {
    return 'Synced: $up sent, $down received';
  }

  @override
  String get settingsAbout => 'About IraChess';

  @override
  String get aboutBody =>
      'IraChess is free software under the GPL-3.0 license. It uses Stockfish (GPL-3.0), Lichess\' dartchess and chessground (GPL-3.0), and the Lichess openings and puzzles (CC0). This program comes with ABSOLUTELY NO WARRANTY.';

  @override
  String get sourceCode => 'Source code';

  @override
  String get licenses => 'Third-party licenses';

  @override
  String get privacy => 'Privacy';

  @override
  String get privacyBody =>
      'IraChess stores your data on this device only. It only goes online to import public games from Lichess or Chess.com, download puzzle packs and, if you enable an account, sync your progress. No ads, no analytics. You can export or delete everything at any time.';

  @override
  String get onboardWelcome => 'Welcome to IraChess';

  @override
  String get onboardBody =>
      'Learn from your own games: every mistake explained in plain language, with the better move. Plus offline puzzles and a board-vision trainer.';

  @override
  String get onboardLevel => 'What\'s your level?';

  @override
  String get levelBeginner => 'Beginner (under 800)';

  @override
  String get levelNovice => 'Casual (800–1200)';

  @override
  String get levelIntermediate => 'Intermediate (1200–1600)';

  @override
  String get levelAdvanced => 'Advanced (1600+)';

  @override
  String get onboardStart => 'Get started';

  @override
  String get onboardHowTo =>
      'Paste a PGN under \"Analyze\", choose your side and tap \"Analyze game\".';

  @override
  String boardThemeName(String theme) {
    String _temp0 = intl.Intl.selectLogic(theme, {
      'slate': 'Slate',
      'sand': 'Sand',
      'sage': 'Sage',
      'plum': 'Plum',
      'other': 'Board',
    });
    return '$_temp0';
  }
}
