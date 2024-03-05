import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/objects/spawners/utils.dart';
import 'package:gomiland/game/scenes/scene_name.dart';

class RubbishSpawner extends SpriteComponent
    with HasGameReference<GomilandGame> {
  RubbishSpawner({
    required Vector2 position,
    required SceneName sceneName,
    required int index,
  }) : super(position: position) {
    _sceneName = sceneName;
    _index = index;
  }

  late RectangleHitbox _hitbox;
  late SceneName _sceneName;
  late int _index;

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache(
      Assets.assets_images_rubbish_rubbish_small_png,
    ));
    _hitbox = RectangleHitbox(
      size: Vector2.all(streetRubbishSize),
      position: Vector2(16, 16),
      anchor: Anchor.center,
      collisionType: CollisionType.passive,
    );
    add(_hitbox);
  }

  void _onPickup(int bagCount) {
    removeIndexFromSpawnerList(
      game: game,
      sceneName: _sceneName,
      index: _index,
    );
    increaseBagCount(game);
    playPickUpSound(game);
    sprite = null;
    remove(_hitbox);
  }

  void pickupRubbish() {
    final int bagCount = game.gameStateBloc.state.bagCount;
    final int bagSize = game.gameStateBloc.state.bagSize;
    if (bagCount < bagSize) {
      _onPickup(bagCount);
    } else {
      showBagFullMessage(game);
    }
  }
}
