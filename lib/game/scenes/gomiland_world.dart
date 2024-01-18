import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/geometry.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomiland/contants.dart';
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
  late final Player player;

  late TiledComponent map;
  SceneName? _newSceneName;

  void _setNewSceneName(SceneName newSceneName) {
    _newSceneName = newSceneName;
  }

  @override
  Future<void> onLoad() async {
    // load first scene
    map = await TiledComponent.load(
      'hood.tmx',
      Vector2.all(tileSize),
    );
    player = Player(position: Vector2.all(200));
    addAll([map, player]);
    // Set up Camera
    gameRef.cameraComponent.follow(player);

    final objectLayer = map.tileMap.getLayer<ObjectGroup>('gates')!;
    for (final TiledObject object in objectLayer.objects) {
      add(
        Gate(
          position: Vector2(object.x, object.y),
          size: Vector2(object.width, object.height),
          switchScene: () => _setNewSceneName(SceneName.PARK),
        ),
      );
    }
    gameRef.overlays.add('MuteButton');
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
      case SceneName.HOOD:
        remove(map);
        map = await TiledComponent.load(
          'hood.tmx',
          Vector2.all(tileSize),
        );
        add(map);
        break;
      case SceneName.PARK:
        remove(map);
        map = await TiledComponent.load(
          'park.tmx',
          Vector2.all(tileSize),
        );
        add(map);
        break;
      case SceneName.ROOM:
        break;
      default:
        return;
    }
  }

  @override
  void update(double dt) async {
    if (_newSceneName != null) {
      _switchScene(_newSceneName!) ;
      _newSceneName = null;
    }
  }
}
