import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/game/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/game/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/game/scenes/scene_name.dart';

Future<void> savePlayerInfo({
  required String playerId,
  required String playerName,
  required String country,
  required bool isMale,
}) async {
  await FirebaseFirestore.instance
      .collection(Strings.playersCollection)
      .doc(playerId)
      .set({
    Strings.playerName: playerName,
    Strings.country: country,
    Strings.isMale: isMale,
  });
}

Future<bool> saveGameState({
  required BuildContext context,
  required String playerId,
}) async {
  try {
    GameState gameState = context.read<GameStateBloc>().state;
    PlayerState playerState = context.read<PlayerStateBloc>().state;
    ProgressState progressState = context.read<ProgressStateBloc>().state;
    await FirebaseFirestore.instance
        .collection(Strings.playersCollection)
        .doc(playerId)
        .set({
      Strings.hasSave: true,
      Strings.playerXPosit: playerState.playerPosition.x,
      Strings.playerYPosit: playerState.playerPosition.y,
      Strings.playerXDir: playerState.playerDirection.x,
      Strings.playerYDir: playerState.playerDirection.y,
      Strings.savedLocation: playerState.savedLocation.string,
      Strings.coinAmount: gameState.coinAmount,
      Strings.sceneName: gameState.sceneName.name,
      Strings.bagCount: gameState.bagCount,
      Strings.bagSize: gameState.bagSize,
      Strings.minutes: gameState.minutes,
      Strings.daysInGame: gameState.daysInGame,
      Strings.plastic: progressState.plastic,
      Strings.paper: progressState.paper,
      Strings.metal: progressState.metal,
      Strings.electronics: progressState.electronics,
      Strings.glass: progressState.glass,
      Strings.food: progressState.food,
      Strings.wrong: progressState.wrong,
      Strings.manuka: progressState.manuka,
      Strings.qianBi: progressState.qianBi,
      Strings.risa: progressState.risa,
      Strings.stark: progressState.stark,
      Strings.asimov: progressState.asimov,
      Strings.moon: progressState.moon,
      Strings.neighbour: progressState.neighbour,
    });
    return true;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
}

Future<bool> loadPlayerInfo({
  required String playerId,
  required BuildContext context,
}) async {
  return await FirebaseFirestore.instance
      .collection(Strings.playersCollection)
      .doc(playerId)
      .get()
      .then((doc) {
    if (doc.data() == null) {
      return false;
    } else {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String savedLocation = data[Strings.savedLocation] ?? SceneName.hood.string;
      context.read<PlayerStateBloc>().state.setPlayerState(
            context: context,
            playerName: data[Strings.playerName] ?? '',
            country: data[Strings.country] ?? '',
            isMale: data[Strings.isMale] ?? true,
            playerXPosit: data[Strings.playerXPosit],
            playerYPosit: data[Strings.playerYPosit],
            playerXDir: data[Strings.playerXDir],
            playerYDir: data[Strings.playerYDir],
            savedLocation: savedLocation.sceneName,
          );
      context.read<GameStateBloc>().state.setGameState(
            context: context,
            coinAmount: data[Strings.coinAmount] ?? 0,
            bagCount: data[Strings.bagCount] ?? 0,
            bagSize: data[Strings.bagSize] ?? 1,
            minutes: data[Strings.minutes] ?? gameStartTime,
            daysInGame: data[Strings.daysInGame] ?? 0,
          );
      context.read<ProgressStateBloc>().state.setProgress(
            context: context,
            hasSave: data[Strings.hasSave] ?? false,
            neighbour: data[Strings.neighbour] ?? 'intro',
            plastic: data[Strings.plastic] ?? 0,
            paper: data[Strings.paper] ?? 0,
            metal: data[Strings.metal] ?? 0,
            electronics: data[Strings.electronics] ?? 0,
            glass: data[Strings.glass] ?? 0,
            food: data[Strings.food] ?? 0,
            wrong: data[Strings.wrong] ?? 0,
            manuka: data[Strings.manuka] ?? -1,
            qianBi: data[Strings.qianBi] ?? -1,
            risa: data[Strings.risa] ?? -1,
            stark: data[Strings.stark] ?? -1,
            asimov: data[Strings.asimov] ?? -1,
            moon: data[Strings.moon] ?? -1,
          );
      return true;
    }
  });
}
