import 'package:bonfire/bonfire.dart';
import 'package:gomiland/utils/load_images.dart';

class UIOverlay extends GameInterface {
  late Sprite key;

  @override
  Future<void> onLoad() async {

    final spriteSheet = SpriteSheet(
      image: await LoadImage('assets/images/spritesheets/coin_small.png'),
      srcSize: Vector2(32, 32),
    );

    final coinAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 6);

    final animatedCoin = SpriteAnimationComponent(
      animation: coinAnimation,
      position: Vector2(150, 100),
      size: Vector2(32, 32),
    );

    add(animatedCoin);

    return super.onLoad();
  }
}
