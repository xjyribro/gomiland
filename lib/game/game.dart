import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/contants.dart';
import 'package:gomiland/game/player/player.dart';

class GameWidgetWrapper extends StatelessWidget{
  const GameWidgetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: GomilandGame());
  }

}

class GomilandGame extends FlameGame with HasKeyboardHandlerComponents {
  GomilandGame() : world = GWorld() {
    cameraComponent = CameraComponent(world: world);
    images.prefix = '';
  }

  late final CameraComponent cameraComponent;
  final GWorld world;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      Assets.assets_assets_images_player_idle_up_png,
      Assets.assets_assets_images_player_idle_left_png,
      Assets.assets_assets_images_player_idle_right_png,
      Assets.assets_assets_images_player_move_down_png,
      Assets.assets_assets_images_player_move_up_png,
      Assets.assets_assets_images_player_move_left_png,
      Assets.assets_assets_images_player_move_right_png,
      Assets.assets_assets_images_player_player_png,
    ]);
    addAll([cameraComponent, world]);
    debugMode = true;
  }
}

class GWorld extends World with HasGameRef<GomilandGame> {
  GWorld({super.children});

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
      'hood_base.tmx',
      Vector2.all(tileSize),
    );

    player = Player();
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
}
