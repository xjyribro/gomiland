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
import 'package:gomiland/game/npcs/general_npc.dart';
import 'package:gomiland/game/npcs/manuka.dart';
import 'package:gomiland/game/npcs/mr_moon.dart';
import 'package:gomiland/game/npcs/qian_bi.dart';
import 'package:gomiland/game/npcs/utils.dart';
import 'package:gomiland/game/objects/buildings/building_with_fade.dart';
import 'package:gomiland/game/objects/buildings/fish_shop.dart';
import 'package:gomiland/game/objects/buildings/shop_back_jap.dart';
import 'package:gomiland/game/objects/buildings/shoukudou.dart';
import 'package:gomiland/game/objects/buildings/tea_shop.dart';
import 'package:gomiland/game/objects/buildings/temizuya.dart';
import 'package:gomiland/game/objects/lights/park_light.dart';
import 'package:gomiland/game/objects/lights/stone_light.dart';
import 'package:gomiland/game/objects/obsticle.dart';
import 'package:gomiland/game/objects/rubbish_spawner.dart';
import 'package:gomiland/game/objects/sign.dart';
import 'package:gomiland/game/objects/trees/bamboo.dart';
import 'package:gomiland/game/objects/trees/tree_with_fade.dart';
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

  void _checkBgm() {
    final bool isMute = game.gameStateBloc.state.isMute;
    if (!isMute) {
      Sounds.playParkBgm();
    }
  }

  @override
  Future<void> onLoad() async {
    _checkBgm();
    final TiledComponent map = await TiledComponent.load(
      'park.tmx',
      Vector2.all(tileSize),
    );

    await _loadMap(map);

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

    final signs = map.tileMap.getLayer<ObjectGroup>('signs');
    if (signs != null) {
      await _loadSigns(signs);
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
          add(Obstacle(
            position: Vector2(lights.x + 8, lights.y + 48),
            size: Vector2(16, 16),
          ));
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

  Future<void> _loadPlayer(Vector2 position) async {
    JoystickComponent? joystick = kIsWeb
        ? null
        : JoystickComponent(
            knob: SpriteComponent(
              sprite: await Sprite.load(
                  Assets.assets_images_ui_directional_knob_png),
              size: Vector2.all(128),
            ),
            background: SpriteComponent(
              sprite: await Sprite.load(
                  Assets.assets_images_ui_directional_pad_png),
              size: Vector2.all(128),
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

  Future<void> _loadMap(TiledComponent map) async {
    final imageCompiler = ImageBatchCompiler();
    final ground =
        imageCompiler.compileMapLayer(tileMap: map.tileMap, layerNames: [
      'sand',
      'bridge',
      'pavement',
      'grass',
      'overlays',
      'barriers',
      'trees',
      'lights',
    ]);
    add(ground);
    final animationCompiler = AnimationBatchCompiler();
    await TileProcessor.processTileType(
        tileMap: map.tileMap,
        processorByType: <String, TileProcessorFunc>{
          'water': ((tile, position, size) async {
            return animationCompiler.addTile(position, tile);
          }),
        },
        layersToLoad: [
          'water',
        ]);
    final animatedWater = await animationCompiler.compile();
    animatedWater.priority = -1;
    add(animatedWater);
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
            TreeWthFade(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
              spritePath: Assets.assets_images_trees_tree_bonsai_png,
              hitboxSize: Vector2(96, 96),
            ),
          );
          break;
        case 'tree_fluffy':
          await add(
            TreeWthFade(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
              spritePath: Assets.assets_images_trees_tree_fluffy_png,
              hitboxSize: Vector2(64, 64),
            ),
          );
          break;
        case 'tree_normal':
          await add(
            TreeWthFade(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
              spritePath: Assets.assets_images_trees_tree_normal_png,
              hitboxSize: Vector2(128, 96),
            ),
          );
          break;
        case 'tree_popsicle':
          await add(
            TreeWthFade(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
              spritePath: Assets.assets_images_trees_tree_popsicle_png,
              hitboxSize: Vector2(64, 128),
            ),
          );
          break;
        case 'tree_spiky':
          await add(
            TreeWthFade(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
              spritePath: Assets.assets_images_trees_tree_spiky_png,
              hitboxSize: Vector2(32, 96),
            ),
          );
          break;
        case 'sakura':
          await add(
            TreeWthFade(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
              spritePath: Assets.assets_images_trees_tree_sakura_png,
              hitboxSize: Vector2(96, 64),
              hitboxPosition: Vector2.zero(),
            ),
          );
          break;
        case 'tree_cone':
          await add(
            TreeWthFade(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
              spritePath: Assets.assets_images_trees_tree_cone_png,
              hitboxSize: Vector2(96, 160),
              hitboxPosition: Vector2.zero(),
            ),
          );
          break;
        case 'tree_willow':
          await add(
            TreeWthFade(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
              spritePath: Assets.assets_images_trees_tree_willow_png,
              hitboxSize: Vector2(96, 96),
              hitboxPosition: Vector2.zero(),
            ),
          );
          break;
        case 'tree_orange':
          await add(
            TreeWthFade(
              position: Vector2(tree.x, tree.y),
              size: Vector2(tree.width, tree.height),
              spritePath: Assets.assets_images_trees_tree_orange_png,
              hitboxSize: Vector2(160, 64),
              hitboxPosition: Vector2.zero(),
            ),
          );
          break;
        default:
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
        case 'shoukudou':
          await add(
            Shoukudou(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'tea_shop':
          await add(
            TeaShop(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'fish_shop':
          await add(
            FishShop(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );

          break;
        case 'shop_back_jap_1':
          await add(
            ShopBackJap(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 0,
            ),
          );
          break;
        case 'shop_back_jap_2':
          await add(
            ShopBackJap(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 1,
            ),
          );
          break;
        case 'shop_back_jap_3':
          await add(
            ShopBackJap(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 2,
            ),
          );
          break;
        case 'tori_small':
          await add(
            SpriteComponent(
              sprite: await Sprite.load(
                  Assets.assets_images_buildings_tori_small_png),
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'tori_big':
          await add(
            SpriteComponent(
              sprite: await Sprite.load(
                  Assets.assets_images_buildings_tori_big_png),
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'combini':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(192, 128),
              spritePath: Assets.assets_images_buildings_combini_png,
            ),
          );
          break;
        case 'castle':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(192, 128),
              spritePath: Assets.assets_images_buildings_combini_png,
            ),
          );
          break;
        case 'shrine_office':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(192, 128),
              spritePath: Assets.assets_images_buildings_shrine_office_png,
            ),
          );
        case 'waterhouse':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(192, 128),
              spritePath: Assets.assets_images_buildings_waterhouse_png,
            ),
          );
        case 'temple':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(192, 128),
              spritePath: Assets.assets_images_buildings_temple_png,
            ),
          );
          break;
        case 'shrine_1':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(192, 128),
              spritePath: Assets.assets_images_buildings_shrine1_png,
            ),
          );
          break;
        case 'shrine_2':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(192, 128),
              spritePath: Assets.assets_images_buildings_shrine2_png,
            ),
          );
          break;
        case 'shrine_3':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(192, 128),
              spritePath: Assets.assets_images_buildings_shrine3_png,
            ),
          );
          break;
        case 'park_centre_1':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(192, 128),
              spritePath: Assets.assets_images_buildings_park_centre1_png,
            ),
          );
          break;
        case 'park_centre_2':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(192, 128),
              spritePath: Assets.assets_images_buildings_park_centre2_png,
            ),
          );
          break;
      }
    }
  }

  Future<void> _loadSigns(ObjectGroup signs) async {
    for (final TiledObject sign in signs.objects) {
      switch (sign.name) {
        case 'how_to_play':
          await add(
            Sign(
              position: Vector2(sign.x, sign.y),
              signName: 'how_to_play',
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
            GeneralNpc(
              position: Vector2(npc.x, npc.y),
              imgPath: Assets.assets_images_npcs_boy_png,
              dialoguePath: Assets.assets_yarn_park_npcs_yarn,
              npcName: NpcName.man,
            ),
          );
          break;
        case 'women':
          await add(
            GeneralNpc(
              position: Vector2(npc.x, npc.y),
              imgPath: Assets.assets_images_npcs_boy_png,
              dialoguePath: Assets.assets_yarn_park_npcs_yarn,
              npcName: NpcName.woman,
            ),
          );
          break;
        case 'boy':
          await add(
            GeneralNpc(
              position: Vector2(npc.x, npc.y),
              imgPath: Assets.assets_images_npcs_boy_png,
              dialoguePath: Assets.assets_yarn_park_npcs_yarn,
              npcName: NpcName.boy,
            ),
          );
          break;
        case 'girl':
          await add(
            GeneralNpc(
              position: Vector2(npc.x, npc.y),
              imgPath: Assets.assets_images_npcs_boy_png,
              dialoguePath: Assets.assets_yarn_park_npcs_yarn,
              npcName: NpcName.girl,
            ),
          );
          break;
        case 'qianbi':
          await add(
            QianBi(position: Vector2(npc.x, npc.y)),
          );
          break;
        case 'moon':
          await add(
            MrMoon(position: Vector2(npc.x, npc.y)),
          );
          break;
        case 'manuka':
          await add(
            Manuka(position: Vector2(npc.x, npc.y)),
          );
          break;
      }
    }
  }
}
