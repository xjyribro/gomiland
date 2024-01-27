import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';

class ClockComponent extends HudMarginComponent {
  ClockComponent({
    required GomilandGame game,
    super.margin = const EdgeInsets.only(
      left: 518,
      top: 32,
    ),
  }) : super() {
    _game = game;
  }

  late TextComponent _timeTextComponent;
  late GomilandGame _game;
  double _seconds = 0;
  int _gameMins = 0;

  @override
  Future<void> onLoad() async {
    _timeTextComponent = TextComponent(
      text: '00: 00',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 20,
          fontFamily: Strings.minecraft,
        ),
      ),
      position: Vector2(32, 0),
      anchor: Anchor.centerLeft,
    );
    add(_timeTextComponent);

    final SpriteComponent clock = SpriteComponent(
      sprite: await Sprite.load(Assets.assets_images_ui_clock_png),
      anchor: Anchor.center,
    );
    add(clock);
  }

  @override
  void update(double dt) {
    _seconds += dt;
    if (_seconds > gameMinToRealSecond) {
      _seconds = 0;
      _gameMins += 1;
      if (_gameMins > minsInADay) {
        _gameMins = 0;
      }
      _game.gameStateBloc.add(MinuteChanged(_gameMins));
    }
    final int hours = (_gameMins / 60).floor();
    final int mins = _gameMins % 60;
    final String hourString = hours.toString().padLeft(2, "0");
    final String minString = mins.toString().padLeft(2, "0");
    _timeTextComponent.text = '$hourString: $minString';
  }
}