import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_utils/flame_tiled_utils.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/audio_controller.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/game/data/other_player.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/asimov.dart';
import 'package:gomiland/game/npcs/florence.dart';
import 'package:gomiland/game/npcs/friend.dart';
import 'package:gomiland/game/npcs/general_npc.dart';
import 'package:gomiland/game/npcs/hardy.dart';
import 'package:gomiland/game/npcs/himiko.dart';
import 'package:gomiland/game/npcs/margret.dart';
import 'package:gomiland/game/npcs/mr_kushi.dart';
import 'package:gomiland/game/npcs/mr_mrs_star.dart';
import 'package:gomiland/game/npcs/risa.dart';
import 'package:gomiland/game/npcs/rocky.dart';
import 'package:gomiland/game/npcs/scarlett.dart';
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
import 'package:gomiland/game/objects/gate.dart';
import 'package:gomiland/game/objects/lights/street_light.dart';
import 'package:gomiland/game/objects/obsticle.dart';
import 'package:gomiland/game/objects/signs/combini_sign.dart';
import 'package:gomiland/game/objects/signs/general_sign.dart';
import 'package:gomiland/game/objects/spawners/rubbish_spawner.dart';
import 'package:gomiland/game/objects/trees/tree_with_fade.dart';
import 'package:gomiland/game/objects/zen_garden/bonsai.dart';
import 'package:gomiland/game/player/player.dart';
import 'package:gomiland/game/player/utils.dart';
import 'package:gomiland/game/scenes/scene_name.dart';
import 'package:gomiland/game/scenes/utils.dart';

class HoodMap extends Component with HasGameReference<GomilandGame> {
  Map<String, OtherPlayer> friends = {};
  late Function _setNewSceneName;
  late bool _loadFromSave;
  late Player _player;

  HoodMap({
    required Function setNewSceneName,
    required bool loadFromSave,
  }) : super() {
    _setNewSceneName = setNewSceneName;
    _loadFromSave = loadFromSave;
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
      await _loadGates(gates);
    }

    final spawners = map.tileMap.getLayer<ObjectGroup>('spawners');
    if (spawners != null) {
      await _loadSpawners(spawners);
    }

    final npcs = map.tileMap.getLayer<ObjectGroup>('npc');
    if (npcs != null) {
      await _loadNpcs(npcs);
    }

