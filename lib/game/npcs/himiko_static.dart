import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';

class HimikoStatic extends SpriteComponent {
  HimikoStatic({required super.position});

  late SpriteAnimation idleUp;
  late SpriteAnimation idleDown;
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;

  @override
  void onLoad() async {
    final image = await Flame.images.load(Assets.assets_images_npcs_himiko_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2.all(tileSize),
    );

    sprite = spriteSheet.getSprite(0, 0);
  }
}
