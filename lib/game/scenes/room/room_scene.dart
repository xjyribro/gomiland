import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_utils/flame_tiled_utils.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/room/bin.dart';
import 'package:gomiland/game/scenes/room/rubbish_spawner.dart';

class RoomMap extends Component with HasGameReference<GomilandGame> {
  late Function _setNewSceneName;

  RoomMap({required setNewSceneName}) : super() {
    _setNewSceneName = setNewSceneName;
  }

  @override
  Future<void> onLoad() async {
    final bool isMute = game.gameStateBloc.state.isMute;
    if (!isMute) {
      Sounds.playRoomBgm();
    }

    List<JoystickComponent> joysticks =
        game.cameraComponent.viewport.children.query<JoystickComponent>();
    if (joysticks.isNotEmpty) {
      game.cameraComponent.viewport.removeAll(joysticks);
    }

    final TiledComponent map = await TiledComponent.load(
      'room.tmx',
      Vector2.all(tileSize),
    );
    final imageCompiler = ImageBatchCompiler();
    final background = imageCompiler.compileMapLayer(
        tileMap: map.tileMap, layerNames: ['objects', 'door', 'base']);
    add(background);

    final Vector2 centerOfScene = Vector2(map.width / 2, map.height / 2);
    game.cameraComponent.moveTo(centerOfScene);

    final gatesLayer = map.tileMap.getLayer<ObjectGroup>('gates');

    if (gatesLayer != null) {
      for (final TiledObject object in gatesLayer.objects) {
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
