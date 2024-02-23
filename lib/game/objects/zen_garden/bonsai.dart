import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/assets.dart';

class Bonsai extends SpriteComponent {
  Bonsai({
    required Vector2 position,
    required Vector2 size,
    required int id,
  }) : super(position: position, size: size) {
    _id = id;
  }

  late int _id;

  @override
  Future<void> onLoad() async {
    final image =
        await Flame.images.load(Assets.assets_images_tile_maps_bonsai_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(64, 64),
    );
    sprite = spriteSheet.getSprite(0, _id);
  }
}
