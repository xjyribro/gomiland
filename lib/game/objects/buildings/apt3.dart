import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/player/player.dart';

class Apt3 extends SpriteComponent with CollisionCallbacks {
  Apt3({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_buildings_apt3_png);
    RectangleHitbox hitbox = RectangleHitbox(
      size: Vector2(256, 224),
      position: Vector2.zero(),
      collisionType: CollisionType.passive,
      isSolid: true,
    );
    add(hitbox);
  }

  void _onFade() {
    print('hit');
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