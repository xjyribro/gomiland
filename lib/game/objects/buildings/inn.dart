import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/player/player.dart';

class Inn extends SpriteAnimationComponent with CollisionCallbacks {
  Inn({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    final image =
        await Flame.images.load(Assets.assets_images_buildings_inn_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(128, 256),
    );
    animation = SpriteAnimation.fromFrameData(
        spriteSheet.image,
        SpriteAnimationData([
          spriteSheet.createFrameData(0, 0, stepTime: stepTime),
          spriteSheet.createFrameData(0, 1, stepTime: stepTime),
          spriteSheet.createFrameData(0, 2, stepTime: stepTime),
          spriteSheet.createFrameData(0, 3, stepTime: stepTime),
          spriteSheet.createFrameData(0, 4, stepTime: stepTime),
          spriteSheet.createFrameData(1, 0, stepTime: stepTime),
          spriteSheet.createFrameData(1, 1, stepTime: stepTime),
          spriteSheet.createFrameData(1, 2, stepTime: stepTime),
          spriteSheet.createFrameData(1, 3, stepTime: stepTime),
          spriteSheet.createFrameData(1, 4, stepTime: stepTime),
        ]));

    RectangleHitbox hitbox = RectangleHitbox(
        size: Vector2(128, 160),
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
