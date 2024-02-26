import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/game.dart';

class MapButton extends HudMarginComponent
    with HasGameReference<GomilandGame> {
  MapButton({
    required Function leaveRoomCheck,
    super.margin = const EdgeInsets.only(
      left: 64,
      top: 250,
    ),
  });

  @override
  Future<void> onLoad() async {
    final SpriteButtonComponent buttonSprite = SpriteButtonComponent(
      button: await Sprite.load(Assets.assets_images_ui_exit_button_png),
      buttonDown:
          await Sprite.load(Assets.assets_images_ui_exit_button_down_png),
      onPressed: () {
        game.overlays.add('MiniMap');
      },
    );
    add(buttonSprite);
  }
}
