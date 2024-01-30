import 'package:flutter/material.dart';
import 'package:gomiland/constants/constants.dart';

class TextStyles {
  static const dialogueTextStyle =
      TextStyle(fontFamily: Strings.minecraft, fontSize: 28);
  static const dialogueButtonsTextStyle =
  TextStyle(fontFamily: Strings.minecraft, fontSize: 24);
  static const hudTextStyle = TextStyle(
      color: Colors.white70, fontSize: 20, fontFamily: Strings.minecraft);
  static const mainMenuTextStyle = TextStyle(
    fontSize: 24,
    color: GameColors.blackTextColor,
  );
}

class GameColors{
  static const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
  static const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);
  static const whiteTranslucent = Color.fromRGBO(255, 255, 255, 0.5);
}
