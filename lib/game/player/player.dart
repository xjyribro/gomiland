import 'package:bonfire/bonfire.dart';
import 'package:gomiland/game/player/player_sprite_sheet.dart';

class GPlayer extends SimplePlayer with BlockMovementCollision {
  GPlayer(Vector2 position)
      : super(
          position: position,
          size: Vector2(32.0, 32.0),
          life: 100,
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
