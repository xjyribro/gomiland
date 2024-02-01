import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/monk.dart';
import 'package:gomiland/game/objects/buildings/apt1.dart';
import 'package:gomiland/game/objects/buildings/apt2.dart';
import 'package:gomiland/game/objects/buildings/apt3.dart';
import 'package:gomiland/game/objects/buildings/combini.dart';
import 'package:gomiland/game/objects/buildings/fountain.dart';
import 'package:gomiland/game/objects/buildings/house_eng.dart';
import 'package:gomiland/game/objects/buildings/inn.dart';
import 'package:gomiland/game/objects/buildings/piler.dart';
import 'package:gomiland/game/objects/buildings/shop_eng.dart';
import 'package:gomiland/game/objects/buildings/shop_side_eng.dart';
import 'package:gomiland/game/objects/buildings/temizuya.dart';
import 'package:gomiland/game/objects/lights/street_light.dart';
import 'package:gomiland/game/objects/obsticle.dart';
import 'package:gomiland/game/objects/rubbish_spawner.dart';
import 'package:gomiland/game/objects/trees/bamboo.dart';
import 'package:gomiland/game/player/player.dart';
import 'package:gomiland/game/scenes/gate.dart';

class HoodMap extends Component with HasGameReference<GomilandGame> {
  late Function _setNewSceneName;
  late Vector2 _playerStartPosit;

  HoodMap({
    required Function setNewSceneName,
    required Vector2 playerStartPosit,
  }) : super() {
    _setNewSceneName = setNewSceneName;
    _playerStartPosit = playerStartPosit;
  }

  void turnOnLights() {
    List<StreetLight> streetLights = children.query<StreetLight>();
    for (StreetLight light in streetLights) {
      light.addLight();
    }
  }

  void turnOffLights() {
    List<StreetLight> streetLights = children.query<StreetLight>();
    for (StreetLight light in streetLights) {
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
      Sounds.playHoodBgm();
    }

    final TiledComponent map = await TiledComponent.load(
      'hood.tmx',
      Vector2.all(32),
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
        SceneName sceneName =
            object.name == 'park' ? SceneName.park : SceneName.room;
        await add(
          Gate(
            position: Vector2(object.x, object.y),
            size: Vector2(object.width, object.height),
            switchScene: () {
              _setNewSceneName(sceneName);
            },
          ),
        );
      }
    }

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
        StreetLight streetLight = StreetLight(
          position: Vector2(lights.x, lights.y),
          size: Vector2(lights.width, lights.height),
        );
        await add(streetLight);
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
        case 'tree1':
          await add(
            Bamboo(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
            ),
          );
          break;
        case 'tree2':
          await add(
            Bamboo(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
            ),
          );
          break;
        case 'tree3':
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

  Future<void> _loadNpcs(ObjectGroup npcs) async {
    for (final TiledObject npc in npcs.objects) {
      switch (npc.name) {
        case 'man':
          await add(
            Monk(
              position: Vector2(npc.x, npc.y),
            ),
          );
          break;
        case 'women':
          await add(
            Monk(
              position: Vector2(npc.x, npc.y),
            ),
          );
          break;
        case 'manuka':
          await add(
            Monk(
              position: Vector2(npc.x, npc.y),
            ),
          );
          break;
        case 'asimov':
          await add(
            Monk(
              position: Vector2(npc.x, npc.y),
            ),
          );
          break;
        case 'moon':
          await add(
            Monk(
              position: Vector2(npc.x, npc.y),
            ),
          );
          break;
        case 'stark':
          await add(
            Monk(
              position: Vector2(npc.x, npc.y),
            ),
          );
          break;
        case 'plastic':
          await add(
            Monk(
              position: Vector2(npc.x, npc.y),
            ),
          );
          break;
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

  Future<void> _loadBuildings(ObjectGroup buildings) async {
    for (final TiledObject building in buildings.objects) {
      switch (building.name) {
        case 'home':
          await add(
            SpriteComponent(
              sprite:
                  await Sprite.load(Assets.assets_images_buildings_home_png),
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'inn':
          await add(
            Inn(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'apt_1':
          await add(
            Apt1(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'apt_2':
          await add(
            Apt2(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'apt_3':
          await add(
            Apt3(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'shop_eng_1':
          await add(
            ShopEng(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 0,
            ),
          );
          break;
        case 'shop_eng_2':
          await add(
            ShopEng(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 1,
            ),
          );
          break;
        case 'shop_side_eng_1':
          await add(
            ShopSideEng(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 0,
            ),
          );
          break;
        case 'shop_side_eng_2':
          await add(
            ShopSideEng(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 1,
            ),
          );
          break;
        case 'house_eng_1':
          await add(
            HouseEng(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 0,
            ),
          );
          break;
        case 'house_eng_2':
          await add(
            HouseEng(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 1,
            ),
          );
          break;
        case 'house_eng_3':
          await add(
            HouseEng(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 2,
            ),
          );
          break;
        case 'combini':
          await add(
            Combini(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'piler':
          await add(
            Piler(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'temizuya':
          await add(
            Temizuya(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'fountain':
          await add(
            Fountain(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        default:
          break;
      }
    }
  }
}
