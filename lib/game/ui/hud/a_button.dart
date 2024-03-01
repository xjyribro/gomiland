import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/game.dart';

class AButton extends HudMarginComponent{
  AButton({
    required GomilandGame game,
    super.margin = const EdgeInsets.only(
      left: 700,
      top: 250,
    ),
    super.priority = 1,
  }) : super() {
    _game = game;
  }

  late GomilandGame _game;

  @override
  Future<void> onLoad() async {
    final SpriteButtonComponent buttonSprite = SpriteButtonComponent(
        button: await Sprite.load(Assets.assets_images_ui_a_button_png),
        buttonDown: await Sprite.load(Assets.assets_images_ui_a_button_down_png),
        onPressed: () {
          if (_game.playerIsFrozen()) return;
          _game.castRay();
         });
    add(buttonSprite);
  }
}
