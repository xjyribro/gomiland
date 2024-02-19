import 'package:flame/components.dart';
import 'package:gomiland/game/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/hood_scene.dart';
import 'package:gomiland/game/scenes/park_scene.dart';
import 'package:gomiland/game/scenes/room/room_scene.dart';
import 'package:gomiland/game/scenes/scene_name.dart';

class GomilandWorld extends World
    with KeyboardHandler, HasGameRef<GomilandGame> {
  GomilandWorld({super.children, required bool loadFromSave}) : super() {
    _loadFromSave = loadFromSave;
  }

  SceneName? _newSceneName;

  late bool _loadFromSave;
  late HoodMap hoodMap;
  late ParkMap parkMap;
  late RoomMap roomMap;

  void setNewSceneName(SceneName newSceneName) {
    _newSceneName = newSceneName;
  }

  Future<void> _loadHoodMap(bool fromSave) async {
    game.overlays.add('Loading');
    hoodMap = HoodMap(
      setNewSceneName: setNewSceneName,
      loadFromSave: _loadFromSave,
    );
    await add(hoodMap);
    game.addHudComponentsForWorld();
    game.gameStateBloc.add(const SceneChanged(SceneName.hood));
    game.overlays.remove('Loading');
  }

  Future<void> _loadParkMap(bool fromSave) async {
    game.overlays.add('Loading');
    parkMap = ParkMap(
      setNewSceneName: setNewSceneName,
      loadFromSave: _loadFromSave,
    );
    await add(parkMap);
    game.addHudComponentsForWorld();
    game.gameStateBloc.add(const SceneChanged(SceneName.park));
    game.overlays.remove('Loading');
  }

  Future<void> _loadRoomMap() async {
    roomMap = RoomMap(setNewSceneName: setNewSceneName);
    await add(roomMap);
    game.gameStateBloc.add(const SceneChanged(SceneName.room));
  }

  void _removeComponents() {
    SceneName sceneName = game.gameStateBloc.state.sceneName;
    switch (sceneName) {
      case SceneName.hood:
        remove(hoodMap);
        break;
      case SceneName.park:
        remove(parkMap);
        break;
      case SceneName.room:
        remove(roomMap);
        break;
      default:
        return;
    }
  }

  Future<void> _switchScene(SceneName sceneName) async {
    switch (sceneName) {
      case SceneName.hood:
        await _loadHoodMap(false);
        break;
      case SceneName.park:
        await _loadParkMap(false);
        break;
      case SceneName.room:
        await _loadRoomMap();
        break;
      default:
        return;
    }
  }

  Future<void> _loadMap(bool loadFromSave) async {
    if (loadFromSave) {
      SceneName sceneName = game.playerStateBloc.state.savedLocation;
      // saving is prevented when player is in he room
      if (sceneName == SceneName.park) {
        await _loadParkMap(true);
      } else {
        await _loadHoodMap(true);
      }
    } else {
      await _loadHoodMap(false);
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadMap(_loadFromSave);
    gameRef.overlays.add('MuteButton');
  }

  @override
  void update(double dt) async {
    if (_newSceneName != null) {
      _removeComponents();
      _switchScene(_newSceneName!);
      _newSceneName = null;
    }
  }
}
