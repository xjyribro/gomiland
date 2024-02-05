import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/styles.dart';
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

  late TextComponent _coinCountTextComponent;
  late GomilandGame _game;

  @override
  Future<void> onLoad() async {
    _coinCountTextComponent = TextComponent(
      text: '',
      textRenderer: TextPaint(
        style: TextStyles.hudTextStyle,
      ),
      position: Vector2(32, 0),
      anchor: Anchor.centerLeft,
    );
    add(_coinCountTextComponent);

    final spriteSheet = SpriteSheet(
      image: await LoadImage(Assets.assets_images_spritesheets_coin_small_png),
      srcSize: Vector2(32, 32),
    );

    final coinAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: stepTime,
      to: 6,
    );

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
    _coinCountTextComponent.text = 'Coins: ${_game.gameStateBloc.state.coinAmount}';
  }
}
