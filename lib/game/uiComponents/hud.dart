import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/utils/load_images.dart';

class Hud extends PositionComponent with HasGameReference<GomilandGame> {
  Hud({super.priority = 3});

  late TextComponent _bagCountTextComponent;

  @override
  Future<void> onLoad() async {
    _bagCountTextComponent = TextComponent(
      text: '${game.gameStateBloc.state.bagCount}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          fontFamily: Strings.minecraft,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x - 60, 20),
    );
    add(_bagCountTextComponent);

    final spriteSheet = SpriteSheet(
      image: await LoadImage('assets/images/spritesheets/coin_small.png'),
      srcSize: Vector2(32, 32),
    );

    final coinAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 6);

    final animatedCoin = SpriteAnimationComponent(
      animation: coinAnimation,
      position: Vector2(150, 100),
      size: Vector2(32, 32),
    );

    add(animatedCoin);
  }

  @override
  void update(double dt) {
    _bagCountTextComponent.text = 'hhhhhh';
  }
}
