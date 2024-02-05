import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';

class LightSprite extends SpriteComponent {
  LightSprite({
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2(128, 96),
        );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_objects_light_png);
  }
}
