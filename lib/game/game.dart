import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/controllers/dialogue_controller.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/scenes/gomiland_world.dart';
import 'package:gomiland/game/uiInterface/dialogue_box.dart';
import 'package:gomiland/game/uiInterface/mute_button.dart';
import 'package:jenny/jenny.dart';

class GameWidgetWrapper extends StatelessWidget {
  const GameWidgetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: GomilandGame(
        gameStateBloc: context.read<GameStateBloc>(),
        dialogueBloc: context.read<DialogueBloc>(),
      ),
      overlayBuilderMap: {
        'MuteButton': (BuildContext context, GomilandGame game) {
          return const MuteButton();
        },
        'DialogueBox': (BuildContext context, GomilandGame game) {
          return const DialogueBox();
        },
      },
    );
  }
}

class GomilandGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  GomilandGame({
    required this.gameStateBloc,
    required this.dialogueBloc,
  }) : world = GomilandWorld() {
    cameraComponent = CameraComponent(world: world);
    images.prefix = '';
  }

  @override
  World world;
  GameStateBloc gameStateBloc;
  DialogueBloc dialogueBloc;
  late final CameraComponent cameraComponent;

  YarnProject yarnProject = YarnProject();
  late DialogueRunner dialogueRunner;
  DialogueControllerComponent dialogueControllerComponent =
      DialogueControllerComponent();

  @override
  Future<void> onLoad() async {
    debugMode = true;

    // BLOC
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameStateBloc, GameState>.value(
            value: gameStateBloc,
          ),
          FlameBlocProvider<DialogueBloc, DialogueState>.value(
            value: dialogueBloc,
          ),
        ],
        children: [
          cameraComponent,
          world,
        ],
      ),
    );

    // IMAGES
    await images.loadAll([
      Assets.assets_images_player_player_png,
    ]);

    // DIALOGUE
    yarnProject
      ..parse(await rootBundle.loadString('assets/yarn/example.yarn'));
    dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
    add(dialogueControllerComponent);
  }
}
