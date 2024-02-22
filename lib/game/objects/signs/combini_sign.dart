import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/objects/obsticle.dart';

class CombiniSign extends SpriteComponent with HasGameReference<GomilandGame> {
  CombiniSign({required Vector2 super.position});

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_objects_go_sign_png);
    Obstacle obstacle =
        Obstacle(size: Vector2(16, 32), position: Vector2(8, 64));
    add(obstacle);
  }
}
