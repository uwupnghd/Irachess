import 'package:chessground/chessground.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../engine/uci_engine.dart';

/// Solo conjuntos de piezas con licencia compatible con GPL-3.0
/// (cburnett/merida GPLv2+, chessnut Apache-2.0, fantasy/spatial/celtic MIT, rhosgfx CC0).
const allowedPieceSets = [
  PieceSet.cburnett,
  PieceSet.merida,
  PieceSet.chessnut,
  PieceSet.fantasy,
  PieceSet.spatial,
  PieceSet.celtic,
  PieceSet.rhosgfx,
];

enum PlayerLevel { beginner, novice, intermediate, advanced }

class Settings {
  const Settings({
    this.locale,
    this.themeMode = ThemeMode.system,
    this.boardTheme = 'slate',
    this.pieceSet = PieceSet.cburnett,
    this.coordinates = true,
    this.sound = true,
    this.haptics = true,
    this.colorBlind = false,
    this.preset = EnginePreset.normal,
    this.dailyGoal = 10,
    this.lichessUser = '',
    this.chesscomUser = '',
    this.level = PlayerLevel.novice,
    this.onboarded = false,
    this.visionBest = 0,
  });

  final String? locale;
  final ThemeMode themeMode;
  final String boardTheme;
  final PieceSet pieceSet;
  final bool coordinates;
  final bool sound;
  final bool haptics;
  final bool colorBlind;
  final EnginePreset preset;
  final int dailyGoal;
  final String lichessUser;
  final String chesscomUser;
  final PlayerLevel level;
  final bool onboarded;
  final int visionBest;

  Settings copyWith({
    String? Function()? locale,
    ThemeMode? themeMode,
    String? boardTheme,
    PieceSet? pieceSet,
    bool? coordinates,
    bool? sound,
    bool? haptics,
    bool? colorBlind,
    EnginePreset? preset,
    int? dailyGoal,
    String? lichessUser,
    String? chesscomUser,
    PlayerLevel? level,
    bool? onboarded,
    int? visionBest,
  }) => Settings(
    locale: locale == null ? this.locale : locale(),
    themeMode: themeMode ?? this.themeMode,
    boardTheme: boardTheme ?? this.boardTheme,
    pieceSet: pieceSet ?? this.pieceSet,
    coordinates: coordinates ?? this.coordinates,
    sound: sound ?? this.sound,
    haptics: haptics ?? this.haptics,
    colorBlind: colorBlind ?? this.colorBlind,
    preset: preset ?? this.preset,
    dailyGoal: dailyGoal ?? this.dailyGoal,
    lichessUser: lichessUser ?? this.lichessUser,
    chesscomUser: chesscomUser ?? this.chesscomUser,
    level: level ?? this.level,
    onboarded: onboarded ?? this.onboarded,
    visionBest: visionBest ?? this.visionBest,
  );

  Map<String, Object?> toJson() => {
    'locale': locale,
    'themeMode': themeMode.name,
    'boardTheme': boardTheme,
    'pieceSet': pieceSet.name,
    'coordinates': coordinates,
    'sound': sound,
    'haptics': haptics,
    'colorBlind': colorBlind,
    'preset': preset.name,
    'dailyGoal': dailyGoal,
    'lichessUser': lichessUser,
    'chesscomUser': chesscomUser,
    'level': level.name,
    'onboarded': onboarded,
    'visionBest': visionBest,
  };

  static T _enum<T extends Enum>(List<T> values, Object? name, T fallback) =>
      values.where((v) => v.name == name).firstOrNull ?? fallback;

  factory Settings.fromPrefs(SharedPreferences p) => Settings(
    locale: p.getString('locale'),
    themeMode: _enum(ThemeMode.values, p.getString('themeMode'), ThemeMode.system),
    boardTheme: p.getString('boardTheme') ?? 'slate',
    pieceSet: _enum(allowedPieceSets, p.getString('pieceSet'), PieceSet.cburnett),
    coordinates: p.getBool('coordinates') ?? true,
    sound: p.getBool('sound') ?? true,
    haptics: p.getBool('haptics') ?? true,
    colorBlind: p.getBool('colorBlind') ?? false,
    preset: _enum(EnginePreset.values, p.getString('preset'), EnginePreset.normal),
    dailyGoal: p.getInt('dailyGoal') ?? 10,
    lichessUser: p.getString('lichessUser') ?? '',
    chesscomUser: p.getString('chesscomUser') ?? '',
    level: _enum(PlayerLevel.values, p.getString('level'), PlayerLevel.novice),
    onboarded: p.getBool('onboarded') ?? false,
    visionBest: p.getInt('visionBest') ?? 0,
  );
}

/// Se sobrescribe en main() con la instancia ya cargada.
final sharedPrefsProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError());

final settingsProvider = NotifierProvider<SettingsNotifier, Settings>(SettingsNotifier.new);

class SettingsNotifier extends Notifier<Settings> {
  @override
  Settings build() => Settings.fromPrefs(ref.watch(sharedPrefsProvider));

  Future<void> update(Settings Function(Settings) change) async {
    state = change(state);
    final p = ref.read(sharedPrefsProvider);
    for (final MapEntry(:key, :value) in state.toJson().entries) {
      switch (value) {
        case null:
          await p.remove(key);
        case final bool b:
          await p.setBool(key, b);
        case final int i:
          await p.setInt(key, i);
        case final String s:
          await p.setString(key, s);
      }
    }
  }
}
