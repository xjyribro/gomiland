import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/controllers/dialogue_controller.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/controllers/player_state.dart';
import 'package:gomiland/game/controllers/progress_state.dart';
import 'package:gomiland/game/gomiland_world.dart';
import 'package:gomiland/game/objects/rubbish_spawner.dart';
import 'package:gomiland/game/uiComponents/dialogue_box.dart';
import 'package:gomiland/game/uiComponents/game_menu.dart';
import 'package:gomiland/game/uiComponents/hud/bag.dart';
import 'package:gomiland/game/uiComponents/hud/clock.dart';
import 'package:gomiland/game/uiComponents/hud/coins.dart';
import 'package:gomiland/game/uiComponents/hud/e_button.dart';
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
        playerStateBloc: context.read<PlayerStateBloc>(),
        progressStateBloc: context.read<ProgressStateBloc>(),
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
    required this.playerStateBloc,
    required this.progressStateBloc,
  }) : world = GomilandWorld() {
    cameraComponent = CameraComponent.withFixedResolution(
      world: world,
      width: 800,
      height: 400,
    );
    images.prefix = '';
  }

  World world;
  GameStateBloc gameStateBloc;
  DialogueBloc dialogueBloc;
  PlayerStateBloc playerStateBloc;
  ProgressStateBloc progressStateBloc;
  late final CameraComponent cameraComponent;

  YarnProject yarnProject = YarnProject();
  late DialogueRunner dialogueRunner;
  DialogueControllerComponent dialogueControllerComponent =
      DialogueControllerComponent();
  late final JoystickComponent joystick;

  void castRay() {
    final Vector2 playerPosition = playerStateBloc.state.playerPosition;
    final Vector2 playerDirection = playerStateBloc.state.playerDirection;
    final isValid =
        playerPosition != Vector2.zero() && playerDirection != Vector2.zero();
    if (isValid) {
      RectangleHitbox? playerHitbox = playerStateBloc.state.playerHitbox;
      final ray = Ray2(
        origin: playerPosition + Vector2.all(16),
        direction: playerDirection,
      );
      final result = collisionDetection.raycast(
        ray,
        maxDistance: 40,
        ignoreHitboxes: playerHitbox != null ? [playerHitbox] : null,
      );
      if (result != null && result.hitbox != null) {
        final Component? parent = result.hitbox!.parent;
        if (parent != null) {
          if (parent is RubbishSpawner) {
            parent.pickupRubbish();
          }
        }
      }
    }
  }

  @override
  Future<void> onLoad() async {
    debugMode = true;

    // IMAGES
    await images.loadAll([
      Assets.assets_images_player_player_png,
    ]);

    // UI
    final BagComponent bagComponent = BagComponent(game: this);
    final CoinsComponent coinsComponent = CoinsComponent(game: this);
    final ClockComponent clockComponent = ClockComponent(game: this);
    final GameMenuButton gameMenuButton = GameMenuButton();
    final EButton eButton = EButton(game: this);

    cameraComponent.viewport.addAll([
      coinsComponent,
      bagComponent,
      clockComponent,
      gameMenuButton,
      eButton
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

    // DIALOGUE
    yarnProject
        .parse(await rootBundle.loadString(Assets.assets_yarn_example_yarn));
    dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
  }
}
