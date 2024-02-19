import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/audio_controller.dart';
import 'package:gomiland/controllers/day_controller.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/game/gomiland_world.dart';
import 'package:gomiland/game/npcs/npc.dart';
import 'package:gomiland/game/objects/rubbish_spawner.dart';
import 'package:gomiland/game/objects/sign.dart';
import 'package:gomiland/game/scenes/scene_name.dart';
import 'package:gomiland/game/ui/confirm_exit_game.dart';
import 'package:gomiland/game/ui/confirm_exit_room.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:gomiland/game/ui/game_menu.dart';
import 'package:gomiland/game/ui/hud/a_button.dart';
import 'package:gomiland/game/ui/hud/bag.dart';
import 'package:gomiland/game/ui/hud/brightness.dart';
import 'package:gomiland/game/ui/hud/clock.dart';
import 'package:gomiland/game/ui/hud/coins.dart';
import 'package:gomiland/game/ui/hud/game_menu_button.dart';
import 'package:gomiland/game/ui/loading_overlay.dart';
import 'package:gomiland/game/ui/mute_button.dart';

class GameWidgetWrapper extends StatelessWidget {
  final bool loadFromSave;

  const GameWidgetWrapper({super.key, required this.loadFromSave});

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
              playerStateBloc: context.read<PlayerStateBloc>(),
              progressStateBloc: context.read<ProgressStateBloc>(),
              dayStateBloc: context.read<DayStateBloc>(),
              loadFromSave: loadFromSave,
            ),
            overlayBuilderMap: {
              'Loading': (BuildContext context, GomilandGame game) {
                return const LoadingOverlay();
              },
              'ConfirmExitRoom': (BuildContext context, GomilandGame game) {
                return ConfirmExitRoom(game: game);
              },
              'GameMenu': (BuildContext context, GomilandGame game) {
                return GameMenu(game: game);
              },
              'ConfirmExitGame': (BuildContext context, GomilandGame game) {
                return ConfirmExitGame(game: game);
              },
              'MuteButton': (BuildContext context, GomilandGame game) {
                return const MuteButton();
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
    required this.playerStateBloc,
    required this.progressStateBloc,
    required this.dayStateBloc,
    required this.loadFromSave,
  }) : world = GomilandWorld(loadFromSave: loadFromSave) {
    cameraComponent = CameraComponent.withFixedResolution(
      world: world,
      width: viewportWidth,
      height: viewportHeight,
    );
    images.prefix = '';
  }

  @override
  World world;
  GameStateBloc gameStateBloc;
  PlayerStateBloc playerStateBloc;
  ProgressStateBloc progressStateBloc;
  DayStateBloc dayStateBloc;
  bool loadFromSave;
  late final CameraComponent cameraComponent;

  final BrightnessOverlay brightnessOverlay = BrightnessOverlay();
  late final AButton _aButton;
  late final JoystickComponent joystick;

  DialogueControllerComponent dialogueControllerComponent =
      DialogueControllerComponent();

  void goToHoodScene() {
    GomilandWorld gWorld = world as GomilandWorld;
    gWorld.setNewSceneName(SceneName.hood);
  }

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
          bool isMute = gameStateBloc.state.isMute;
          if (parent is RubbishSpawner) {
            parent.pickupRubbish();
          }
          if (parent is Npc) {
            if (!isMute) Sounds.next();
            parent.startConversation(playerPosition);
          }
          if (parent is Sign) {
            if (!isMute) Sounds.next();
            parent.readSign();
          }
        }
      }
    }
  }

  void addHudComponentsForWorld() {
    List<BrightnessOverlay> brightnessOverlays =
        cameraComponent.viewport.children.query<BrightnessOverlay>();
    if (brightnessOverlays.isEmpty) {
      cameraComponent.viewport.add(brightnessOverlay);
    }
    if (gameStateBloc.state.showControls) {
      _addPlayerControls();
    }
  }

  void _addPlayerControls() {
    List<AButton> aButtons = cameraComponent.viewport.children.query<AButton>();
    if (aButtons.isEmpty) {
      cameraComponent.viewport.add(_aButton);
    }
    List<JoystickComponent> joysticks =
        cameraComponent.viewport.children.query<JoystickComponent>();
    if (joysticks.isEmpty) {
      cameraComponent.viewport.add(joystick);
    }
  }

  void removeHudComponentsForWorld() {
    List<BrightnessOverlay> brightnessOverlays =
        cameraComponent.viewport.children.query<BrightnessOverlay>();
    if (brightnessOverlays.isNotEmpty) {
      cameraComponent.viewport.remove(brightnessOverlay);
    }
    List<AButton> aButtons = cameraComponent.viewport.children.query<AButton>();
    if (aButtons.isNotEmpty) {
      cameraComponent.viewport.remove(_aButton);
    }
    List<JoystickComponent> joysticks =
        cameraComponent.viewport.children.query<JoystickComponent>();
    if (joysticks.isNotEmpty) {
      cameraComponent.viewport.removeAll(joysticks);
    }
  }

  void freezePlayer() {
    gameStateBloc.add(const PlayerFrozen(true));
  }

  void unfreezePlayer() {
    gameStateBloc.add(const PlayerFrozen(false));
  }

  bool playerIsFrozen() {
    return gameStateBloc.state.playerFrozen;
  }

  @override
  Future<void> onLoad() async {
    debugMode = isDebugMode;

    // UI
    final RectangleComponent hudTranslucent = RectangleComponent(
      size: Vector2(size.x, 96),
      paint: Paint()..color = const Color.fromARGB(32, 255, 255, 255),
    );
    final BagComponent bagComponent = BagComponent(game: this);
    final CoinsComponent coinsComponent = CoinsComponent(game: this);
    final ClockComponent clockComponent = ClockComponent(
      game: this,
      loadFromSave: loadFromSave,
    );
    final GameMenuButton gameMenuButton = GameMenuButton();
    _aButton = AButton(game: this);
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: await Sprite.load(Assets.assets_images_ui_directional_knob_png),
        size: Vector2.all(128),
      ),
      background: SpriteComponent(
        sprite: await Sprite.load(Assets.assets_images_ui_directional_pad_png),
        size: Vector2.all(128),
      ),
      margin: const EdgeInsets.only(left: 40, top: 240),
    );

    cameraComponent.viewport.addAll([
      coinsComponent,
      bagComponent,
      clockComponent,
      gameMenuButton,
      hudTranslucent,
      FpsTextComponent(), //TODO remove this
    ]);

    addAll([
      world,
      cameraComponent,
      dialogueControllerComponent,
    ]);
  }
}