    await _loadPlayer();

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
      for (final TiledObject light in lights.objects) {
        StreetLight streetLight = StreetLight(
          position: Vector2(light.x, light.y),
          size: Vector2(light.width, light.height),
          shouldAddLight: shouldAddLight,
        );
        add(streetLight);
        add(Obstacle(
          position: Vector2(light.x + 6, light.y + 48),
          size: Vector2(20, 16),
        ));
      }
    }

    _checkBgm();
  }

  Future<void> _loadPlayer() async {
    SceneName sceneName = game.gameStateBloc.state.sceneName;
    final bool comingFromPark = sceneName == SceneName.park;
    Vector2 playerStartPosit = _loadFromSave
        ? game.playerStateBloc.state.playerPosition
        : getPlayerHoodStartPosit(comingFromPark);

    bool isTutorial = game.gameStateBloc.state.bagSize < 10;
    if (isTutorial && !comingFromPark) {
      game.freezePlayer();
    }
    Vector2 playerStartLookDir = isTutorial
        ? getPlayerTutorialStartLookDir()
        : _loadFromSave
            ? game.playerStateBloc.state.playerDirection
            : getPlayerHoodStartLookDir(comingFromPark);
    Player player =
        Player(position: playerStartPosit, lookDir: playerStartLookDir);
    _player = player;
    await add(player);
    game.cameraComponent.follow(player);
  }

  Future<void> _loadMap(TiledComponent map) async {
    final animationCompiler = AnimationBatchCompiler();
    final imageCompiler = ImageBatchCompiler();
    final layerNames = [
      'sand',
      'road',
      'pavement',
      'grass',
      'overlays',
      'barriers',
      'bases',
      'trees',
      'buildings',
    ];
    if (game.progressStateBloc.state.moon >= 100) {
      layerNames.add('veggies');
    }
    if (game.progressStateBloc.state.moon >= 200) {
      layerNames.add('med_crops');
    }
    final ground = imageCompiler.compileMapLayer(
      tileMap: map.tileMap,
      layerNames: layerNames,
    );
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

  Future<void> _loadSpawners(ObjectGroup spawners) async {
    final spawnerCount = spawners.objects.length;
    List<int> hoodSpawnList = game.gameStateBloc.state.hoodSpawners;
    for (int i = 0; i < spawnerCount; i++) {
      if (hoodSpawnList.contains(i)) {
        final spawner = spawners.objects[i];
        await add(
          RubbishSpawner(
            position: Vector2(spawner.x, spawner.y),
            sceneName: SceneName.hood,
            index: i,
          ),
        );
      }
    }
  }

  Future<void> _loadSigns(ObjectGroup signs) async {
    for (final TiledObject sign in signs.objects) {
      if (sign.name == 'combini') {
        await add(CombiniSign(position: Vector2(sign.x, sign.y)));
      } else {
        await add(
          GeneralSign(
            position: Vector2(sign.x, sign.y),
            signName: sign.name,
          ),
        );
      }
    }
  }

  Future<void> _loadGates(ObjectGroup gates) async {
    for (final TiledObject object in gates.objects) {
      switch (object.name) {
        case 'park':
          await add(
            Gate(
                position: Vector2(object.x, object.y),
                size: Vector2(object.width, object.height),
                switchScene: () => _setNewSceneName(SceneName.park)),
          );
        case 'room':
          await add(
            Gate(
              position: Vector2(object.x, object.y),
              size: Vector2(object.width, object.height),
              switchScene: () async {
                int bagCount = game.gameStateBloc.state.bagCount;
                if (bagCount == 0) {
                  await rejectFromRoom(game, _player);
                } else {
                  _setNewSceneName(SceneName.room);
                }
              },
            ),
          );
      }
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
        case 'bonsai_1':
          PlayerState playerState = game.playerStateBloc.state;
          bool shouldAdd = playerState.zenGarden[ZenStrings.bonsai_1] ?? false;
          if (shouldAdd) {
            await add(
              Bonsai(
                id: 0,
                position: Vector2(tree.x, tree.y),
                size: Vector2(tree.width, tree.height),
              ),
            );
          }
          break;
        case 'bonsai_2':
          PlayerState playerState = game.playerStateBloc.state;
          bool shouldAdd = playerState.zenGarden[ZenStrings.bonsai_2] ?? false;
          if (shouldAdd) {
            await add(
              Bonsai(
                id: 1,
                position: Vector2(tree.x, tree.y),
                size: Vector2(tree.width, tree.height),
              ),
            );
          }
          break;
        case 'bonsai_3':
          PlayerState playerState = game.playerStateBloc.state;
          bool shouldAdd = playerState.zenGarden[ZenStrings.bonsai_3] ?? false;
          if (shouldAdd) {
            await add(
              Bonsai(
                id: 2,
                position: Vector2(tree.x, tree.y),
                size: Vector2(tree.width, tree.height),
              ),
            );
          }
          break;
        case 'bonsai_4':
          PlayerState playerState = game.playerStateBloc.state;
          bool shouldAdd = playerState.zenGarden[ZenStrings.bonsai_4] ?? false;
          if (shouldAdd) {
            await add(
              Bonsai(
                id: 3,
                position: Vector2(tree.x, tree.y),
                size: Vector2(tree.width, tree.height),
              ),
            );
            break;
          }
        case 'rock_1':
          PlayerState playerState = game.playerStateBloc.state;
          bool shouldAdd = playerState.zenGarden[ZenStrings.rock_1] ?? false;
          if (shouldAdd) {
            await add(
              SpriteComponent(
                sprite: await Sprite.load(
                    Assets.assets_images_objects_rock_tall_png),
                position: Vector2(tree.x, tree.y),
                size: Vector2(tree.width, tree.height),
              ),
            );
          }
          break;
        case 'rock_2':
          PlayerState playerState = game.playerStateBloc.state;
          bool shouldAdd = playerState.zenGarden[ZenStrings.rock_2] ?? false;
          if (shouldAdd) {
            await add(
              SpriteComponent(
                sprite: await Sprite.load(
                    Assets.assets_images_objects_rock_small_png),
                position: Vector2(tree.x, tree.y),
                size: Vector2(tree.width, tree.height),
              ),
            );
          }
          break;
        case 'rock_3':
          PlayerState playerState = game.playerStateBloc.state;
          bool shouldAdd = playerState.zenGarden[ZenStrings.rock_3] ?? false;
          if (shouldAdd) {
            await add(
              SpriteComponent(
                sprite: await Sprite.load(
                    Assets.assets_images_objects_rock_small_png),
                position: Vector2(tree.x, tree.y),
                size: Vector2(tree.width, tree.height),
              ),
            );
          }
          break;
        case 'rock_4':
          PlayerState playerState = game.playerStateBloc.state;
          bool shouldAdd = playerState.zenGarden[ZenStrings.rock_4] ?? false;
          if (shouldAdd) {
            await add(
              SpriteComponent(
                sprite: await Sprite.load(
                    Assets.assets_images_objects_rock_small_png),
                position: Vector2(tree.x, tree.y),
                size: Vector2(tree.width, tree.height),
              ),
            );
          }
          break;
      }
    }
  }

  Future<void> _loadNpcs(ObjectGroup npcs) async {
    friends = game.playerStateBloc.state.friends;
    for (final TiledObject npc in npcs.objects) {
      switch (npc.name) {
        case 'friend':
          if (friends.isEmpty) break;
          String friendId = pickRandKey(friends);
          await add(
            Friend(
              position: Vector2(npc.x, npc.y),
              friendInfo: friends[friendId]!,
            ),
          );
          friends.remove(friendId);
          break;
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
        case 'kushi':
          await add(MrKushi(position: Vector2(npc.x, npc.y)));
          break;
        case 'florence':
          await add(Florence(position: Vector2(npc.x, npc.y)));
          break;
        case 'stark':
          await add(Stark(position: Vector2(npc.x, npc.y)));
          break;
        case 'risa':
          await add(Risa(position: Vector2(npc.x, npc.y)));
          break;
        case 'mr_star':
          await add(MrStar(position: Vector2(npc.x, npc.y)));
          break;
        case 'mrs_star':
          await add(MrsStar(position: Vector2(npc.x, npc.y)));
          break;
        case 'hardy':
          await add(Hardy(position: Vector2(npc.x, npc.y)));
          break;
        case 'rocky':
          await add(Rocky(position: Vector2(npc.x, npc.y)));
          break;
        case 'ms_margret':
          await add(Margret(position: Vector2(npc.x, npc.y)));
          break;
        case 'scarlett':
          await add(Scarlett(position: Vector2(npc.x, npc.y)));
          break;
      }
    }
  }

  Future<void> _loadBuildings(ObjectGroup buildings) async {
    int starkProgress = game.progressStateBloc.state.stark;
    int asimovProgress = game.progressStateBloc.state.asimov;
    for (final TiledObject building in buildings.objects) {
      switch (building.name) {
        case 'home':
          await add(
            BuildingWithFade(
              spritePath: Assets.assets_images_buildings_home_png,
              position: Vector2(building.x, building.y),
              size: Vector2(building.width, building.height),
              hitboxSize: Vector2(256, 160),
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
          if (starkProgress >= 200) {
            await add(
              Piler(
                position: Vector2(building.x, building.y),
                size: Vector2(building.width, building.height),
              ),
            );
          } else if (starkProgress >= 100) {
            await add(
              SpriteComponent(
                position: Vector2(building.x, building.y),
                size: Vector2(building.width, building.height),
                sprite:
                    await Sprite.load(Assets.assets_images_objects_piler_png),
              ),
            );
          }
          break;
        case 'digger':
          if (starkProgress >= 100) {
            await add(
              SpriteComponent(
                sprite:
                    await Sprite.load(Assets.assets_images_objects_digger_png),
                position: Vector2(building.x, building.y),
                size: Vector2(building.width, building.height),
              ),
            );
          }
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
        case 'vacbot':
          if (asimovProgress >= 200) {
            await add(
              SpriteComponent(
                position: Vector2(building.x, building.y),
                size: Vector2(building.width, building.height),
                sprite:
                    await Sprite.load(Assets.assets_images_objects_vacbot_png),
              ),
            );
          }
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
              spritePath: Assets.assets_images_buildings_hospital_png,
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
