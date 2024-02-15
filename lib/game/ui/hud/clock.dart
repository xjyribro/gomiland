import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/game/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/game/data/days_of_week.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/gomiland_world.dart';
import 'package:gomiland/game/scenes/scene_name.dart';

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
  late TextComponent _dayTextComponent;
  late GomilandGame _game;
  double _seconds = 0;
  int _gameMins = gameStartTime;

  @override
  Future<void> onLoad() async {
    _timeTextComponent = TextComponent(
      text: '',
      textRenderer: TextPaint(
        style: TextStyles.hudTextStyle,
      ),
      position: Vector2(32, 0),
      anchor: Anchor.centerLeft,
    );
    int daysInGame = _game.gameStateBloc.state.daysInGame;
    _dayTextComponent = TextComponent(
      text: getDayFromInt(daysInGame),
      textRenderer: TextPaint(
        style: TextStyles.hudTextStyle,
      ),
      position: Vector2(32, 32),
      anchor: Anchor.centerLeft,
    );
    addAll([_timeTextComponent, _dayTextComponent]);

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
      _game.gameStateBloc.add(const AddOneMin());
    }
    if (_gameMins == eveningStartMins) {
      _game.brightnessOverlay.makeEveningDim();
      if (_game.world is GomilandWorld) {
        GomilandWorld world = _game.world as GomilandWorld;
        if (_game.gameStateBloc.state.sceneName == SceneName.hood) {
          world.hoodMap.turnOnLights();
        }
        if (_game.gameStateBloc.state.sceneName == SceneName.park) {
          world.parkMap.turnOnLights();
        }
      }
    }
    if (_gameMins == nightStartMins) {
      int daysInGame = _game.gameStateBloc.state.daysInGame;
      _dayTextComponent.text = getDayFromInt(daysInGame + 1);
      _game.brightnessOverlay.makeNightDim();
      _game.gameStateBloc.add(const IncreaseDays());
    }
    if (_gameMins == morningStartMins) {
      _game.brightnessOverlay.removeNightDim();
      if (_game.world is GomilandWorld) {
        GomilandWorld world = _game.world as GomilandWorld;
        if (_game.gameStateBloc.state.sceneName == SceneName.hood) {
          world.hoodMap.turnOffLights();
        }
        if (_game.gameStateBloc.state.sceneName == SceneName.park) {
          world.parkMap.turnOffLights();
        }
      }
    }
    final int hours = (_gameMins / 60).floor();
    final int mins = _gameMins % 60;
    final String hourString = hours.toString().padLeft(2, "0");
    final String minString = mins.toString().padLeft(2, "0");
    _timeTextComponent.text = '$hourString: $minString';
  }
}
