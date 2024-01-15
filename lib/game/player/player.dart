import 'package:bonfire/bonfire.dart';
import 'package:gomiland/game/player/player_sprite_sheet.dart';

class GPlayer extends SimplePlayer with BlockMovementCollision {
  GPlayer(Vector2 position)
      : super(
          size: Vector2.all(32),
          position: position,
          speed: 100,
          initDirection: Direction.right,
          animation: PlayerSpriteSheet.playerAnimations(), //required
        );

  @override
  Future<void> onLoad() {
    add(
      RectangleHitbox(
        size: Vector2(32, 16),
        position: Vector2(0, 0),
      ),
    );
    return super.onLoad();
  }
}
