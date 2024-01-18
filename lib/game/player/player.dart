import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/contants.dart';
import 'package:gomiland/game/game.dart';

class Player extends SpriteAnimationComponent
    with KeyboardHandler, HasGameReference<GomilandGame> {
  Player()
      : super(
          position: Vector2(128, 128),
          size: Vector2.all(32),
          anchor: Anchor.center,
          priority: 1,
        );

  late SpriteAnimationComponent player;
  late SpriteAnimation moveUp;
  late SpriteAnimation moveDown;
  late SpriteAnimation moveLeft;
  late SpriteAnimation moveRight;
  late SpriteAnimation idleUp;
  late SpriteAnimation idleDown;
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;

  Vector2 movement = Vector2.zero();
  double speed = tileSize * 4;
  double stepTime = 0.2;

  @override
  void onLoad() {
    final spriteSheet = SpriteSheet(
      image: game.images.fromCache(
        Assets.assets_assets_images_player_player_png,
      ),
      srcSize: Vector2.all(tileSize),
    );

    moveUp = spriteSheet.createAnimation(row: 1, stepTime: stepTime, from: 1);
    moveDown = spriteSheet.createAnimation(row: 0, stepTime: stepTime, from: 1);
    moveLeft = spriteSheet.createAnimation(row: 3, stepTime: stepTime, from: 1);
    moveRight = spriteSheet.createAnimation(row: 2, stepTime: stepTime, from: 1);
    idleUp = spriteSheet.createAnimation(row: 1, stepTime: stepTime, from: 0, to: 1);
    idleDown = spriteSheet.createAnimation(row: 0, stepTime: stepTime, from: 0, to: 1);
    idleLeft = spriteSheet.createAnimation(row: 3, stepTime: stepTime, from: 0, to: 1);
    idleRight = spriteSheet.createAnimation(row: 2, stepTime: stepTime, from: 0, to: 1);

    player = SpriteAnimationComponent(
      animation: moveDown,
      position: Vector2(100, 100),
      size: Vector2.all(32),
    );

    animation = moveDown;
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Save this to use after we zero out movement for unwalkable terrain.
    final originalPosition = position.clone();
    final movementThisFrame = movement * speed * dt;
    // Fake update the position so our anchor calculations take into account
    // what movement we want to do this turn.
    position.add(movementThisFrame);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyW) {
        movement = Vector2(movement.x, -1);
        animation = moveUp;
      }
      if (event.logicalKey == LogicalKeyboardKey.keyS) {
        movement = Vector2(movement.x, 1);
        animation = moveDown;
      }
      if (event.logicalKey == LogicalKeyboardKey.keyA) {
        movement = Vector2(-1, movement.y);
        animation = moveLeft;
      }
      if (event.logicalKey == LogicalKeyboardKey.keyD) {
        movement = Vector2(1, movement.y);
        animation = moveRight;
      }
      return false;
    } else if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyW) {
        movement.y = keysPressed.contains(LogicalKeyboardKey.keyS) ? 1 : 0;
        animation = idleUp;
      }
      if (event.logicalKey == LogicalKeyboardKey.keyS) {
        movement.y = keysPressed.contains(LogicalKeyboardKey.keyW) ? -1 : 0;
        animation = idleDown;
      }
      if (event.logicalKey == LogicalKeyboardKey.keyA) {
        movement.x = keysPressed.contains(LogicalKeyboardKey.keyD) ? 1 : 0;
        animation = idleLeft;
      }
      if (event.logicalKey == LogicalKeyboardKey.keyD) {
        movement.x = keysPressed.contains(LogicalKeyboardKey.keyA) ? -1 : 0;
        animation = idleRight;
      }
      return false;
    }
    return true;
  }
}
