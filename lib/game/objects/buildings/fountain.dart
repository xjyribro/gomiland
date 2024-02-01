import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';

class Fountain extends SpriteAnimationComponent {
  Fountain({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    final image =
        await Flame.images.load(Assets.assets_images_spritesheets_fountain_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(64, 96),
    );
    animation = spriteSheet.createAnimation(row: 0, stepTime: stepTime);
  }
}
