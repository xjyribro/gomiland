import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/game.dart';

class LightSprite extends SpriteComponent with HasGameReference<GomilandGame>{
  LightSprite({
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2(128, 96),
        );

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache(
      Assets.assets_images_objects_light_png,
    ));
  }
}
