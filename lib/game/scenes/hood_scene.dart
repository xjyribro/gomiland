import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gomiland/contants.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/player/player.dart';

enum Scene {HOOD, PARK, ROOM}

class GomilandWorld extends World with HasGameRef<GomilandGame> {
  GomilandWorld({super.children});

  late Vector2 size = Vector2(
    map.tileMap.map.width * tileSize,
    map.tileMap.map.height * tileSize,
  );
  final unwalkableComponentEdges = <Line>[];
  late final Player player;

  late TiledComponent map;

  @override
  Future<void> onLoad() async {
    map = await TiledComponent.load(
      'park.tmx',
      Vector2.all(tileSize),
    );

    player = Player(position: Vector2.all(32));
    addAll([map, player]);

    // Set up Camera
    gameRef.cameraComponent.follow(player);
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

  Future<void> _switchScene(Scene scene) async{
    switch (scene) {
      case Scene.HOOD:
        map = await TiledComponent.load(
          'hood.tmx',
          Vector2.all(tileSize),
        );
        break;
      case Scene.PARK:
        map = await TiledComponent.load(
          'park.tmx',
          Vector2.all(tileSize),
        );
        break;
      case Scene.ROOM:
        break;
      default: return;
    }
  }

  @override
  void update(double dt) async {
  }
}
