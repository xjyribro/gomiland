import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomiland/constants.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/scenes/gate.dart';
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
    map.position = Vector2(-map.width/2, -map.height/2);
    RubbishSpawner rubbishSpawner = RubbishSpawner();
    await addAll([map, rubbishSpawner]);


  }
}
