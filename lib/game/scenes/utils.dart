import 'package:flame/components.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/scene_name.dart';

Vector2 getPlayerHoodStartPosit(GomilandGame game) {
  SceneName sceneName = game.gameStateBloc.state.sceneName;
  final bool comingFromPark = sceneName == SceneName.park;
  Vector2 playerStartPosit = comingFromPark
      ? Vector2(hoodStartFromParkX, hoodStartFromParkY)
      : Vector2(hoodStartFromRoomX, hoodStartFromRoomY);
  return playerStartPosit;
}

Vector2 getPlayerParkStartPosit() {
  return Vector2(parkStartX, parkStartY);
}

Vector2 getPlayerParkStartLookDir() {
  return Vector2(1, 0);
}

Vector2 getPlayerHoodStartLookDir() {
  return Vector2(0, 1);
}

Vector2 getPlayerTutorialStartLookDir() {
  return Vector2(1, 0);
}

bool checkMainQuestsCompleted(ProgressState state) {
  return state.qianBi >= completedCharInt &&
      state.risa >= completedCharInt &&
      state.asimov >= completedCharInt &&
      state.moon >= completedCharInt &&
      state.manuka >= completedCharInt &&
      state.stark >= completedCharInt;
}
