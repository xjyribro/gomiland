import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/ui/hud/mini_map.dart';

class MiniMapButton extends HudMarginComponent with HasGameReference<GomilandGame> {
  MiniMapButton({super.margin = const EdgeInsets.only(left: 64, top: 250)});

  @override
  Future<void> onLoad() async {
    final SpriteButtonComponent buttonSprite = SpriteButtonComponent(
      button: await Sprite.load(Assets.assets_images_ui_map_button_png),
      onPressed: () {
        game.cameraComponent.viewport.add(MiniMap());
      },
    );
    add(buttonSprite);
  }
}
