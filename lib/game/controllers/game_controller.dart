// ignore_for_file: constant_identifier_names

import 'package:bonfire/bonfire.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/game/dialogues/game_menu.dart';

class GameController extends GameComponent with KeyboardEventListener{
  bool _isPaused = false;
  // time
  // item count

  void setPaused(bool isPaused) {
    _isPaused = isPaused;
  }

  @override
  void update(double dt) {
    if (_isPaused) {

    }
    super.update(dt);
  }

  @override
  bool onKeyboard(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.isNotEmpty) {
      if (keysPressed.first.keyId == KeyCode.SPACE) {
        GameMenu.showGameMenu(context);
      }
    }
    return super.onKeyboard(event,keysPressed);
  }
}

class KeyCode {
  static const SPACE = 32;
}