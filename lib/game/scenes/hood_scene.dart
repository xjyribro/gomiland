import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomiland/constants.dart';
import 'package:gomiland/game/controllers/game_state.dart';
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

    final objectLayer = map.tileMap.getLayer<ObjectGroup>('gates');

    if (objectLayer != null) {
      for (final TiledObject object in objectLayer.objects) {
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
  }
}
