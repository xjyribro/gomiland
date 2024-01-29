import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/game.dart';

class EButton extends HudMarginComponent with HasGameReference<GomilandGame> {
  EButton({
    required GomilandGame game,
    super.margin = const EdgeInsets.only(
      right: 320,
      bottom: 160,
    ),
  }) : super() {
    _game = game;
  }

  late GomilandGame _game;

  @override
  Future<void> onLoad() async {
    final SpriteButtonComponent bag = SpriteButtonComponent(
        button: await Sprite.load(Assets.assets_images_ui_bag_png),
        onPressed: () {
          _game.castRay();
        });
    add(bag);
  }
}
