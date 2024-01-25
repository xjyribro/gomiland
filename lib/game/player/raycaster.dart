import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/services.dart';

class Raycaster extends PositionComponent with KeyboardHandler, HasCollisionDetection{
  Raycaster({required RectangleHitbox ignoredHitbox}): super() {
    _ignoredHitbox = ignoredHitbox;
  }

  late RectangleHitbox _ignoredHitbox;

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // if (event is RawKeyDownEvent) {
    //   if (event.logicalKey == LogicalKeyboardKey.keyE) {
    //     final ray = Ray2(
    //       origin: Vector2(x, y),
    //       direction: Vector2(0, 1),
    //     );
    //     final result = collisionDetection.raycast(ray);
    //     print(result?.intersectionPoint);
    //   }
    // }
    return true;
  }
}