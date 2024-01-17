// ignore_for_file: file_names

import 'package:flutter/material.dart';

class GameState extends ChangeNotifier {

  double _gameTime = 0;

  int _coinAmount = 0;

  double get gameTime => _gameTime;
  int get coinAmount => _coinAmount;

  void setGameTime(double gameTime) {
    _gameTime = gameTime;
  }

  void setCoinAmount(int coinAmount) {
    _coinAmount = coinAmount;
  }
}