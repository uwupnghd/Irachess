import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/settings/settings.dart';
import '../features/analysis/presentation/analysis_screen.dart';
import '../features/games/presentation/games_screen.dart';
import '../features/games/presentation/import_screen.dart';
import '../features/games/presentation/online_import_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/play/play_screen.dart';
import '../features/progress/progress_screen.dart';
import '../features/puzzles/presentation/packs_screen.dart';
import '../features/puzzles/presentation/puzzle_screen.dart';
import '../features/puzzles/presentation/puzzles_home.dart';
import '../features/settings/about_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/vision/vision_screen.dart';
import 'shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/analyze',
    redirect: (context, state) {
      final onboarded = ref.read(settingsProvider).onboarded;
      if (!onboarded && state.matchedLocation != '/welcome') return '/welcome';
      return null;
    },
    routes: [
      GoRoute(path: '/welcome', builder: (_, _) => const OnboardingScreen()),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => AppShell(shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/analyze',
              builder: (_, _) => const GamesScreen(),
              routes: [
                GoRoute(path: 'import', builder: (_, _) => const ImportScreen()),
                GoRoute(path: 'online', builder: (_, _) => const OnlineImportScreen()),
                GoRoute(path: 'play', builder: (_, _) => const PlayScreen()),
                GoRoute(
                  path: 'game/:id',
                  builder: (_, s) => AnalysisScreen(gameId: int.parse(s.pathParameters['id']!)),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/puzzles',
              builder: (_, _) => const PuzzlesHome(),
              routes: [
                GoRoute(
                  path: 'solve',
                  builder: (_, s) => PuzzleScreen(theme: s.uri.queryParameters['theme'] ?? 'mix'),
                ),
                GoRoute(path: 'packs', builder: (_, _) => const PacksScreen()),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [GoRoute(path: '/vision', builder: (_, _) => const VisionScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/progress', builder: (_, _) => const ProgressScreen())]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/settings',
              builder: (_, _) => const SettingsScreen(),
              routes: [GoRoute(path: 'about', builder: (_, _) => const AboutScreen())],
            ),
          ]),
        ],
      ),
    ],
  );
});
