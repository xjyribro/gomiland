import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomiland/constants.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/room/rubbish_spawner.dart';

class RoomMap extends Component with HasGameReference<GomilandGame> {
  late Function _setNewSceneName;

  RoomMap({required setNewSceneName}) : super() {
    _setNewSceneName = setNewSceneName;
  }

  @override
  Future<void> onLoad() async {
    final TiledComponent map = await TiledComponent.load(
      'room.tmx',
      Vector2.all(tileSize),
    );
    game.cameraComponent.moveTo(Vector2(map.width / 2, map.height / 2));

    final objectLayer = map.tileMap.getLayer<ObjectGroup>('gates');

    if (objectLayer != null) {
      for (final TiledObject object in objectLayer.objects) {
        ButtonComponent exitDoor = ButtonComponent(
          position: Vector2(object.x, object.y),
          button: PositionComponent(),
          size: Vector2(object.width, object.height),
          priority: 2,
          onPressed: () {
            _setNewSceneName(SceneName.hood);
          },
        );
        add(exitDoor);
      }
    }

    RubbishSpawner rubbishSpawner = RubbishSpawner();
    await addAll([map, rubbishSpawner]);
  }
}
