import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> idleUp() => SpriteAnimation.load(
    'player/idle_up.png',
    SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 1,
      textureSize: Vector2(32, 32),
    ),
  );
  static Future<SpriteAnimation> idleDown() => SpriteAnimation.load(
    'player/idle_down.png',
    SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 1,
      textureSize: Vector2(32, 32),
    ),
  );
  static Future<SpriteAnimation> idleRight() => SpriteAnimation.load(
    'player/idle_right.png',
    SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 1,
      textureSize: Vector2(32, 32),
    ),
  );
  static Future<SpriteAnimation> idleLeft() => SpriteAnimation.load(
    'player/idle_left.png',
    SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 1,
      textureSize: Vector2(32, 32),
    ),
  );

  static Future<SpriteAnimation> moveLeft() => SpriteAnimation.load(
    'player/move_left.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static Future<SpriteAnimation> moveRight() => SpriteAnimation.load(
    'player/move_right.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static Future<SpriteAnimation> moveUp() => SpriteAnimation.load(
    'player/move_up.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static Future<SpriteAnimation> moveDown() => SpriteAnimation.load(
    'player/move_down.png',
    SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    ),
  );

  static SimpleDirectionAnimation playerAnimations() =>
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
