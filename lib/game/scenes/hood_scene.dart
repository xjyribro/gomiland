import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/scenes/gate.dart';

class HoodMap extends TiledComponent {
  late Function setNewSceneName;

  HoodMap({required RenderableTiledMap tiledMap, required setNewSceneName})
      : super(tiledMap) {
    setNewSceneName = setNewSceneName;
  }

  @override
  Future<void> onLoad() async {
    final objectLayer = tileMap.getLayer<ObjectGroup>('gates');

    if (objectLayer != null) {
      for (final TiledObject object in objectLayer.objects) {
        add(
          Gate(
            position: Vector2(object.x, object.y),
            size: Vector2(object.width, object.height),
            switchScene: () => setNewSceneName(SceneName.hood),
          ),
        );
      }
    }
  }
}
