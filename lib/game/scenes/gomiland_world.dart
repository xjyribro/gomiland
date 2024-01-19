import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/geometry.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/constants.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/player/player.dart';
import 'package:gomiland/game/scenes/gate.dart';

class GomilandWorld extends World with HasGameRef<GomilandGame> {
  GomilandWorld({super.children});

  late Vector2 size = Vector2(
    map.tileMap.map.width * tileSize,
    map.tileMap.map.height * tileSize,
  );
  final unwalkableComponentEdges = <Line>[];
  late Player player;
  late TiledComponent map;
  SceneName? _newSceneName;

  void _setNewSceneName(SceneName newSceneName) {
    _newSceneName = newSceneName;
  }

  void _removeSceneComponents() {
    removeAll([map, player]);
  }

  Future<void> _loadPlayer(Vector2 position) async {
    player = Player(position: position);
    add(player);
    gameRef.cameraComponent.follow(player);
  }

  Future<void> _loadHoodMap() async {
    map = await TiledComponent.load(
      'hood.tmx',
      Vector2.all(tileSize),
    );
    add(map);

    final objectLayer = map.tileMap.getLayer<ObjectGroup>('gates');

    if (objectLayer != null) {
      for (final TiledObject object in objectLayer.objects) {
        add(
          Gate(
            position: Vector2(object.x, object.y),
            size: Vector2(object.width, object.height),
            switchScene: () => _setNewSceneName(SceneName.park),
          ),
        );
      }
    }
  }

  Future<void> _loadParkMap() async {
    map = await TiledComponent.load(
      'park.tmx',
      Vector2.all(tileSize),
    );
    add(map);

    final objectLayer = map.tileMap.getLayer<ObjectGroup>('gates');
    if (objectLayer != null) {
      for (final TiledObject object in objectLayer.objects) {
        add(
          Gate(
            position: Vector2(object.x, object.y),
            size: Vector2(object.width, object.height),
            switchScene: () => _setNewSceneName(SceneName.hood),
          ),
        );
      }
    }
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

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    setCameraBounds(size);
  }

  void setCameraBounds(Vector2 gameSize) {
    gameRef.cameraComponent.setBounds(
      Rectangle.fromLTRB(
        gameSize.x / 2,
        gameSize.y / 2,
        size.x - gameSize.x / 2,
        size.y - gameSize.y / 2,
      ),
    );
  }

  Future<void> _switchScene(SceneName sceneName) async {
    switch (sceneName) {
      case SceneName.hood:
        _removeSceneComponents();
        await _loadHoodScene();
        break;
      case SceneName.park:
        _removeSceneComponents();
        await _loadParkScene();
        break;
      case SceneName.room:
        break;
      default:
        return;
    }
  }

  @override
  Future<void> onLoad() async {
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
