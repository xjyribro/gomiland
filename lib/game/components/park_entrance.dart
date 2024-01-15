import 'package:bonfire/bonfire.dart';
import 'package:gomiland/game/player/player.dart';
import 'package:gomiland/game/scenes/park_scene.dart';

class ParkEntrance extends GameDecoration{
  Function switchScene;
  ParkEntrance(Vector2 position, Vector2 size, {required this.switchScene})
      : super.withSprite(
    sprite: Sprite.load('buildings/entrance.png'),
    position: position,
    size: size,
  );

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is GPlayer) {
      switchScene(ParkScene(switchScene: switchScene));
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox(
      size: Vector2(width, height),
      position: Vector2(0, 0),
    ));
  }
}