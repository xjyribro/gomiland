import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:gomiland/game/player/player.dart';

class BuildingWithFade extends SpriteComponent with CollisionCallbacks {
  BuildingWithFade({
    required Vector2 position,
    required Vector2 size,
    required Vector2 hitboxSize,
    required String spritePath,
    Vector2? hitboxPosition,
  }) : super(position: position, size: size) {
    _spritePath = spritePath;
    _hitboxSize = hitboxSize;
    _hitboxPosition = hitboxPosition;
  }

  late String _spritePath;
  late Vector2 _hitboxSize;
  late Vector2? _hitboxPosition;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(_spritePath);
    RectangleHitbox hitbox = RectangleHitbox(
        size: _hitboxSize,
        position: _hitboxPosition ?? Vector2.zero(),
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
