import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/monk.dart';
import 'package:gomiland/game/objects/lights/park_light.dart';
import 'package:gomiland/game/objects/obsticle.dart';
import 'package:gomiland/game/objects/rubbish_spawner.dart';
import 'package:gomiland/game/objects/trees/bamboo.dart';
import 'package:gomiland/game/player/player.dart';
import 'package:gomiland/game/scenes/gate.dart';

class ParkMap extends Component with HasGameReference<GomilandGame> {
  late Function _setNewSceneName;
  late Vector2 _playerStartPosit;

  ParkMap({
    required Function setNewSceneName,
    required Vector2 playerStartPosit,
  }) : super() {
    _setNewSceneName = setNewSceneName;
    _playerStartPosit = playerStartPosit;
  }

  Future<void> _loadPlayer(Vector2 position) async {
    JoystickComponent? joystick = kIsWeb
        ? null
        : JoystickComponent(
            knob: SpriteComponent(
              sprite: await Sprite.load(
                  Assets.assets_images_ui_directional_knob_png),
              size: Vector2.all(64),
            ),
            background: SpriteComponent(
              sprite: await Sprite.load(
                  Assets.assets_images_ui_directional_pad_png),
              size: Vector2.all(96),
            ),
            margin: const EdgeInsets.only(left: 40, bottom: 40),
          );

    Player player = Player(
      position: position,
      joystickComponent: joystick,
    );
    if (joystick != null) {
      game.cameraComponent.viewport.add(joystick);
    }
    await add(player);
    game.cameraComponent.follow(player);
  }

  @override
  Future<void> onLoad() async {

    final bool isMute = game.gameStateBloc.state.isMute;
    if (!isMute) {
      Sounds.playParkBgm();
    }
    final TiledComponent map = await TiledComponent.load(
      'park.tmx',
      Vector2.all(tileSize),
    );
    await add(map);

    await _loadPlayer(_playerStartPosit);

    final obstacles = map.tileMap.getLayer<ObjectGroup>('obstacles');

    if (obstacles != null) {
      for (final TiledObject obstacle in obstacles.objects) {
        add(Obstacle(
          position: Vector2(obstacle.x, obstacle.y),
          size: Vector2(obstacle.width, obstacle.height),
        ));
      }
    }

    final gates = map.tileMap.getLayer<ObjectGroup>('gates');

    if (gates != null) {
      for (final TiledObject object in gates.objects) {
        await add(
          Gate(
            position: Vector2(object.x, object.y),
            size: Vector2(object.width, object.height),
            switchScene: () {
              _setNewSceneName(SceneName.hood);
            },
          ),
        );
      }
    }

    final npcs = map.tileMap.getLayer<ObjectGroup>('npc');

    if (npcs != null) {
      for (final TiledObject npc in npcs.objects) {
        switch (npc.name) {
          case 'monk':
            await add(
              Monk(
                position: Vector2(npc.x, npc.y),
              ),
            );
            break;
        }
      }
    }

    final buildings = map.tileMap.getLayer<ObjectGroup>('buildings');

    if (buildings != null) {
      for (final TiledObject building in buildings.objects) {
        switch (building.name) {}
      }
    }

    final trees = map.tileMap.getLayer<ObjectGroup>('trees');

    if (trees != null) {
      for (final TiledObject tree in trees.objects) {
        switch (tree.name) {
          case 'bamboo':
            await add(
              Bamboo(
                position: Vector2(tree.x, tree.y),
                size: Vector2(tree.width, tree.height),
              ),
            );
            break;
        }
      }
    }

    final spawners = map.tileMap.getLayer<ObjectGroup>('spawners');

    if (spawners != null) {
      for (final TiledObject spawner in spawners.objects) {
        await add(
          RubbishSpawner(
            position: Vector2(spawner.x, spawner.y),
          ),
        );
      }
    }

    final lights = map.tileMap.getLayer<ObjectGroup>('lights');

    if (lights != null) {
      for (final TiledObject lights in lights.objects) {
        ParkLight streetLight = ParkLight(
          position: Vector2(lights.x, lights.y),
          size: Vector2(lights.width, lights.height),
        );
        await add(streetLight);
      }
    }
  }
}
