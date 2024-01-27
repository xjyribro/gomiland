import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/hood_scene.dart';
import 'package:gomiland/game/scenes/park_scene.dart';
import 'package:gomiland/game/scenes/room/room_scene.dart';

// scene manager
class GomilandWorld extends World
    with
        KeyboardHandler,
        HasGameRef<GomilandGame>,
        FlameBlocReader<GameStateBloc, GameState> {
  GomilandWorld({super.children});

  SceneName? _newSceneName;

  late HoodMap hoodMap;
  late ParkMap parkMap;
  late RoomMap roomMap;

  void _setNewSceneName(SceneName newSceneName) {
    _newSceneName = newSceneName;
  }

  void _removeComponents() {
    SceneName sceneName = bloc.state.sceneName;
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
    SceneName sceneName = game.gameStateBloc.state.sceneName;
    final bool comingFromPark = sceneName == SceneName.park;
    Vector2 playerStartPosit =
        comingFromPark ? Vector2(1800, 650) : Vector2(1800, 650);
    hoodMap = HoodMap(
      setNewSceneName: _setNewSceneName,
      playerStartPosit: playerStartPosit,
    );
    await add(hoodMap);
  }

  Future<void> _loadParkMap() async {
    Vector2 playerStartPosit = Vector2(1800, 650);
    parkMap = ParkMap(
      setNewSceneName: _setNewSceneName,
      playerStartPosit: playerStartPosit,
    );
    await add(parkMap);
  }

  Future<void> _loadRoomMap() async {
    roomMap = RoomMap(setNewSceneName: _setNewSceneName);
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

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyR) {
        add(game.dialogueControllerComponent);
        game.overlays.add('DialogueBox');
        game.dialogueRunner.startDialogue('example');
      }
      if (event.logicalKey == LogicalKeyboardKey.keyT) {
        remove(game.dialogueControllerComponent);
        game.overlays.remove('DialogueBox');
      }
      return false;
    }
    return true;
  }
}
