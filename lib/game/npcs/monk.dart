import 'dart:math';

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

  @override
  void update(double dt) {
    super.update(dt);
    seePlayer(
      observed: (p) {
        double playerAngle = GetPlayerAngle(p.position, position);
        animation!.play(GetDirectionAnimation(playerAngle));
      },
      radiusVision: 32,
    );
  }
}

SimpleAnimationEnum GetDirectionAnimation(double deg) {
  if (deg > -45 && deg < 45) {
    return SimpleAnimationEnum.idleLeft;
  }
  if (deg > -135 && deg < -45) {
    return SimpleAnimationEnum.idleDown;
  }
  if (deg > 45 && deg < 135) {
    return SimpleAnimationEnum.idleUp;
  }
  return SimpleAnimationEnum.idleRight;
}

double GetPlayerAngle(Vector2 playerPosit, Vector2 objectPosit) {
  double dx = playerPosit.x - objectPosit.x;
  double dy = playerPosit.y - objectPosit.y;

  double angleRadians = atan2(objectPosit.y - playerPosit.y, objectPosit.x - playerPosit.x);
  return angleRadians * (180 / pi);
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

  static SimpleDirectionAnimation boyAnimations() => SimpleDirectionAnimation(
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
