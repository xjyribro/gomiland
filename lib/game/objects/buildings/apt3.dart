import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/player/player.dart';

class Apt3 extends SpriteComponent
    with CollisionCallbacks, HasGameReference<GomilandGame> {
  Apt3({required Vector2 position, required Vector2 size}) : super(position: position, size: size);


  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_buildings_apt3_png);
    RectangleHitbox hitbox = RectangleHitbox(
      size: Vector2(256,96),
      position: Vector2(0, 224),
      collisionType: CollisionType.passive,
    );
    add(hitbox);
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