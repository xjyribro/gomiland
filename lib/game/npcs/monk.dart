import 'package:bonfire/bonfire.dart';

class Monk extends SimpleNpc with BlockMovementCollision {

  Monk({required Vector2 position})
      : super(
    animation: BoySpriteSheet.boyAnimations(),
    position: position,
    size: Vector2.all(32),
  );

  @override
  Future<void> onLoad() {
    add(RectangleHitbox(
      size: Vector2(32, 32),
      position: Vector2(0, 0),
    ));
    return super.onLoad();
  }
}

class BoySpriteSheet {

  static Future<SpriteAnimation> idleUp() => SpriteAnimation.load(
    'npcs/monk/idle_up.png',
    SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 1,
      textureSize: Vector2(32, 32),
    ),
  );
  static Future<SpriteAnimation> idleDown() => SpriteAnimation.load(
    'npcs/monk/idle_down.png',
    SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 1,
      textureSize: Vector2(32, 32),
    ),
  );
  static Future<SpriteAnimation> idleRight() => SpriteAnimation.load(
    'npcs/monk/idle_right.png',
    SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 1,
      textureSize: Vector2(32, 32),
    ),
  );
  static Future<SpriteAnimation> idleLeft() => SpriteAnimation.load(
    'npcs/monk/idle_left.png',
    SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 1,
      textureSize: Vector2(32, 32),
    ),
  );

  static Future<SpriteAnimation> moveLeft() => SpriteAnimation.load(
    'npcs/monk/move_left.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static Future<SpriteAnimation> moveRight() => SpriteAnimation.load(
    'npcs/monk/move_right.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static Future<SpriteAnimation> moveUp() => SpriteAnimation.load(
    'npcs/monk/move_up.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static Future<SpriteAnimation> moveDown() => SpriteAnimation.load(
    'npcs/monk/move_down.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static SimpleDirectionAnimation boyAnimations() =>
      SimpleDirectionAnimation(
        idleDown: idleDown(),
        idleUp: idleUp(),
        idleLeft: idleLeft(),
        idleRight: idleRight(),
        runLeft: moveLeft(),
        runRight: moveRight(),
        runUp: moveUp(),
        runDown: moveDown(),
      );
}
