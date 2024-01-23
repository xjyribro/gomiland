import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/constants/values.dart';
import 'package:gomiland/game/npcs/monk.dart';
import 'package:gomiland/game/scenes/gate.dart';

class HoodMap extends Component {
  late Function _setNewSceneName;

  HoodMap({required setNewSceneName}) : super() {
    _setNewSceneName = setNewSceneName;
  }

  @override
  Future<void> onLoad() async {
    final TiledComponent map = await TiledComponent.load(
      'hood.tmx',
      Vector2.all(tileSize),
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
            Monk(position: Vector2(npc.x, npc.y),
            ),
          );

        }
      }
    }
  }
}
