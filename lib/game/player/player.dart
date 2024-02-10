import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/controllers/player_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/qian_bi.dart';
import 'package:gomiland/game/player/obstacle_checker.dart';

class Player extends SpriteAnimationComponent
    with
        KeyboardHandler,
        HasGameReference<GomilandGame>,
        CollisionCallbacks,
        ObstacleChecker {
  Player({required Vector2 position})
      : super(
          position: position,
          size: Vector2.all(32),
        );

  late SpriteAnimation moveUp;
  late SpriteAnimation moveDown;
  late SpriteAnimation moveLeft;
  late SpriteAnimation moveRight;
  late SpriteAnimation idleUp;
  late SpriteAnimation idleDown;
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;
  late RectangleHitbox playerHitbox;

  bool _isMovingUp = false;
  bool _isMovingDown = false;
  bool _isMovingLeft = false;
  bool _isMovingRight = false;
  int _moveDirection = 0;
  final double _speed = tileSize * playerSpeed;

  @override
  Future<void> onLoad() async {
    bool isMale = game.gameStateBloc.state.isMale;
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load(
        isMale
            ? Assets.assets_images_player_male_png
            : Assets.assets_images_player_female_png,
      ),
      srcSize: Vector2.all(32),
    );

    moveUp = spriteSheet.createAnimation(row: 1, stepTime: stepTime, from: 1);
    moveDown = spriteSheet.createAnimation(row: 0, stepTime: stepTime, from: 1);
    moveLeft = spriteSheet.createAnimation(row: 3, stepTime: stepTime, from: 1);
    moveRight =
        spriteSheet.createAnimation(row: 2, stepTime: stepTime, from: 1);
    idleUp =
        spriteSheet.createAnimation(row: 1, stepTime: stepTime, from: 0, to: 1);
    idleDown =
        spriteSheet.createAnimation(row: 0, stepTime: stepTime, from: 0, to: 1);
    idleLeft =
        spriteSheet.createAnimation(row: 3, stepTime: stepTime, from: 0, to: 1);
    idleRight =
        spriteSheet.createAnimation(row: 2, stepTime: stepTime, from: 0, to: 1);

    animation = idleDown;
    playerHitbox = RectangleHitbox(
      position: Vector2(16, 16),
      size: Vector2(size.x - 8, size.y - 16),
      anchor: Anchor.topCenter,
    );
    add(playerHitbox);

    game.playerStateBloc.add(PlayerHitboxChange(playerHitbox));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.playerIsFrozen()) return;

    if (game.playerStateBloc.state.showControls) {
      if (game.joystick.direction == JoystickDirection.idle) {
        _onJoystickStop();
      } else {
        _moveWithJoystick(game.joystick.direction);
      }
    }
    final originalPosition = position.clone();

    Vector2 movement = _getMovement(_moveDirection);
    final movementThisFrame = movement * _speed * dt;
    position.add(movementThisFrame);
    checkMovement(
      movementThisFrame: movementThisFrame,
      originalPosition: originalPosition,
    );
    game.playerStateBloc.add(PlayerPositionChange(position));
  }

  Vector2 _getMovement(int moveDirection) {
    switch (moveDirection) {
      case 0:
        return Vector2.zero();
      case 1:
        return Vector2(0, -1);
      case 2:
        return Vector2(0, 1);
      case 3:
        return Vector2(-1, 0);
      case 4:
        return Vector2(1, 0);
      default:
        return Vector2.zero();
    }
  }

  void _onJoystickStop() {
    _moveDirection = 0;
    if (_isMovingUp) {
      animation = idleUp;
      _isMovingUp = false;
    } else if (_isMovingDown) {
      animation = idleDown;
      _isMovingDown = false;
    } else if (_isMovingLeft) {
      animation = idleLeft;
      _isMovingLeft = false;
    } else if (_isMovingRight) {
      animation = idleRight;
      _isMovingRight = false;
    }
  }

  void _moveWithJoystick(JoystickDirection direction) {
    switch (direction) {
      case JoystickDirection.up:
        animation = moveUp;
        _moveDirection = 1;
        _isMovingUp = true;
        _isMovingDown = false;
        _isMovingLeft = false;
        _isMovingRight = false;
        game.playerStateBloc.add(PlayerDirectionChange(Vector2(0, -1)));
        break;
      case JoystickDirection.down:
        animation = moveDown;
        _moveDirection = 2;
        _isMovingUp = false;
        _isMovingDown = true;
        _isMovingLeft = false;
        _isMovingRight = false;
        game.playerStateBloc.add(PlayerDirectionChange(Vector2(0, 1)));
        break;
      case JoystickDirection.left:
        animation = moveLeft;
        _moveDirection = 3;
        _isMovingUp = false;
        _isMovingDown = false;
        _isMovingLeft = true;
        _isMovingRight = false;
        game.playerStateBloc.add(PlayerDirectionChange(Vector2(-1, 0)));
        break;
      case JoystickDirection.right:
        animation = moveRight;
        _moveDirection = 4;
        _isMovingUp = false;
        _isMovingDown = false;
        _isMovingLeft = false;
        _isMovingRight = true;
        game.playerStateBloc.add(PlayerDirectionChange(Vector2(1, 0)));
        break;
      default:
        return;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is QianBi) {
      if (intersectionPoints.length == 2) {
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;
        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        position += collisionNormal.scaled(separationDistance);
      }
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (game.playerStateBloc.state.showControls) return false;
    if (event is RawKeyDownEvent) {
      if (game.playerIsFrozen()) return false;
      bool isMoving =
          _isMovingDown || _isMovingUp || _isMovingLeft || _isMovingRight;
      if (isMoving) return false;
      if (event.logicalKey == LogicalKeyboardKey.keyW) {
        animation = moveUp;
        _isMovingUp = true;
        _moveDirection = 1;
        game.playerStateBloc.add(PlayerDirectionChange(Vector2(0, -1)));
      }
      if (event.logicalKey == LogicalKeyboardKey.keyS) {
        animation = moveDown;
        _moveDirection = 2;
        _isMovingDown = true;
        game.playerStateBloc.add(PlayerDirectionChange(Vector2(0, 1)));
      }
      if (event.logicalKey == LogicalKeyboardKey.keyA) {
        animation = moveLeft;
        _moveDirection = 3;
        _isMovingLeft = true;
        game.playerStateBloc.add(PlayerDirectionChange(Vector2(-1, 0)));
      }
      if (event.logicalKey == LogicalKeyboardKey.keyD) {
        animation = moveRight;
        _moveDirection = 4;
        _isMovingRight = true;
        game.playerStateBloc.add(PlayerDirectionChange(Vector2(1, 0)));
      }

      if (event.logicalKey == LogicalKeyboardKey.keyE) {
        game.castRay();
      }

      return false;
    } else if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyW && _isMovingUp) {
        _moveDirection = 0;
        animation = idleUp;
        _isMovingUp = false;
      }
      if (event.logicalKey == LogicalKeyboardKey.keyS && _isMovingDown) {
        _moveDirection = 0;
        animation = idleDown;
        _isMovingDown = false;
      }
      if (event.logicalKey == LogicalKeyboardKey.keyA && _isMovingLeft) {
        _moveDirection = 0;
        animation = idleLeft;
        _isMovingLeft = false;
      }
      if (event.logicalKey == LogicalKeyboardKey.keyD && _isMovingRight) {
        _moveDirection = 0;
        animation = idleRight;
        _isMovingRight = false;
      }
      return false;
    }
    return true;
  }
}
