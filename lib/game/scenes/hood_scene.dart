import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_utils/flame_tiled_utils.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/scenes/scene_name.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/asimov.dart';
import 'package:gomiland/game/npcs/general_npc.dart';
import 'package:gomiland/game/npcs/himiko.dart';
import 'package:gomiland/game/npcs/manuka.dart';
import 'package:gomiland/game/npcs/mr_moon.dart';
import 'package:gomiland/game/npcs/qian_bi.dart';
import 'package:gomiland/game/npcs/risa.dart';
import 'package:gomiland/game/npcs/stark.dart';
import 'package:gomiland/game/npcs/utils.dart';
import 'package:gomiland/game/objects/buildings/apt_side.dart';
import 'package:gomiland/game/objects/buildings/building_with_fade.dart';
import 'package:gomiland/game/objects/buildings/fish_shop.dart';
import 'package:gomiland/game/objects/buildings/fountain.dart';
import 'package:gomiland/game/objects/buildings/house_eng.dart';
import 'package:gomiland/game/objects/buildings/inn.dart';
import 'package:gomiland/game/objects/buildings/piler.dart';
import 'package:gomiland/game/objects/buildings/shop_back_eng.dart';
import 'package:gomiland/game/objects/buildings/shop_back_jap.dart';
import 'package:gomiland/game/objects/buildings/shop_eng.dart';
import 'package:gomiland/game/objects/buildings/shop_side_eng.dart';
import 'package:gomiland/game/objects/buildings/shop_side_jap.dart';
import 'package:gomiland/game/objects/buildings/shoukudou.dart';
import 'package:gomiland/game/objects/buildings/tea_shop.dart';
import 'package:gomiland/game/objects/lights/street_light.dart';
import 'package:gomiland/game/objects/obsticle.dart';
import 'package:gomiland/game/objects/rubbish_spawner.dart';
import 'package:gomiland/game/objects/sign.dart';
import 'package:gomiland/game/objects/trees/tree_with_fade.dart';
import 'package:gomiland/game/player/player.dart';
import 'package:gomiland/game/scenes/gate.dart';

class HoodMap extends Component with HasGameReference<GomilandGame> {
  late Function _setNewSceneName;
  late Vector2 _playerStartPosit;
  late Vector2 _playerStartLookDir;

