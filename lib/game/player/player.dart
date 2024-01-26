import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/monk.dart';

class Player extends SpriteAnimationComponent
    with KeyboardHandler, HasGameReference<GomilandGame>, CollisionCallbacks {
  Player({required Vector2 position, JoystickComponent? joystickComponent})
      : super(
          position: position,
          size: Vector2.all(32),
          anchor: Anchor.center,
          priority: 1,
        ) {
    _joystick = joystickComponent;
  }

  late JoystickComponent? _joystick;

  late SpriteAnimationComponent player;
  late SpriteAnimation moveUp;
  late SpriteAnimation moveDown;
  late SpriteAnimation moveLeft;
  late SpriteAnimation moveRight;
  late SpriteAnimation idleUp;
  late SpriteAnimation idleDown;
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;
  late RectangleHitbox _playerHitbox;

  bool _isMovingUp = false;
  bool _isMovingDown = false;
  bool _isMovingLeft = false;
  bool _isMovingRight = false;
  bool _canMoveUp = true;
  bool _canMoveDown = true;
  bool _canMoveLeft = true;
  bool _canMoveRight = true;
  int _moveDirection = 0;
  final double _speed = tileSize * 16;
  final double _stepTime = 0.2;

  @override
  void onLoad() {
    final spriteSheet = SpriteSheet(
      image: game.images.fromCache(
        Assets.assets_images_player_player_png,
      ),
      srcSize: Vector2.all(32),
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

    player = SpriteAnimationComponent(
      animation: moveDown,
      position: Vector2(200, 200),
      size: Vector2.all(32),
    );

    animation = idleDown;
    _playerHitbox = RectangleHitbox(
      position: Vector2(16, 16),
      size: Vector2(size.x - 8, size.y - 16),
      anchor: Anchor.topCenter,
    );
    add(_playerHitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_joystick != null) {
      if (_joystick!.direction == JoystickDirection.idle) {
        _onJoystickStop();
      } else {
        _moveWithJoystick(_joystick!.direction);
      }
    }
    // Save this to use after we zero out movement for unwalkable terrain.
    final originalPosition = position.clone();

    Vector2 movement = _getMovement(_moveDirection);
    final movementThisFrame = movement * _speed * dt;
    // Fake update the position so our anchor calculations take into account
    // what movement we want to do this turn.
    position.add(movementThisFrame);
  }

  Vector2 _getMovement(int moveDirection) {
    switch (moveDirection) {
      case 0:
        return Vector2.zero();
      case 1:
        return _canMoveUp ? Vector2(0, -1) : Vector2.zero();
      case 2:
        return _canMoveDown ? Vector2(0, 1) : Vector2.zero();
      case 3:
        return _canMoveLeft ? Vector2(-1, 0) : Vector2.zero();
      case 4:
        return _canMoveRight ? Vector2(1, 0) : Vector2.zero();
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
        if (_canMoveUp) {
          _moveDirection = 1;
          _isMovingUp = true;
          _isMovingDown = false;
          _isMovingLeft = false;
          _isMovingRight = false;
        }
        break;
      case JoystickDirection.down:
        animation = moveDown;
        if (_canMoveDown) {
          _moveDirection = 2;
          _isMovingUp = false;
          _isMovingDown = true;
          _isMovingLeft = false;
          _isMovingRight = false;
        }
        break;
      case JoystickDirection.left:
        animation = moveLeft;
        if (_canMoveLeft) {
          _moveDirection = 3;
          _isMovingUp = false;
          _isMovingDown = false;
          _isMovingLeft = true;
          _isMovingRight = false;
        }
        break;
      case JoystickDirection.right:
        animation = moveRight;
        if (_canMoveRight) {
          _moveDirection = 4;
          _isMovingUp = false;
          _isMovingDown = false;
          _isMovingLeft = false;
          _isMovingRight = true;
        }
        break;
      default:
        return;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Monk) {
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

  void handleCollisionStart() {
    if (_isMovingUp) {
      _canMoveUp = false;
    }
    if (_isMovingDown) {
      _canMoveDown = false;
    }
    if (_isMovingLeft) {
      _canMoveLeft = false;
    }
    if (_isMovingRight) {
      _canMoveRight = false;
    }
  }

  void handleCollisionEnd() {
    _canMoveDown = true;
    _canMoveUp = true;
    _canMoveRight = true;
    _canMoveLeft = true;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      bool isMoving =
          _isMovingDown || _isMovingUp || _isMovingLeft || _isMovingRight;
      if (isMoving) return false;
      if (event.logicalKey == LogicalKeyboardKey.keyW) {
        animation = moveUp;
        if (_canMoveUp) {
          _isMovingUp = true;
          _moveDirection = 1;
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.keyS) {
        animation = moveDown;
        if (_canMoveDown) {
          _moveDirection = 2;
          _isMovingDown = true;
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.keyA) {
        animation = moveLeft;
        if (_canMoveLeft) {
          _moveDirection = 3;
          _isMovingLeft = true;
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.keyD) {
        animation = moveRight;
        if (_canMoveRight) {
          _moveDirection = 4;
          _isMovingRight = true;
        }
      }

      if (event.logicalKey == LogicalKeyboardKey.keyR) {
        add(game.dialogueControllerComponent);
        game.overlays.add('DialogueBox');
        game.dialogueRunner.startDialogue('example');
      }
      if (event.logicalKey == LogicalKeyboardKey.keyT) {
        remove(game.dialogueControllerComponent);
        game.overlays.remove('DialogueBox');
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
