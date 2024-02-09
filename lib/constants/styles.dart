import 'package:flutter/material.dart';
import 'package:gomiland/constants/constants.dart';

class TextStyles {
  static const dialogueTextStyle =
      TextStyle(fontFamily: Strings.minecraft, fontSize: 28);
  static const dialogueButtonsTextStyle =
  TextStyle(fontFamily: Strings.minecraft, fontSize: 24);
  static const hudTextStyle = TextStyle(
      color: Colors.white70, fontSize: 20, fontFamily: Strings.minecraft);
  static const menuBlackTextStyle = TextStyle(
    fontSize: 24,
    color: GameColors.blackTextColor,
  );
  static const menuPurpleTextStyle = TextStyle(
    fontSize: 24,
    color: GameColors.purpleTextColor,
  );
  static const menuWhiteTextStyle = TextStyle(
    fontSize: 24,
    color: GameColors.whiteTextColor,
  );
  static const menuGreenTextStyle = TextStyle(
    fontSize: 24,
    color: GameColors.greenTextColor,
  );
  static const menuRedTextStyle = TextStyle(
    fontSize: 24,
    color: GameColors.redTextColor,
  );
  static const mainHeaderTextStyle = TextStyle(
    fontSize: 36,
    color: GameColors.whiteTextColor,
  );
}

class GameColors{
  static const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
  static const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);
  static const purpleTextColor = Color.fromRGBO(132, 54, 227, 1.0);
  static const greenTextColor = Color.fromRGBO(57, 86, 41, 1.0);
  static const redTextColor = Color.fromRGBO(91, 23, 23, 1.0);
  static const whiteTranslucent = Color.fromRGBO(255, 255, 255, 0.5);
}
