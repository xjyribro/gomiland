import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/assets.dart';

class MiniMapPlayer extends SpriteComponent {
  MiniMapPlayer({
    required Vector2 position,
    required bool isMale,
  }) : super(
          position: position,
          size: Vector2.all(32),
          anchor: Anchor.center,
        ) {
    _isMale = isMale;
  }

  late bool _isMale;

  @override
  Future<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load(
        _isMale
            ? Assets.assets_images_player_male_png
            : Assets.assets_images_player_female_png,
      ),
      srcSize: Vector2.all(32),
    );
    sprite = spriteSheet.getSprite(0, 0);
  }
}
