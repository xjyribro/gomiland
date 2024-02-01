import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';

class Temizuya extends SpriteAnimationComponent {
  Temizuya({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    final image =
        await Flame.images.load(Assets.assets_images_spritesheets_temizuya_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(96, 64),
    );

    animation = spriteSheet.createAnimation(row: 0, stepTime: stepTime);
  }
}
