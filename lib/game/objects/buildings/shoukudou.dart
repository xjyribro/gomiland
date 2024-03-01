import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/player/player.dart';

class Shoukudou extends SpriteAnimationComponent with CollisionCallbacks {
  Shoukudou({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    final image =
        await Flame.images.load(Assets.assets_images_buildings_shoukudou_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(256, 192),
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
          spriteSheet.createFrameData(2, 0, stepTime: stepTime),
          spriteSheet.createFrameData(2, 1, stepTime: stepTime),
          spriteSheet.createFrameData(2, 2, stepTime: stepTime),
          spriteSheet.createFrameData(2, 3, stepTime: stepTime),
          spriteSheet.createFrameData(2, 4, stepTime: stepTime),
          spriteSheet.createFrameData(2, 5, stepTime: stepTime),
          spriteSheet.createFrameData(2, 6, stepTime: stepTime),
          spriteSheet.createFrameData(2, 7, stepTime: stepTime),
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
        ]));

    RectangleHitbox hitbox = RectangleHitbox(
        size: Vector2(256, 160),
        position: Vector2.zero(),
        collisionType: CollisionType.passive,
        isSolid: true);
    add(hitbox);
  }

  void _onFade() {
    List<OpacityEffect> effects = children.query<OpacityEffect>();
    removeAll(effects);
    add(OpacityEffect.to(.3, EffectController(duration: 0.5)));
  }

  void _removeFade() {
    List<OpacityEffect> effects = children.query<OpacityEffect>();
    removeAll(effects);
    add(OpacityEffect.fadeIn(EffectController(duration: 0.5)));
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Player) {
      _onFade();
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Player) {
      _removeFade();
    }
  }
}
