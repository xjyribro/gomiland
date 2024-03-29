import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';

class Piler extends SpriteAnimationComponent {
  Piler({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    final image =
        await Flame.images.load(Assets.assets_images_spritesheets_piler_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(96, 96),
    );
    animation = SpriteAnimation.fromFrameData(
      spriteSheet.image,
      SpriteAnimationData([
        spriteSheet.createFrameData(0, 0, stepTime: stepTime),
        spriteSheet.createFrameData(0, 1, stepTime: stepTime),
        spriteSheet.createFrameData(0, 2, stepTime: stepTime),
        spriteSheet.createFrameData(0, 3, stepTime: stepTime),
        spriteSheet.createFrameData(0, 4, stepTime: stepTime),
        spriteSheet.createFrameData(0, 5, stepTime: stepTime),
        spriteSheet.createFrameData(0, 6, stepTime: stepTime),
        spriteSheet.createFrameData(0, 7, stepTime: stepTime),
        spriteSheet.createFrameData(1, 0, stepTime: stepTime),
        spriteSheet.createFrameData(1, 1, stepTime: stepTime),
        spriteSheet.createFrameData(1, 2, stepTime: stepTime),
        spriteSheet.createFrameData(1, 3, stepTime: stepTime),
        spriteSheet.createFrameData(1, 4, stepTime: stepTime),
        spriteSheet.createFrameData(1, 5, stepTime: stepTime),
        spriteSheet.createFrameData(1, 6, stepTime: stepTime),
        spriteSheet.createFrameData(1, 7, stepTime: stepTime),
        spriteSheet.createFrameData(3, 0, stepTime: stepTime),
        spriteSheet.createFrameData(3, 1, stepTime: stepTime),
        spriteSheet.createFrameData(3, 2, stepTime: stepTime),
        spriteSheet.createFrameData(3, 3, stepTime: stepTime),
        spriteSheet.createFrameData(3, 4, stepTime: stepTime),
        spriteSheet.createFrameData(3, 5, stepTime: stepTime),
        spriteSheet.createFrameData(3, 6, stepTime: stepTime),
        spriteSheet.createFrameData(3, 7, stepTime: stepTime),
        spriteSheet.createFrameData(4, 0, stepTime: stepTime),
        spriteSheet.createFrameData(4, 1, stepTime: stepTime),
        spriteSheet.createFrameData(4, 2, stepTime: stepTime),
        spriteSheet.createFrameData(4, 3, stepTime: stepTime),
        spriteSheet.createFrameData(4, 4, stepTime: stepTime),
        spriteSheet.createFrameData(4, 5, stepTime: stepTime),
        spriteSheet.createFrameData(4, 6, stepTime: stepTime),
        spriteSheet.createFrameData(4, 7, stepTime: stepTime),
        spriteSheet.createFrameData(5, 0, stepTime: stepTime),
        spriteSheet.createFrameData(5, 1, stepTime: stepTime),
        spriteSheet.createFrameData(5, 2, stepTime: stepTime),
        spriteSheet.createFrameData(5, 3, stepTime: stepTime),
        spriteSheet.createFrameData(5, 4, stepTime: stepTime),
        spriteSheet.createFrameData(5, 5, stepTime: stepTime),
        spriteSheet.createFrameData(5, 6, stepTime: stepTime),
        spriteSheet.createFrameData(5, 7, stepTime: stepTime),
        spriteSheet.createFrameData(6, 0, stepTime: stepTime),
        spriteSheet.createFrameData(6, 1, stepTime: stepTime),
        spriteSheet.createFrameData(6, 2, stepTime: stepTime),
        spriteSheet.createFrameData(6, 3, stepTime: stepTime),
        spriteSheet.createFrameData(6, 4, stepTime: stepTime),
        spriteSheet.createFrameData(6, 5, stepTime: stepTime),
        spriteSheet.createFrameData(6, 6, stepTime: stepTime),
        spriteSheet.createFrameData(6, 7, stepTime: stepTime),
        spriteSheet.createFrameData(7, 0, stepTime: stepTime),
        spriteSheet.createFrameData(7, 1, stepTime: stepTime),
        spriteSheet.createFrameData(7, 2, stepTime: stepTime),
        spriteSheet.createFrameData(7, 3, stepTime: stepTime),
        spriteSheet.createFrameData(7, 4, stepTime: stepTime),
        spriteSheet.createFrameData(7, 5, stepTime: stepTime),
        spriteSheet.createFrameData(7, 6, stepTime: stepTime),
        spriteSheet.createFrameData(7, 7, stepTime: stepTime),
        spriteSheet.createFrameData(8, 0, stepTime: stepTime),
        spriteSheet.createFrameData(8, 1, stepTime: stepTime),
        spriteSheet.createFrameData(8, 2, stepTime: stepTime),
        spriteSheet.createFrameData(8, 3, stepTime: stepTime),
        spriteSheet.createFrameData(8, 4, stepTime: stepTime),
        spriteSheet.createFrameData(8, 5, stepTime: stepTime),
        spriteSheet.createFrameData(8, 6, stepTime: stepTime),
        spriteSheet.createFrameData(8, 7, stepTime: stepTime),
        spriteSheet.createFrameData(9, 0, stepTime: stepTime),
        spriteSheet.createFrameData(9, 1, stepTime: stepTime),
        spriteSheet.createFrameData(9, 2, stepTime: stepTime),
        spriteSheet.createFrameData(9, 3, stepTime: stepTime),
        spriteSheet.createFrameData(9, 4, stepTime: stepTime),
        spriteSheet.createFrameData(9, 5, stepTime: stepTime),
        spriteSheet.createFrameData(9, 6, stepTime: stepTime),
        spriteSheet.createFrameData(9, 7, stepTime: stepTime),
        spriteSheet.createFrameData(10, 0, stepTime: stepTime),
        spriteSheet.createFrameData(10, 1, stepTime: stepTime),
        spriteSheet.createFrameData(10, 2, stepTime: stepTime),
        spriteSheet.createFrameData(10, 3, stepTime: stepTime),
        spriteSheet.createFrameData(10, 4, stepTime: stepTime),
        spriteSheet.createFrameData(10, 5, stepTime: stepTime),
        spriteSheet.createFrameData(10, 6, stepTime: stepTime),
        spriteSheet.createFrameData(10, 7, stepTime: stepTime),
        spriteSheet.createFrameData(11, 0, stepTime: stepTime),
        spriteSheet.createFrameData(11, 1, stepTime: stepTime),
        spriteSheet.createFrameData(11, 2, stepTime: stepTime),
        spriteSheet.createFrameData(11, 3, stepTime: stepTime),
        spriteSheet.createFrameData(11, 4, stepTime: stepTime),
        spriteSheet.createFrameData(11, 5, stepTime: stepTime),
        spriteSheet.createFrameData(11, 6, stepTime: stepTime),
        spriteSheet.createFrameData(11, 7, stepTime: stepTime),
        spriteSheet.createFrameData(12, 0, stepTime: stepTime),
        spriteSheet.createFrameData(12, 1, stepTime: stepTime),
        spriteSheet.createFrameData(12, 2, stepTime: stepTime),
        spriteSheet.createFrameData(12, 3, stepTime: stepTime),
        spriteSheet.createFrameData(12, 4, stepTime: stepTime),
        spriteSheet.createFrameData(12, 5, stepTime: stepTime),
        spriteSheet.createFrameData(12, 6, stepTime: stepTime),
        spriteSheet.createFrameData(12, 7, stepTime: stepTime),
        spriteSheet.createFrameData(13, 0, stepTime: stepTime),
        spriteSheet.createFrameData(13, 1, stepTime: stepTime),
        spriteSheet.createFrameData(13, 2, stepTime: stepTime),
        spriteSheet.createFrameData(13, 3, stepTime: stepTime),
        spriteSheet.createFrameData(13, 4, stepTime: stepTime),
        spriteSheet.createFrameData(13, 5, stepTime: stepTime),
        spriteSheet.createFrameData(13, 6, stepTime: stepTime),
        spriteSheet.createFrameData(13, 7, stepTime: stepTime),
        spriteSheet.createFrameData(14, 0, stepTime: stepTime),
        spriteSheet.createFrameData(14, 1, stepTime: stepTime),
        spriteSheet.createFrameData(14, 2, stepTime: stepTime),
        spriteSheet.createFrameData(14, 3, stepTime: stepTime),
        spriteSheet.createFrameData(14, 4, stepTime: stepTime),
        spriteSheet.createFrameData(14, 5, stepTime: stepTime),
        spriteSheet.createFrameData(14, 6, stepTime: stepTime),
        spriteSheet.createFrameData(14, 7, stepTime: stepTime),
        spriteSheet.createFrameData(15, 0, stepTime: stepTime),
        spriteSheet.createFrameData(15, 1, stepTime: stepTime),
        spriteSheet.createFrameData(15, 2, stepTime: stepTime),
        spriteSheet.createFrameData(15, 3, stepTime: stepTime),
        spriteSheet.createFrameData(15, 4, stepTime: stepTime),
        spriteSheet.createFrameData(15, 5, stepTime: stepTime),
        spriteSheet.createFrameData(15, 6, stepTime: stepTime),
        spriteSheet.createFrameData(15, 7, stepTime: stepTime),
        spriteSheet.createFrameData(16, 0, stepTime: stepTime),
        spriteSheet.createFrameData(16, 1, stepTime: stepTime),
        spriteSheet.createFrameData(16, 2, stepTime: stepTime),
        spriteSheet.createFrameData(16, 3, stepTime: stepTime),
        spriteSheet.createFrameData(16, 4, stepTime: stepTime),
        spriteSheet.createFrameData(16, 5, stepTime: stepTime),
        spriteSheet.createFrameData(16, 6, stepTime: stepTime),
        spriteSheet.createFrameData(16, 7, stepTime: stepTime),
        spriteSheet.createFrameData(17, 0, stepTime: stepTime),
        spriteSheet.createFrameData(17, 1, stepTime: stepTime),
        spriteSheet.createFrameData(17, 2, stepTime: stepTime),
        spriteSheet.createFrameData(17, 3, stepTime: stepTime),
        spriteSheet.createFrameData(17, 4, stepTime: stepTime),
        spriteSheet.createFrameData(17, 5, stepTime: stepTime),
        spriteSheet.createFrameData(17, 6, stepTime: stepTime),
        spriteSheet.createFrameData(17, 7, stepTime: stepTime),
        spriteSheet.createFrameData(18, 0, stepTime: stepTime),
        spriteSheet.createFrameData(18, 1, stepTime: stepTime),
        spriteSheet.createFrameData(18, 2, stepTime: stepTime),
        spriteSheet.createFrameData(18, 3, stepTime: stepTime),
        spriteSheet.createFrameData(18, 4, stepTime: stepTime),
        spriteSheet.createFrameData(18, 5, stepTime: stepTime),
        spriteSheet.createFrameData(18, 6, stepTime: stepTime),
        spriteSheet.createFrameData(18, 7, stepTime: stepTime),
        spriteSheet.createFrameData(19, 0, stepTime: stepTime),
        spriteSheet.createFrameData(19, 1, stepTime: stepTime),
        spriteSheet.createFrameData(19, 2, stepTime: stepTime),
        spriteSheet.createFrameData(19, 3, stepTime: stepTime),
        spriteSheet.createFrameData(19, 4, stepTime: stepTime),
        spriteSheet.createFrameData(19, 5, stepTime: stepTime),
        spriteSheet.createFrameData(19, 6, stepTime: stepTime),
        spriteSheet.createFrameData(19, 7, stepTime: stepTime),
        spriteSheet.createFrameData(20, 0, stepTime: stepTime),
        spriteSheet.createFrameData(20, 1, stepTime: stepTime),
        spriteSheet.createFrameData(20, 2, stepTime: stepTime),
        spriteSheet.createFrameData(20, 3, stepTime: stepTime),
        spriteSheet.createFrameData(20, 4, stepTime: stepTime),
        spriteSheet.createFrameData(20, 5, stepTime: stepTime),
        spriteSheet.createFrameData(20, 6, stepTime: stepTime),
        spriteSheet.createFrameData(20, 7, stepTime: stepTime),
        spriteSheet.createFrameData(21, 0, stepTime: stepTime),
        spriteSheet.createFrameData(21, 1, stepTime: stepTime),
        spriteSheet.createFrameData(21, 2, stepTime: stepTime),
        spriteSheet.createFrameData(21, 3, stepTime: stepTime),
        spriteSheet.createFrameData(21, 4, stepTime: stepTime),
        spriteSheet.createFrameData(21, 5, stepTime: stepTime),
        spriteSheet.createFrameData(21, 6, stepTime: stepTime),
        spriteSheet.createFrameData(21, 7, stepTime: stepTime),
        spriteSheet.createFrameData(22, 0, stepTime: stepTime),
        spriteSheet.createFrameData(22, 1, stepTime: stepTime),
        spriteSheet.createFrameData(22, 2, stepTime: stepTime),
        spriteSheet.createFrameData(22, 3, stepTime: stepTime),
        spriteSheet.createFrameData(22, 4, stepTime: stepTime),
        spriteSheet.createFrameData(22, 5, stepTime: stepTime),
        spriteSheet.createFrameData(22, 6, stepTime: stepTime),
        spriteSheet.createFrameData(22, 7, stepTime: stepTime),
        spriteSheet.createFrameData(23, 0, stepTime: stepTime),
        spriteSheet.createFrameData(23, 1, stepTime: stepTime),
        spriteSheet.createFrameData(23, 2, stepTime: stepTime),
        spriteSheet.createFrameData(23, 3, stepTime: stepTime),
        spriteSheet.createFrameData(23, 4, stepTime: stepTime),
        spriteSheet.createFrameData(23, 5, stepTime: stepTime),
        spriteSheet.createFrameData(23, 6, stepTime: stepTime),
        spriteSheet.createFrameData(23, 7, stepTime: stepTime),
        spriteSheet.createFrameData(24, 0, stepTime: stepTime),
        spriteSheet.createFrameData(24, 1, stepTime: stepTime),
        spriteSheet.createFrameData(24, 2, stepTime: stepTime),
        spriteSheet.createFrameData(24, 3, stepTime: stepTime),
        spriteSheet.createFrameData(24, 4, stepTime: stepTime),
        spriteSheet.createFrameData(24, 5, stepTime: stepTime),
        spriteSheet.createFrameData(24, 6, stepTime: stepTime),
        spriteSheet.createFrameData(24, 7, stepTime: stepTime),
        spriteSheet.createFrameData(25, 0, stepTime: stepTime),
        spriteSheet.createFrameData(25, 1, stepTime: stepTime),
        spriteSheet.createFrameData(25, 2, stepTime: stepTime),
        spriteSheet.createFrameData(25, 3, stepTime: stepTime),
        spriteSheet.createFrameData(25, 4, stepTime: stepTime),
        spriteSheet.createFrameData(25, 5, stepTime: stepTime),
        spriteSheet.createFrameData(25, 6, stepTime: stepTime),
        spriteSheet.createFrameData(25, 7, stepTime: stepTime),
        spriteSheet.createFrameData(26, 0, stepTime: stepTime),
        spriteSheet.createFrameData(26, 1, stepTime: stepTime),
        spriteSheet.createFrameData(26, 2, stepTime: stepTime),
        spriteSheet.createFrameData(26, 3, stepTime: stepTime),
        spriteSheet.createFrameData(26, 4, stepTime: stepTime),
        spriteSheet.createFrameData(26, 5, stepTime: stepTime),
        spriteSheet.createFrameData(26, 6, stepTime: stepTime),
        spriteSheet.createFrameData(26, 7, stepTime: stepTime),
      ]),
    );
  }
}
