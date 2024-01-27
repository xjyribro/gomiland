import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/objects/lights/park_light.dart';
import 'package:gomiland/game/objects/obsticle.dart';
import 'package:gomiland/game/objects/rubbish_spawner.dart';
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
    Sounds.playParkBgm();
    final TiledComponent map = await TiledComponent.load(
      'park.tmx',
      Vector2.all(tileSize),
    );
    await add(map);

    await _loadPlayer(_playerStartPosit);

    final objectLayer = map.tileMap.getLayer<ObjectGroup>('gates');

    if (objectLayer != null) {
      for (final TiledObject object in objectLayer.objects) {
        print(Vector2(object.x, object.y));
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

    final obstacles = map.tileMap.getLayer<ObjectGroup>('obstacles');

    if (obstacles != null) {
      for (final TiledObject obstacle in obstacles.objects) {
        add(Obstacle(
          position: Vector2(obstacle.x, obstacle.y),
          size: Vector2(obstacle.width, obstacle.height),
        ));
      }
    }
  }
}
