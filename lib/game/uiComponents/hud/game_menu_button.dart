import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';

class GameMenuButton extends HudButtonComponent {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    button = SpriteButtonComponent(
      button: await Sprite.load(Assets.assets_images_ui_menu_button_png),
      onPressed: () {
        game.pauseEngine();
        game.overlays.add('GameMenu');
      },
      buttonDown: await Sprite.load(Assets.assets_images_ui_menu_button_down_png),
    );
    margin = const EdgeInsets.fromLTRB(64, 16, 0, 0);
  }
}
