import 'package:flame/components.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/scenes/scene_name.dart';
import 'package:gomiland/game/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/hood_scene.dart';
import 'package:gomiland/game/scenes/park_scene.dart';
import 'package:gomiland/game/scenes/room/room_scene.dart';

class GomilandWorld extends World
    with KeyboardHandler, HasGameRef<GomilandGame> {
  GomilandWorld({super.children});

  SceneName? _newSceneName;

  late HoodMap hoodMap;
  late ParkMap parkMap;
  late RoomMap roomMap;

  void setNewSceneName(SceneName newSceneName) {
    _newSceneName = newSceneName;
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

  Future<void> _loadHoodMap() async {
    game.overlays.add('Loading');
    SceneName sceneName = game.gameStateBloc.state.sceneName;
    final bool comingFromPark = sceneName == SceneName.park;
    Vector2 playerStartPosit = comingFromPark
        ? Vector2(hoodStartFromParkX, hoodStartFromParkY)
        : Vector2(hoodStartFromRoomX, hoodStartFromRoomY);
    hoodMap = HoodMap(
      setNewSceneName: setNewSceneName,
      playerStartPosit: playerStartPosit,
    );
    await add(hoodMap);
    game.addHudComponentsForWorld();
    game.overlays.remove('Loading');
  }

  Future<void> _loadParkMap() async {
    game.overlays.add('Loading');
    Vector2 playerStartPosit = Vector2(parkStartX, parkStartY);
    parkMap = ParkMap(
      setNewSceneName: setNewSceneName,
      playerStartPosit: playerStartPosit,
    );
    await add(parkMap);
    game.addHudComponentsForWorld();
    game.overlays.remove('Loading');
  }

  Future<void> _loadRoomMap() async {
    roomMap = RoomMap(setNewSceneName: setNewSceneName);
    await add(roomMap);
  }

  Future<void> _switchScene(SceneName sceneName) async {
    _removeComponents();
    switch (sceneName) {
      case SceneName.hood:
        await _loadHoodMap();
        break;
      case SceneName.park:
        await _loadParkMap();
        break;
      case SceneName.room:
        await _loadRoomMap();
        break;
      default:
        return;
    }
    game.gameStateBloc.add(SceneChanged(sceneName));
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadHoodMap();
    gameRef.overlays.add('MuteButton');
  }

  @override
  void update(double dt) async {
    if (_newSceneName != null) {
      _switchScene(_newSceneName!);
      _newSceneName = null;
    }
  }
}
