import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_tiled_utils/flame_tiled_utils.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/room/bin.dart';
import 'package:gomiland/game/scenes/room/rubbish_spawner.dart';
import 'package:gomiland/game/scenes/scene_name.dart';
import 'package:gomiland/game/ui/hud/exit_room_button.dart';
import 'package:gomiland/game/ui/info_popup/info_popup.dart';
import 'package:gomiland/game/ui/info_popup/info_popup_data.dart';

class RoomMap extends Component with HasGameReference<GomilandGame> {
  RoomMap({required setNewSceneName}) : super() {
    _setNewSceneName = setNewSceneName;
  }

  bool _hasUncleared = false;
  late Function _setNewSceneName;
  late final Map<RubbishType, Bin> _bins = {};

  void _setHasUncleared(bool hasUncleared) {
    _hasUncleared = hasUncleared;
  }

  void _removeHudComponentsForRoom() {
    game.removeHudComponentsForWorld();
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

  void _showScore(RubbishType binType, int score) {
    Bin? bin = _bins[binType];
    if (bin != null) {
      bin.showScore(score);
    }
  }

  void _leaveRoomCheck() {
    if (_hasUncleared) {
      game.overlays.add('ConfirmExitRoom');
    } else {
      _setNewSceneName(SceneName.hood);
    }
  }

  void _showTutorial() {
    InfoPopupObject infoPopupObject = getInfoPopupObject('how_to_sort');
    InfoPopup popup = InfoPopup(infoPopupObject: infoPopupObject);
    game.cameraComponent.viewport.add(popup);
  }

  @override
  Future<void> onLoad() async {
    final TiledComponent map = await TiledComponent.load(
      'room.tmx',
      Vector2.all(tileSize),
    );
    final Vector2 centerOfScene = Vector2(map.width / 2, map.height / 2);

    _removeHudComponentsForRoom();
    _checkBgm();
    _loadMap(map);
    _centreCamera(centerOfScene);

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
        _bins[binType] = bin;
      }
    }

    RubbishSpawner rubbishSpawner = RubbishSpawner(
      centerOfScene: centerOfScene,
      showScore: _showScore,
      setHasUncleared: _setHasUncleared,
    );
    await add(rubbishSpawner);
    add(ExitRoomButton(leaveRoomCheck: _leaveRoomCheck));
    if (game.gameStateBloc.state.bagSize < 2) {
      _showTutorial();
    }
  }
}
