import 'package:bonfire/bonfire.dart';
import 'package:gomiland/player/player_sprite_sheet.dart';

class GPlayer extends SimplePlayer {

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
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
