import 'dart:math';

import 'package:flame/components.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/game/data/other_player.dart';

Vector2 getPlayerHoodStartPosit(bool comingFromPark) {
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

Vector2 getPlayerHoodStartLookDir(bool comingFromPark) {
  return comingFromPark ? Vector2(0, 1) : Vector2(-1, 0);
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

bool checkFriendMainQuestsCompleted(OtherPlayer playerInfo) {
  return playerInfo.qianBi >= completedCharInt &&
      playerInfo.risa >= completedCharInt &&
      playerInfo.asimov >= completedCharInt &&
      playerInfo.moon >= completedCharInt &&
      playerInfo.manuka >= completedCharInt &&
      playerInfo.stark >= completedCharInt;
}

String pickRandKey(Map<String, OtherPlayer> friends) {
  return friends.keys.elementAt(Random().nextInt(friends.length));
}
