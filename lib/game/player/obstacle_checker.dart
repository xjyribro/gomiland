import 'package:flame/components.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/objects/obsticle.dart';

mixin ObstacleChecker on PositionComponent, HasGameReference<GomilandGame> {
  void checkMovement({
    required Vector2 movementThisFrame,
    required Vector2 originalPosition,
  }) {
    if (movementThisFrame.y < 0) {
      final newTopLeft = positionOfAnchor(Anchor.topLeft);
      for (final component in game.world.componentsAtPoint(newTopLeft)) {
        if (component is Obstacle) {
          movementThisFrame.y = 0;
          break;
        }
      }
      final newTopRight = positionOfAnchor(Anchor.topRight);
      for (final component in game.world.componentsAtPoint(newTopRight)) {
        if (component is Obstacle) {
          movementThisFrame.y = 0;
          break;
        }
      }
    }
    if (movementThisFrame.y > 0) {
      final newCentreLeft = positionOfAnchor(Anchor.centerLeft);
      for (final component in game.world.componentsAtPoint(newCentreLeft)) {
        if (component is Obstacle) {
          movementThisFrame.y = 0;
          break;
        }
      }
      final newCentreRight = positionOfAnchor(Anchor.centerRight);
      for (final component in game.world.componentsAtPoint(newCentreRight)) {
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
