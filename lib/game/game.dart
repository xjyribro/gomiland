import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/controllers/day_controller.dart';
import 'package:gomiland/game/controllers/dialogue_controller.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/controllers/player_state.dart';
import 'package:gomiland/game/controllers/progress_state.dart';
import 'package:gomiland/game/gomiland_world.dart';
import 'package:gomiland/game/npcs/qian_bi.dart';
import 'package:gomiland/game/objects/rubbish_spawner.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_box.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:gomiland/game/ui/game_menu.dart';
import 'package:gomiland/game/ui/hud/a_button.dart';
import 'package:gomiland/game/ui/hud/bag.dart';
import 'package:gomiland/game/ui/hud/brightness.dart';
import 'package:gomiland/game/ui/hud/clock.dart';
import 'package:gomiland/game/ui/hud/coins.dart';
import 'package:gomiland/game/ui/hud/game_menu_button.dart';
import 'package:gomiland/game/ui/mute_button.dart';

class GameWidgetWrapper extends StatelessWidget {
  const GameWidgetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRect(
        child: SizedBox(
          width: gameWidth,
          height: gameHeight,
          child: GameWidget(
            game: GomilandGame(
              gameStateBloc: context.read<GameStateBloc>(),
              dialogueBloc: context.read<DialogueBloc>(),
              playerStateBloc: context.read<PlayerStateBloc>(),
              progressStateBloc: context.read<ProgressStateBloc>(),
              dayStateBloc: context.read<DayStateBloc>(),
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
                return DialogueBox(game: game);
              },
            },
          ),
        ),
      ),
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
    required this.dayStateBloc,
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
  PlayerStateBloc playerStateBloc;
  ProgressStateBloc progressStateBloc;
  DayStateBloc dayStateBloc;
  late final CameraComponent cameraComponent;
  final BrightnessOverlay brightnessOverlay = BrightnessOverlay();

  DialogueControllerComponent dialogueControllerComponent =
      DialogueControllerComponent();

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
        maxDistance: maxRaycastDist,
        ignoreHitboxes: playerHitbox != null ? [playerHitbox] : null,
      );
      if (result != null && result.hitbox != null) {
        final Component? parent = result.hitbox!.parent;
        if (parent != null) {
          if (parent is RubbishSpawner) {
            parent.pickupRubbish();
          }
          if (parent is QianBi) {
            parent.startConversation(playerPosition);
          }
          // if (parent is Sign) {
          //   parent.pickupRubbish();
          // }
        }
      }
    }
  }

  @override
  Future<void> onLoad() async {
    debugMode = isDebugMode;
    await images.loadAll([
      Assets.assets_images_player_player_png,
    ]);

    // UI
    final RectangleComponent hudTranslucent = RectangleComponent(
      size: Vector2(size.x, 96),
      paint: Paint()..color = const Color.fromARGB(32, 255, 255, 255),
    );
    final BagComponent bagComponent = BagComponent(game: this);
    final CoinsComponent coinsComponent = CoinsComponent(game: this);
    final ClockComponent clockComponent = ClockComponent(game: this);
    final GameMenuButton gameMenuButton = GameMenuButton();
    final AButton eButton = AButton(game: this);

    cameraComponent.viewport.addAll([
      hudTranslucent,
      coinsComponent,
      bagComponent,
      clockComponent,
      gameMenuButton,
      eButton,
      brightnessOverlay,
      FpsTextComponent(), //TODO remove this
    ]);

    await addAll([
      world,
      cameraComponent,
      dialogueControllerComponent,
    ]);
    dialogueBloc.add(ChangeDialogueController(dialogueControllerComponent));
  }
}
