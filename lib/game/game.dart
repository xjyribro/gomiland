import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/scenes/hood_scene.dart';

class GameWidgetWrapper extends StatelessWidget{
  const GameWidgetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: GomilandGame());
  }
}

class GomilandGame extends FlameGame with HasKeyboardHandlerComponents {
  GomilandGame() : world = GomilandWorld() {
    cameraComponent = CameraComponent(world: world);
    images.prefix = '';
  }

  late final CameraComponent cameraComponent;
  World world;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      Assets.assets_assets_images_player_player_png,
    ]);
    addAll([cameraComponent, world]);
    debugMode = true;
  }
}
