import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';

class RubbishSpawner extends SpriteComponent
    with HasGameReference<GomilandGame> {
  RubbishSpawner({required Vector2 position}) : super(position: position);

  late RectangleHitbox _hitbox;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_rubbish_rubbish_small_png);
    _hitbox = RectangleHitbox(
      size: Vector2(16, 16),
      position: Vector2(16, 16),
      anchor: Anchor.center,
      collisionType: CollisionType.passive,
    );
    add(_hitbox);
  }

  void pickupRubbish() {
    final int bagCount = game.gameStateBloc.state.bagCount;
    final int maxBagCount = game.gameStateBloc.state.maxBagCount;
    if (bagCount < maxBagCount) {
      game.gameStateBloc.add(BagCountChange(bagCount + 1));
      sprite = null;
      remove(_hitbox);
    } else {
      print('bag is full');
    }
  }
}