  HoodMap({
    required Function setNewSceneName,
    required Vector2 playerStartPosit,
    required Vector2 playerStartLookDir,
  }) : super() {
    _setNewSceneName = setNewSceneName;
    _playerStartPosit = playerStartPosit;
    _playerStartLookDir = playerStartLookDir;
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

  void _checkBgm() {
    final bool isMute = game.gameStateBloc.state.isMute;
    if (!isMute) {
      Sounds.playHoodBgm();
    }
  }

  @override
  Future<void> onLoad() async {
    final TiledComponent map = await TiledComponent.load(
      'hood.tmx',
      Vector2.all(32),
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
        SceneName sceneName =
            object.name == 'park' ? SceneName.park : SceneName.room;
        await add(
          Gate(
            position: Vector2(object.x, object.y),
            size: Vector2(object.width, object.height),
            switchScene: () => _setNewSceneName(sceneName),
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

    final npcs = map.tileMap.getLayer<ObjectGroup>('npc');
    if (npcs != null) {
      await _loadNpcs(npcs);
    }

    await _loadPlayer(_playerStartPosit, _playerStartLookDir);

    final buildings = map.tileMap.getLayer<ObjectGroup>('buildings');
    if (buildings != null) {
      await _loadBuildings(buildings);
    }

    final trees = map.tileMap.getLayer<ObjectGroup>('trees');
    if (trees != null) {
      await _loadTrees(trees);
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
      print(game.gameStateBloc.state.minutes);
      for (final TiledObject lights in lights.objects) {
        StreetLight streetLight = StreetLight(
          position: Vector2(lights.x, lights.y),
          size: Vector2(lights.width, lights.height),
          shouldAddLight: shouldAddLight,
        );
        add(streetLight);
        add(Obstacle(
          position: Vector2(lights.x + 6, lights.y + 48),
          size: Vector2(20, 16),
        ));
      }
    }
    _checkBgm();
  }

  Future<void> _loadPlayer(Vector2 position, Vector2 lookDir) async {
    Player player = Player(position: position, lookDir: lookDir);
    await add(player);
    game.cameraComponent.follow(player);
  }

  Future<void> _loadMap(TiledComponent map) async {
    final animationCompiler = AnimationBatchCompiler();
    final imageCompiler = ImageBatchCompiler();
    final ground =
        imageCompiler.compileMapLayer(tileMap: map.tileMap, layerNames: [
      'sand',
      'road',
      'pavement',
      'grass',
      'overlays',
      'barriers',
      'bases',
      'trees',
      'buildings',
    ]);
    add(ground);
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

  Future<void> _loadSigns(ObjectGroup signs) async {
    for (final TiledObject sign in signs.objects) {
      await add(
        Sign(
          position: Vector2(sign.x, sign.y),
          signName: sign.name,
        ),
      );
    }
  }

  Future<void> _loadTrees(ObjectGroup trees) async {
    for (final TiledObject tree in trees.objects) {
      switch (tree.name) {
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
      }
    }
  }

  Future<void> _loadNpcs(ObjectGroup npcs) async {
    for (final TiledObject npc in npcs.objects) {
      add(Obstacle(
        position: Vector2(npc.x + 6, npc.y),
        size: Vector2(20, 32),
      ));
      switch (npc.name) {
        case 'man':
          await add(
            GeneralNpc(
              position: Vector2(npc.x, npc.y),
              imgPath: Assets.assets_images_npcs_man_png,
              dialoguePath: Assets.assets_yarn_hood_npcs_yarn,
              npcName: NpcName.man,
            ),
          );
        case 'woman':
          await add(
            GeneralNpc(
              position: Vector2(npc.x, npc.y),
              imgPath: Assets.assets_images_npcs_woman_png,
              dialoguePath: Assets.assets_yarn_hood_npcs_yarn,
              npcName: NpcName.woman,
            ),
          );
          break;
        case 'boy':
          await add(
            GeneralNpc(
              position: Vector2(npc.x, npc.y),
              imgPath: Assets.assets_images_npcs_boy_png,
              dialoguePath: Assets.assets_yarn_hood_npcs_yarn,
              npcName: NpcName.boy,
            ),
          );
          break;
        case 'girl':
          await add(
            GeneralNpc(
              position: Vector2(npc.x, npc.y),
              imgPath: Assets.assets_images_npcs_girl_png,
              dialoguePath: Assets.assets_yarn_hood_npcs_yarn,
              npcName: NpcName.girl,
            ),
          );
          break;
        case 'himiko':
          await add(Himiko(position: Vector2(npc.x, npc.y)));
          break;
        case 'asimov':
          await add(Asimov(position: Vector2(npc.x, npc.y)));
          break;
        case 'boss':
          await add(QianBi(position: Vector2(npc.x, npc.y)));
          break;
        case 'stark':
          await add(Stark(position: Vector2(npc.x, npc.y)));
          break;
        case 'risa':
          await add(Risa(position: Vector2(npc.x, npc.y)));
          break;
        case 'mr_sun':
          await add(QianBi(position: Vector2(npc.x, npc.y)));
          break;
        case 'mrs_sun':
          await add(QianBi(position: Vector2(npc.x, npc.y)));
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
        case 'piler':
          await add(
            Piler(
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
        case 'kiosk_roof':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(320, 192),
              spritePath: Assets.assets_images_buildings_kiosk_roof_png,
            ),
          );
          break;
        case 'pilar':
          await add(
            SpriteComponent(
              sprite:
                  await Sprite.load(Assets.assets_images_buildings_pilar_png),
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
            ),
          );
          break;
        case 'school':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(576, 192),
              spritePath: Assets.assets_images_buildings_school_png,
            ),
          );
          break;
        case 'office':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(320, 160),
              spritePath: Assets.assets_images_buildings_office_png,
            ),
          );
          break;
        case 'soup_kitchen':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(256, 96),
              spritePath: Assets.assets_images_buildings_soup_kitchen_png,
            ),
          );
          break;
        case 'hospital':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(512, 224),
              spritePath: Assets.assets_images_buildings_hostpital_png,
            ),
          );
          break;
        case 'cafe':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(256, 192),
              spritePath: Assets.assets_images_buildings_cafe_png,
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
        case 'shop_back_eng_1':
          await add(
            ShopBackEng(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 0,
            ),
          );
          break;
        case 'shop_back_eng_2':
          await add(
            ShopBackEng(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 1,
            ),
          );
          break;
        case 'shop_back_eng_3':
          await add(
            ShopBackEng(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 2,
            ),
          );
          break;
        case 'apt_1':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(288, 224),
              spritePath: Assets.assets_images_buildings_apt1_png,
            ),
          );
          break;
        case 'apt_2':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(288, 160),
              spritePath: Assets.assets_images_buildings_apt2_png,
            ),
          );
          break;
        case 'apt_3':
          await add(
            BuildingWithFade(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(256, 224),
              spritePath: Assets.assets_images_buildings_apt3_png,
            ),
          );
          break;
        case 'apt_side_1':
          await add(
            AptSide(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 0,
            ),
          );
          break;
        case 'apt_side_2':
          await add(
            AptSide(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 1,
            ),
          );
          break;
        case 'apt_side_3':
          await add(
            AptSide(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 2,
            ),
          );
          break;
        case 'apt_side_4':
          await add(
            AptSide(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 3,
            ),
          );
          break;
        case 'shop_side_jap_1':
          await add(
            ShopSideJap(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 0,
            ),
          );
          break;
        case 'shop_side_jap_2':
          await add(
            ShopSideJap(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 1,
            ),
          );
          break;
        case 'shop_side_jap_3':
          await add(
            ShopSideJap(
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              id: 2,
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
        default:
          break;
      }
    }
  }
}
