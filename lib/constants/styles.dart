import 'package:flutter/material.dart';
import 'package:gomiland/constants/constants.dart';

class TextStyles {
  static const double smallTextSize = 20;
  static const double normalTextSize = 28;
  static const double headerTextSize = 36;
  static const dialogueTextStyle =
      TextStyle(fontFamily: Strings.minecraft, fontSize: normalTextSize);
  static const dialogueButtonsTextStyle =
      TextStyle(fontFamily: Strings.minecraft, fontSize: 24);
  static const hudTextStyle = TextStyle(
      color: Colors.white70, fontSize: 20, fontFamily: Strings.minecraft);
  static const menuBlackTextStyle = TextStyle(
    fontSize: normalTextSize,
    color: GameColors.black,
  );
  static const menuPurpleTextStyle = TextStyle(
    fontSize: normalTextSize,
    color: GameColors.purple,
  );
  static const menuWhiteTextStyle = TextStyle(
    fontSize: normalTextSize,
    color: GameColors.white,
  );
  static const menuGreenTextStyle = TextStyle(
    fontSize: normalTextSize,
    color: GameColors.green,
  );
  static const menuRedTextStyle = TextStyle(
    fontSize: normalTextSize,
    color: GameColors.red,
  );
  static const menuOrangeTextStyle = TextStyle(
    fontSize: normalTextSize,
    color: GameColors.orange,
  );
  static const mainHeaderTextStyle = TextStyle(
    fontSize: headerTextSize,
    color: GameColors.white,
  );
  static const creditsTextStyle = TextStyle(
    fontSize: smallTextSize,
    color: GameColors.white,
  );
  static const smallMenuTextStyle = TextStyle(
    fontSize: smallTextSize,
    color: GameColors.purple,
  );
  static const sendFriendRequestTextStyle = TextStyle(
    fontSize: smallTextSize,
    color: GameColors.green,
  );
  static const sendFriendRequestRedTextStyle = TextStyle(
    fontSize: smallTextSize,
    color: GameColors.red,
  );
  static const modalHeaderTextStyle = TextStyle(
      fontSize: headerTextSize,
      color: GameColors.black,
      fontWeight: FontWeight.bold);
  static const popupTextStyle = TextStyle(
    fontSize: infoPopupFontSize,
    color: Colors.black,
    fontFamily: Strings.minecraft,
  );
}

class ContainerStyles {
  static const gameMenuStyle = BoxDecoration(
    color: GameColors.black,
    borderRadius: BorderRadius.all(
      Radius.circular(64),
    ),
  );
}

class GameColors {
  static const black = Color.fromRGBO(0, 0, 0, 1.0);
  static const white = Color.fromRGBO(255, 255, 255, 1.0);
  static const purple = Color.fromRGBO(118, 48, 209, 1.0);
  static const green = Color.fromRGBO(57, 86, 41, 1.0);
  static const red = Color.fromRGBO(91, 23, 23, 1.0);
  static const orange = Color.fromRGBO(98, 73, 33, 1.0);
  static const whiteTranslucent = Color.fromRGBO(255, 255, 255, 0.5);
}
