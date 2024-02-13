import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/player/player.dart';

class ShopBackEng extends SpriteComponent with CollisionCallbacks {
  ShopBackEng({
    required Vector2 position,
    required Vector2 size,
    required int id,
  }) : super(position: position, size: size) {
    _id = id;
  }

  late int _id;

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(Assets.assets_images_buildings_shop_back_eng_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(128,224),
    );
    sprite = spriteSheet.getSprite(0, _id);
    RectangleHitbox hitbox = RectangleHitbox(
        size: Vector2(128, 96),
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
