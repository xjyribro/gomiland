import 'package:bonfire/bonfire.dart';

class Home extends GameDecoration {
  bool open = false;
  bool showDialog = false;

  Home(Vector2 position, Vector2 size)
      : super.withSprite(
    sprite: Sprite.load('buildings/home.png'),
    position: position,
    size: size,
  );

  @override
  Future<void> onLoad() {
    add(RectangleHitbox(
      size: Vector2(width, height),
      position: Vector2(0, 0),
    ));
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    print('collide');
    super.onCollisionStart(intersectionPoints, other);
  }

}