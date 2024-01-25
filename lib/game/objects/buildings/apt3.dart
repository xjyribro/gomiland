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
      size: Vector2(256, 96),
      position: Vector2(0, 224),
      collisionType: CollisionType.passive,
    );
    add(hitbox);
    add(
      FadeHitbox(
        position: Vector2.zero(),
        size: Vector2(256, 128),
        onFade: _onFade,
        removeFade: _removeFade,
      ),
    );
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
      other.handleCollisionStart();
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Player) {
      other.handleCollisionEnd();
    }
  }
}

class FadeHitbox extends PositionComponent with CollisionCallbacks {
  FadeHitbox({
    required Vector2 position,
    required Vector2 size,
    required Function onFade,
    required Function removeFade,
  }) : super(
          position: position,
          size: size,
        ) {
    _onFade = onFade;
    _removeFade = removeFade;
  }

  late Function _onFade;
  late Function _removeFade;

  @override
  Future<void> onLoad() async {
    RectangleHitbox hitbox = RectangleHitbox(
      size: size,
      position: Vector2.zero(),
      collisionType: CollisionType.passive,
      isSolid: true
    );
    add(hitbox);
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
