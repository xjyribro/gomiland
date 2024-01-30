import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/game/game.dart';

class BagComponent extends HudMarginComponent {
  BagComponent({
    required GomilandGame game,
    super.margin = const EdgeInsets.only(
      left: 320,
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
      text:
          '${_game.gameStateBloc.state.bagCount} / ${_game.gameStateBloc.state.maxBagCount}',
      textRenderer: TextPaint(
        style: TextStyles.hudTextStyle,
      ),
      position: Vector2(32, 0),
      anchor: Anchor.centerLeft,
    );
    add(_bagCountTextComponent);

    final SpriteComponent bag = SpriteComponent(
      sprite: await Sprite.load(Assets.assets_images_ui_bag_png),
      anchor: Anchor.center,
    );
    add(bag);
  }

  @override
  void update(double dt) {
    _bagCountTextComponent.text =
        '${_game.gameStateBloc.state.bagCount} / ${_game.gameStateBloc.state.maxBagCount}';
  }
}
