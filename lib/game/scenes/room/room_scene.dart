import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_utils/flame_tiled_utils.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/room/bin.dart';
import 'package:gomiland/game/scenes/room/rubbish_spawner.dart';
import 'package:gomiland/game/ui/hud/exit_room_button.dart';

class RoomMap extends Component with HasGameReference<GomilandGame> {
  RoomMap({required setNewSceneName}) : super() {
    _setNewSceneName = setNewSceneName;
  }

  late Function _setNewSceneName;

  void _removeHudComponentsForRoom() {
    game.removeHudComponentsForRoom();
    List<JoystickComponent> joysticks =
        game.cameraComponent.viewport.children.query<JoystickComponent>();
    if (joysticks.isNotEmpty) {
      game.cameraComponent.viewport.removeAll(joysticks);
    }
  }

  void _checkBgm() {
    final bool isMute = game.gameStateBloc.state.isMute;
    if (!isMute) {
      Sounds.playRoomBgm();
    }
  }

  Future<void> _loadMap(TiledComponent map) async {
    final imageCompiler = ImageBatchCompiler();
    final background = imageCompiler.compileMapLayer(
        tileMap: map.tileMap, layerNames: ['objects', 'door', 'base']);
    add(background);
  }

  void _centreCamera(Vector2 centerOfScene) {
    game.cameraComponent.moveTo(centerOfScene);
  }

  @override
  Future<void> onLoad() async {
    game.gameStateBloc.add(const BagCountChange(10)); // TODO remove this

    final TiledComponent map = await TiledComponent.load(
      'room.tmx',
      Vector2.all(tileSize),
    );
    final Vector2 centerOfScene = Vector2(map.width / 2, map.height / 2);

    _removeHudComponentsForRoom();
    _checkBgm();
    _loadMap(map);
    _centreCamera(centerOfScene);

    add(
      ExitRoomButton(
        switchScene: () {
          _setNewSceneName(SceneName.hood);
        },
      ),
    );

    final binsLayer = map.tileMap.getLayer<ObjectGroup>('bins');

    if (binsLayer != null) {
      for (final TiledObject object in binsLayer.objects) {
        RubbishType binType = object.name.rubbishType;
        Bin bin = Bin(
          openingPosition: Vector2(object.x, object.y),
          openingSize: Vector2(object.width, object.height),
          binType: binType,
        );
        add(bin);
      }
    }

    RubbishSpawner rubbishSpawner =
        RubbishSpawner(centerOfScene: centerOfScene);
    await add(rubbishSpawner);
  }
}
