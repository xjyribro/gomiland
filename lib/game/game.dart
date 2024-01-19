import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/scenes/gomiland_world.dart';
import 'package:gomiland/game/uiInterface/dialogue_box.dart';
import 'package:gomiland/game/uiInterface/mute_button.dart';

class GameWidgetWrapper extends StatelessWidget {
  const GameWidgetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: GomilandGame(gameStateBloc: context.read<GameStateBloc>()),
      overlayBuilderMap: {
        'MuteButton': (BuildContext context, GomilandGame game) {
          return const MuteButton();
        },
        'DialogueBox': (BuildContext context, GomilandGame game) {
          return const DialogueBox(text: 'abduabfbwiubiwreg');
        },
      },
    );
  }
}

class GomilandGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  GomilandGame({required this.gameStateBloc}) : world = GomilandWorld() {
    cameraComponent = CameraComponent(world: world);
    images.prefix = '';
  }

  @override
  World world;
  GameStateBloc gameStateBloc;
  late final CameraComponent cameraComponent;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      Assets.assets_images_player_player_png,
    ]);

    await add(
      FlameBlocProvider<GameStateBloc, GameState>.value(
        value: gameStateBloc,
        children: [cameraComponent, world],
      ),
    );

    debugMode = true;
  }
}
