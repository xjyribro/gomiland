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
import 'package:gomiland/game/uiComponents/dialogue_box.dart';
import 'package:gomiland/game/uiComponents/game_menu.dart';
import 'package:gomiland/game/uiComponents/hud/bag.dart';
import 'package:gomiland/game/uiComponents/hud/coins.dart';
import 'package:gomiland/game/uiComponents/hud/game_menu_button.dart';
import 'package:gomiland/game/uiComponents/mute_button.dart';
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
        'GameMenu': (BuildContext context, GomilandGame game) {
          return GameMenu(
            game: game,
          );
        },
        'MuteButton': (BuildContext context, GomilandGame game) {
          return const MuteButton();
        },
        'MobileKeypad': (BuildContext context, GomilandGame game) {
          return GameMenu(
            game: game,
          );
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
    cameraComponent = CameraComponent.withFixedResolution(
      world: world,
      width: 800,
      height: 400,
    );
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
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    debugMode = true;

    // UI
    final BagComponent bagComponent = BagComponent(game: this);
    final CoinsComponent coinsComponent = CoinsComponent(game: this);
    final GameMenuButton gameMenuButton = GameMenuButton();

    cameraComponent.viewport.addAll([
      coinsComponent,
      bagComponent,
      gameMenuButton,
    ]);

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
    yarnProject.parse(await rootBundle.loadString(Assets.assets_yarn_example_yarn));
    dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
  }
}
