import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';

class RubbishSpawner extends SpriteComponent {
  RubbishSpawner({required Vector2 position}) : super(position: position);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_rubbish_rubbish_small_png);
    add(RectangleHitbox(
      size: Vector2(16, 16),
      position: Vector2(16, 16),
      anchor: Anchor.center,
    ));
  }
}
