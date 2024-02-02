import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_utils/flame_tiled_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/monk.dart';
import 'package:gomiland/game/objects/buildings/temizuya.dart';
import 'package:gomiland/game/objects/lights/park_light.dart';
import 'package:gomiland/game/objects/lights/stone_light.dart';
import 'package:gomiland/game/objects/obsticle.dart';
import 'package:gomiland/game/objects/rubbish_spawner.dart';
import 'package:gomiland/game/objects/trees/bamboo.dart';
import 'package:gomiland/game/objects/trees/tree_bonsai.dart';
import 'package:gomiland/game/objects/trees/tree_fluffy.dart';
import 'package:gomiland/game/objects/trees/tree_normal.dart';
import 'package:gomiland/game/objects/trees/tree_popsicle.dart';
import 'package:gomiland/game/objects/trees/tree_sakura.dart';
import 'package:gomiland/game/objects/trees/tree_spiky.dart';
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

  void turnOnLights() {
    List<ParkLight> streetLights = children.query<ParkLight>();
    for (ParkLight light in streetLights) {
      light.addLight();
    }
    List<StoneLight> stoneLights = children.query<StoneLight>();
    for (StoneLight light in stoneLights) {
      light.addLight();
    }
  }

  void turnOffLights() {
    List<ParkLight> streetLights = children.query<ParkLight>();
    for (ParkLight light in streetLights) {
      light.removeLight();
    }
    List<StoneLight> stoneLights = children.query<StoneLight>();
    for (StoneLight light in stoneLights) {
      light.removeLight();
    }
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
    add(map);
    // final mapComponent = await TiledComponent.load('park.tmx', Vector2.all(32));
    // final imageCompiler = ImageBatchCompiler();
    // final ground = imageCompiler
    //     .compileMapLayer(tileMap: mapComponent.tileMap, layerNames: [
    //   'water',
    //   'sand',
    //   'bridge',
    //   'pavement',
    //   'grass',
    //   'overlays',
    //   'barriers',
    // ]);
    // add(ground);

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

    await _loadPlayer(_playerStartPosit);

    final npcs = map.tileMap.getLayer<ObjectGroup>('npc');
    if (npcs != null) {
      _loadNpcs(npcs);
    }

    final buildings = map.tileMap.getLayer<ObjectGroup>('buildings');
    if (buildings != null) {
      _loadBuildings(buildings);
    }

    final trees = map.tileMap.getLayer<ObjectGroup>('trees');
    if (trees != null) {
      _loadTrees(trees);
    }

    final lights = map.tileMap.getLayer<ObjectGroup>('lights');
    if (lights != null) {
      bool shouldAddLight =
          game.gameStateBloc.state.minutes > eveningStartMins ||
              game.gameStateBloc.state.minutes < morningStartMins;
      for (final TiledObject light in lights.objects) {
        if (light.name == 'park_light') {
          ParkLight parkLight = ParkLight(
            position: Vector2(light.x, light.y),
            size: Vector2(light.width, light.height),
            shouldAddLight: shouldAddLight,
          );
          await add(parkLight);
        }
        if (light.name == 'stone_light') {
          StoneLight stoneLight = StoneLight(
            position: Vector2(light.x, light.y),
            size: Vector2(light.width, light.height),
            shouldAddLight: shouldAddLight,
          );
          await add(stoneLight);
        }
      }
    }
  }

  Future<void> _loadTrees(ObjectGroup trees) async {
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
        case 'tree_bonsai':
          await add(
            TreeBonsai(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
            ),
          );
          break;
        case 'tree_fluffy':
          await add(
            TreeFluffy(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
            ),
          );
          break;
        case 'tree_normal':
          await add(
            TreeNormal(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
            ),
          );
          break;
        case 'tree_popsicle':
          await add(
            TreePopsicle(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
            ),
          );
          break;
        case 'tree_sakura':
          await add(
            Sakura(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
            ),
          );
          break;
        case 'tree_spiky':
          await add(
            TreeSpiky(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
            ),
          );
          break;
      }
    }
  }

  Future<void> _loadBuildings(ObjectGroup buildings) async {
    for (final TiledObject building in buildings.objects) {
      switch (building.name) {
        case 'temizuya':
          await add(
            Temizuya(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
      }
    }
  }

  Future<void> _loadNpcs(ObjectGroup npcs) async {
    for (final TiledObject npc in npcs.objects) {
      switch (npc.name) {
        case 'qianbi':
          await add(
            Monk(
              position: Vector2(npc.x, npc.y),
            ),
          );
          break;
      }
    }
  }
}
