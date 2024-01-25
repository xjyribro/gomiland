import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/utils/load_images.dart';

class CoinsComponent extends HudMarginComponent {
  CoinsComponent({
    required GomilandGame game,
    super.margin = const EdgeInsets.only(
      left: 128,
      top: 32,
    ),
  }) : super() {
    _game = game;
  }

  late TextComponent _bagCountTextComponent;
  late GomilandGame _game;

  @override
  Future<void> onLoad() async {
    _bagCountTextComponent = TextComponent(
      text: '${_game.gameStateBloc.state.bagCount}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 20,
          fontFamily: Strings.minecraft,
        ),
      ),
      position: Vector2(32, 0),
      anchor: Anchor.centerLeft,
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
      position: Vector2(0, 0),
      size: Vector2(32, 32),
      anchor: Anchor.center,
    );

    add(animatedCoin);
  }

  @override
  void update(double dt) {
    _bagCountTextComponent.text = 'Coins';
  }
}
