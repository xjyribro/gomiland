import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/npcs/monk.dart';
import 'package:gomiland/game/objects/buildings/apt3.dart';
import 'package:gomiland/game/objects/rubbish_spawner.dart';
import 'package:gomiland/game/scenes/gate.dart';

class HoodMap extends Component {
  late Function _setNewSceneName;

  HoodMap({required setNewSceneName}) : super() {
    _setNewSceneName = setNewSceneName;
  }

  @override
  Future<void> onLoad() async {
    Sounds.playHoodBgm();
    final TiledComponent map = await TiledComponent.load(
      'hood.tmx',
      Vector2.all(32),
    );
    await add(map);

    final interactionsLayer = map.tileMap.getLayer<ObjectGroup>('gates');

    if (interactionsLayer != null) {
      for (final TiledObject object in interactionsLayer.objects) {
        await add(
          Gate(
            position: Vector2(object.x, object.y),
            size: Vector2(object.width, object.height),
            switchScene: () {
              _setNewSceneName(SceneName.park);
            },
          ),
        );
      }
    }

    final npcLayer = map.tileMap.getLayer<ObjectGroup>('npc');

    if (npcLayer != null) {
      for (final TiledObject npc in npcLayer.objects) {
        if (npc.name == 'boy') {
          await add(
            Monk(
              position: Vector2(npc.x, npc.y),
            ),
          );
        }
      }
    }

    final buildings = map.tileMap.getLayer<ObjectGroup>('buildings');

    if (buildings != null) {
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
          case 'apt1':
            await add(
              SpriteComponent(
                sprite:
                await Sprite.load(Assets.assets_images_buildings_home_png),
                position: Vector2(building.x, building.y),
                size: Vector2(building.width, building.height),
              ),
            );
            break;
          case 'apt2':
            await add(
              SpriteComponent(
                sprite:
                await Sprite.load(Assets.assets_images_buildings_home_png),
                position: Vector2(building.x, building.y),
                size: Vector2(building.width, building.height),
              ),
            );
            break;
          case 'apt3':
            await add(
              Apt3(
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
  }
}
