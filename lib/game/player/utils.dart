import 'package:flame/components.dart';

Vector2 getMovement(int moveDirection) {
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