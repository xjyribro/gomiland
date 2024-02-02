import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';

class Pilar extends SpriteComponent {
  Pilar({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_buildings_school_png);
  }
}
