// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gomiland/contants.dart';

class GameState extends ChangeNotifier {

  double _gameTime = 0;

  int _coinAmount = 0;

  SceneName _sceneName = SceneName.MENU;

  double get gameTime => _gameTime;
  int get coinAmount => _coinAmount;
  SceneName get sceneName => _sceneName;

  void setGameTime(double gameTime) {
    _gameTime = gameTime;
    notifyListeners();
  }

  void setCoinAmount(int coinAmount) {
    _coinAmount = coinAmount;
    notifyListeners();
  }

  void setSceneName(SceneName sceneName) {
    _sceneName = sceneName;
    notifyListeners();
  }
}