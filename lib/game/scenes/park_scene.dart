import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/scenes/gate.dart';

class ParkMap extends Component {
  late Function _setNewSceneName;

  ParkMap({required setNewSceneName}) : super() {
    _setNewSceneName = setNewSceneName;
  }

  @override
  Future<void> onLoad() async {
    Sounds.playParkBgm();
    final TiledComponent map = await TiledComponent.load(
      'park.tmx',
      Vector2.all(tileSize),
    );
    await add(map);

    final objectLayer = map.tileMap.getLayer<ObjectGroup>('gates');

    if (objectLayer != null) {
      for (final TiledObject object in objectLayer.objects) {
        // await add(
        //   Gate(
        //     position: Vector2(object.x, object.y),
        //     size: Vector2(object.width, object.height),
        //     switchScene: () {
        //       _setNewSceneName(SceneName.hood);
        //     },
        //   ),
        // );
      }
    }
  }
}
