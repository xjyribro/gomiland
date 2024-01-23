import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/values.dart';
import 'package:gomiland/game/player/player.dart';
import 'package:gomiland/utils/directions.dart';

class Monk extends SpriteAnimationComponent with CollisionCallbacks {
  Monk({required Vector2 position})
      : super(
          position: position,
          size: Vector2.all(32),
          anchor: Anchor.center,
          priority: 1,
        );

  late SpriteAnimationComponent monk;
  late SpriteAnimation moveUp;
  late SpriteAnimation moveDown;
  late SpriteAnimation moveLeft;
  late SpriteAnimation moveRight;
  late SpriteAnimation idleUp;
  late SpriteAnimation idleDown;
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;
  final double _stepTime = 0.2;

  @override
  void onLoad() async {
    final image = await Flame.images.load(Assets.assets_images_npcs_monk_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2.all(tileSize),
    );

    moveUp = spriteSheet.createAnimation(row: 1, stepTime: _stepTime, from: 1);
    moveDown =
        spriteSheet.createAnimation(row: 0, stepTime: _stepTime, from: 1);
    moveLeft =
        spriteSheet.createAnimation(row: 3, stepTime: _stepTime, from: 1);
    moveRight =
        spriteSheet.createAnimation(row: 2, stepTime: _stepTime, from: 1);
    idleUp = spriteSheet.createAnimation(
        row: 1, stepTime: _stepTime, from: 0, to: 1);
    idleDown = spriteSheet.createAnimation(
        row: 0, stepTime: _stepTime, from: 0, to: 1);
    idleLeft = spriteSheet.createAnimation(
        row: 3, stepTime: _stepTime, from: 0, to: 1);
    idleRight = spriteSheet.createAnimation(
        row: 2, stepTime: _stepTime, from: 0, to: 1);

    monk = SpriteAnimationComponent(
      animation: moveDown,
      position: Vector2(300, 300),
      size: Vector2.all(32),
    );

    animation = idleDown;
    add(RectangleHitbox(position: Vector2.zero(), size: size, collisionType: CollisionType.passive));
  }


  @override
  void onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollision(intersectionPoints, other);

    if (other is Player) {
      Direction direction =
          getDirection(getPlayerAngle(other.position, position));
      switch (direction) {
        case Direction.up:
          animation = idleUp;
          break;
        case Direction.down:
          animation = idleDown;
          break;
        case Direction.left:
          animation = idleLeft;
          break;
        case Direction.right:
          animation = idleRight;
          break;
      }
    }
  }
}
