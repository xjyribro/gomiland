import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Gate extends PositionComponent with CollisionCallbacks {
  Gate({
    required Vector2 position,
    required Vector2 size,
    required Function switchScene,
  }) : super(
          position: position,
          size: size,
        ) {
    _switchScene = switchScene;
  }

  late Function _switchScene;

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox(position: Vector2.zero(), size: size));
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    _switchScene();
  }
}
