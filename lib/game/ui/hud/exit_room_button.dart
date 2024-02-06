import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';

class ExitRoomButton extends HudMarginComponent {
  ExitRoomButton({
    required Function switchScene,
    super.margin = const EdgeInsets.only(
      left: 700,
      top: 250,
    ),
  }) : super() {
    _switchScene = switchScene;
  }

  late Function _switchScene;

  @override
  Future<void> onLoad() async {
    final SpriteButtonComponent buttonSprite = SpriteButtonComponent(
        button: await Sprite.load(Assets.assets_images_ui_exit_button_png),
        buttonDown:
            await Sprite.load(Assets.assets_images_ui_exit_button_down_png),
        onPressed: () {
          _switchScene();
        });
    add(buttonSprite);
  }
}
