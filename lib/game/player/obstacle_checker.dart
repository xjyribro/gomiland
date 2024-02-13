import 'package:flame/components.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/objects/obsticle.dart';

mixin ObstacleChecker on PositionComponent, HasGameReference<GomilandGame> {
  void checkMovement({
    required Vector2 movementThisFrame,
    required Vector2 originalPosition,
  }) {
    if (movementThisFrame.y < 0) {
      final newCenterLeft = positionOfAnchor(Anchor.centerLeft);
      for (final component in game.world.componentsAtPoint(newCenterLeft)) {
        if (component is Obstacle) {
          movementThisFrame.y = 0;
          break;
        }
      }
      final newCenter = positionOfAnchor(Anchor.center);
      for (final component in game.world.componentsAtPoint(newCenter)) {
        if (component is Obstacle) {
          movementThisFrame.y = 0;
          break;
        }
      }
      final newCenterRight = positionOfAnchor(Anchor.centerRight);
      for (final component in game.world.componentsAtPoint(newCenterRight)) {
        if (component is Obstacle) {
          movementThisFrame.y = 0;
          break;
        }
      }
    }
    if (movementThisFrame.y > 0) {
      final newCentreLeft = positionOfAnchor(Anchor.bottomLeft);
      for (final component in game.world.componentsAtPoint(newCentreLeft)) {
        if (component is Obstacle) {
          movementThisFrame.y = 0;
          break;
        }
      }
      final newCenter = positionOfAnchor(Anchor.bottomCenter);
      for (final component in game.world.componentsAtPoint(newCenter)) {
        if (component is Obstacle) {
          movementThisFrame.y = 0;
          break;
        }
      }
      final newCentreRight = positionOfAnchor(Anchor.bottomRight);
      for (final component in game.world.componentsAtPoint(newCentreRight)) {
        if (component is Obstacle) {
          movementThisFrame.y = 0;
          break;
        }
      }
    }
    if (movementThisFrame.x < 0) {
      final newBottomLeft = positionOfAnchor(Anchor.bottomLeft);
      for (final component in game.world.componentsAtPoint(newBottomLeft)) {
        if (component is Obstacle) {
          movementThisFrame.x = 0;
          break;
        }
      }
      final newCentreLeft = positionOfAnchor(Anchor.centerLeft);
      for (final component in game.world.componentsAtPoint(newCentreLeft)) {
        if (component is Obstacle) {
          movementThisFrame.x = 0;
          break;
        }
      }
    }
    if (movementThisFrame.x > 0) {
      final newBottomRight = positionOfAnchor(Anchor.bottomRight);
      for (final component in game.world.componentsAtPoint(newBottomRight)) {
        if (component is Obstacle) {
          movementThisFrame.x = 0;
          break;
        }
      }
      final newCentreRight = positionOfAnchor(Anchor.centerRight);
      for (final component in game.world.componentsAtPoint(newCentreRight)) {
        if (component is Obstacle) {
          movementThisFrame.x = 0;
          break;
        }
      }
    }

    position = originalPosition..add(movementThisFrame);
  }
}
