import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';

class OtherPlayer {
  String playerName;
  String country;
  bool isMale;
  int daysInGame;
  int plastic;
  int paper;
  int metal;
  int electronics;
  int glass;
  int food;
  int wrong;
  int manuka;
  int qianBi;
  int risa;
  int stark;
  int asimov;
  int moon;

  OtherPlayer({
    required this.playerName,
    required this.country,
    required this.isMale,
    required this.daysInGame,
    required this.plastic,
    required this.paper,
    required this.metal,
    required this.electronics,
    required this.glass,
    required this.food,
    required this.wrong,
    required this.manuka,
    required this.qianBi,
    required this.risa,
    required this.stark,
    required this.asimov,
    required this.moon,
  });

  static OtherPlayer fromJson(Map<String, dynamic> json) {
    return OtherPlayer(
      playerName: json[Strings.playerName] ?? '',
      country: json[Strings.country] ?? '',
      isMale: json[Strings.isMale] ?? true,
      daysInGame: json[Strings.daysInGame] ?? 0,
      plastic: json[Strings.plastic] ?? 0,
      paper: json[Strings.paper] ?? 0,
      metal: json[Strings.metal] ?? 0,
      electronics: json[Strings.electronics] ?? 0,
      glass: json[Strings.glass] ?? 0,
      food: json[Strings.food] ?? 0,
      wrong: json[Strings.wrong] ?? 0,
      manuka: json[Strings.manuka] ?? -1,
      qianBi: json[Strings.qianBi] ?? -1,
      risa: json[Strings.risa] ?? -1,
      stark: json[Strings.stark] ?? -1,
      asimov: json[Strings.asimov] ?? -1,
      moon: json[Strings.moon] ?? -1,
    );
  }

  static OtherPlayer fromBlocState({
    required ProgressState progressState,
    required PlayerState playerState,
    required GameState gameState,
  }) {
    return OtherPlayer(
      playerName: playerState.playerName,
      country: playerState.country,
      isMale: playerState.isMale,
      daysInGame: gameState.daysInGame,
      plastic: progressState.plastic,
      paper: progressState.paper,
      metal: progressState.metal,
      electronics: progressState.electronics,
      glass: progressState.glass,
      food: progressState.food,
      wrong: progressState.wrong,
      manuka: progressState.manuka,
      qianBi: progressState.qianBi,
      risa: progressState.risa,
      stark: progressState.stark,
      asimov: progressState.asimov,
      moon: progressState.moon,
    );
  }
}
