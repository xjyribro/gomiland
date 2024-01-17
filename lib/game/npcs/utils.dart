import 'dart:math';

import 'package:bonfire/bonfire.dart';

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
  double angleRadians = atan2(objectPosit.y - playerPosit.y, objectPosit.x - playerPosit.x);
  return angleRadians * (180 / pi);
}