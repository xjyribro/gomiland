import 'dart:math';

import 'package:flame/components.dart';

enum Direction {
  up,
  down,
  left,
  right,
}

Direction getDirection(double deg) {
  if (deg > 45 && deg < 135) {
    return Direction.up;
  }
  if (deg > -135 && deg < -45) {
    return Direction.down;
  }
  if (deg > -45 && deg < 45) {
    return Direction.left;
  }
  return Direction.right;
}

double getPlayerAngle(Vector2 playerPosit, Vector2 objectPosit) {
  double dx = objectPosit.x - playerPosit.x;
  double dy = objectPosit.y - playerPosit.y;

  double angleRadians = atan2(dy, dx);
  return angleRadians * (180 / pi);
}