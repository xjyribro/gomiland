import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/player/player.dart';
import 'package:gomiland/game/scenes/hood_scene.dart';
import 'package:gomiland/game/scenes/park_scene.dart';

class GomilandWorld extends World
    with HasGameRef<GomilandGame>, FlameBlocReader<GameStateBloc, GameState> {
  GomilandWorld({super.children});

  final unwalkableComponentEdges = <Line>[];
  late Player player;
  SceneName? _newSceneName;

  late HoodMap hoodMap;
  late ParkMap parkMap;

  void _setNewSceneName(SceneName newSceneName) {
    _newSceneName = newSceneName;
  }

  void _removeComponents() {
    remove(player);
    SceneName sceneName = bloc.state.sceneName;
    switch (sceneName) {
      case SceneName.hood:
        remove(hoodMap);
        break;
      case SceneName.park:
        remove(parkMap);
        break;
      case SceneName.room:
        break;
      default:
        return;
    }
  }

  Future<void> _loadPlayer(Vector2 position) async {
    player = Player(position: position);
    add(player);
    gameRef.cameraComponent.follow(player);
  }

  Future<void> _loadHoodMap() async {
    await add(hoodMap);
  }

  Future<void> _loadParkMap() async {
    await add(parkMap);
  }

  Future<void> _loadHoodScene() async {
    await _loadHoodMap();
    Vector2 playerStartingPosit = Vector2.all(200);
    await _loadPlayer(playerStartingPosit);
  }

  Future<void> _loadParkScene() async {
    await _loadParkMap();
    Vector2 playerStartingPosit = Vector2.all(150);
    await _loadPlayer(playerStartingPosit);
  }

  Future<void> _switchScene(SceneName sceneName) async {
    _removeComponents();
    switch (sceneName) {
      case SceneName.hood:
        await _loadHoodScene();
        break;
      case SceneName.park:
        await _loadParkScene();
        break;
      case SceneName.room:
        break;
      default:
        return;
    }
    game.gameStateBloc.add(SceneChanged(sceneName));
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    hoodMap = HoodMap(setNewSceneName: _setNewSceneName);
    parkMap = ParkMap(setNewSceneName: _setNewSceneName);
    await _loadHoodScene();
    gameRef.overlays.add('MuteButton');
    gameRef.overlays.add('DialogueBox');
  }

  @override
  void update(double dt) async {
    if (_newSceneName != null) {
      _switchScene(_newSceneName!);
      _newSceneName = null;
    }
  }
}
