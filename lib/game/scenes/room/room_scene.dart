import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomiland/constants.dart';
import 'package:gomiland/game/scenes/room/rubbish_spawner.dart';

class RoomMap extends Component {
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
    map.position = Vector2(-map.width / 2, -map.height / 2);
    RubbishSpawner rubbishSpawner = RubbishSpawner();

    final objectLayer = map.tileMap.getLayer<ObjectGroup>('gates');

    if (objectLayer != null) {
      for (final TiledObject object in objectLayer.objects) {
        ButtonComponent forwardButtonComponent = ButtonComponent(
          button: PositionComponent(
            position: Vector2(object.x, object.y),
          ),
          size: Vector2(object.width, object.height),
          priority: 2,
          onPressed: () {
            print('tap');
          },
        );
        addAll([
          forwardButtonComponent,
        ]);
      }
    }
    await addAll([map, rubbishSpawner]);
  }
}
