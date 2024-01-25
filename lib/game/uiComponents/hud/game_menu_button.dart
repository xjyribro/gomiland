import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';

class GameMenuButton extends HudButtonComponent {
  GameMenuButton({
    super.margin = const EdgeInsets.only(
      right: 96,
      top: 16,
    ),
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();
    button = SpriteButtonComponent(
      button: await Sprite.load(Assets.assets_images_ui_menu_button_png),
      onPressed: () {
        Sounds.pauseBackgroundSound();
        game.pauseEngine();
        game.overlays.add('GameMenu');
      },
      buttonDown:
          await Sprite.load(Assets.assets_images_ui_menu_button_down_png),
    );
  }
}
