import 'dart:io';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/player/player.dart';
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

  final unwalkableComponentEdges = <Line>[];
  late Player player;
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
        removeAll([hoodMap, player]);
        break;
      case SceneName.park:
        removeAll([parkMap, player]);
        break;
      case SceneName.room:
        remove(roomMap);
        break;
      default:
        return;
    }
  }

  Future<void> _loadPlayer(Vector2 position) async {
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    JoystickComponent joystick = JoystickComponent(
      knob: CircleComponent(radius: 16, paint: knobPaint),
      background: CircleComponent(radius: 32, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    player = Player(
      position: position,
      joystickComponent: joystick,
    );
    add(player);
    gameRef.cameraComponent.follow(player);
    gameRef.cameraComponent.viewport.add(joystick);
  }

  Future<void> _loadHoodMap() async {
    game.gameStateBloc.add(const SceneChanged(SceneName.hood));
    await add(hoodMap);
  }

  Future<void> _loadParkMap() async {
    game.gameStateBloc.add(const SceneChanged(SceneName.park));
    await add(parkMap);
  }

  Future<void> _loadRoomMap() async {
    game.gameStateBloc.add(const SceneChanged(SceneName.room));
    await add(roomMap);
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
    hoodMap = HoodMap(setNewSceneName: _setNewSceneName);
    parkMap = ParkMap(setNewSceneName: _setNewSceneName);
    roomMap = RoomMap(setNewSceneName: _setNewSceneName);
    await _loadHoodScene();
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
