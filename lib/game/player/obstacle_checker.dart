import 'package:flame/components.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/objects/obsticle.dart';

mixin ObstacleChecker on PositionComponent, HasGameReference<GomilandGame> {
  void checkMovement({
    required Vector2 movementThisFrame,
    required Vector2 originalPosition,
  }) {
    if (movementThisFrame.y < 0) {
      final newTop = positionOfAnchor(Anchor.topCenter);
      for (final component in game.world.componentsAtPoint(newTop)) {
        if (component is Obstacle) {
          movementThisFrame.y = 0;
          break;
        }
      }
    }
    if (movementThisFrame.y > 0) {
      final newBottom = positionOfAnchor(Anchor.center);
      for (final component in game.world.componentsAtPoint(newBottom)) {
        if (component is Obstacle) {
          movementThisFrame.y = 0;
          break;
        }
      }
    }
    if (movementThisFrame.x < 0) {
      final newLeft = positionOfAnchor(Anchor.topLeft);
      for (final component in game.world.componentsAtPoint(newLeft)) {
        if (component is Obstacle) {
          movementThisFrame.x = 0;
          break;
        }
      }
    }
    if (movementThisFrame.x > 0) {
      final newRight = positionOfAnchor(Anchor.topRight);
      for (final component in game.world.componentsAtPoint(newRight)) {
        if (component is Obstacle) {
          movementThisFrame.x = 0;
          break;
        }
      }
    }

    position = originalPosition..add(movementThisFrame);
  }
}
