import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:jenny/jenny.dart';

class RubbishSpawner extends SpriteComponent
    with HasGameReference<GomilandGame> {
  RubbishSpawner({required Vector2 position}) : super(position: position);

  late RectangleHitbox _hitbox;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_rubbish_rubbish_small_png);
    _hitbox = RectangleHitbox(
      size: Vector2(40, 40),
      position: Vector2(16, 16),
      anchor: Anchor.center,
      collisionType: CollisionType.passive,
    );
    add(_hitbox);
  }

  Future<void> _showBagFullMessage() async {
    game.freezePlayer();
    DialogueControllerComponent dialogueControllerComponent =
        game.dialogueControllerComponent;
    YarnProject yarnProject = YarnProject();

    // DIALOGUE
    yarnProject
        .parse(await rootBundle.loadString(Assets.assets_yarn_general_yarn));
    DialogueRunner dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
    await dialogueRunner.startDialogue('bag_is_full');
    game.unfreezePlayer();
  }

  void pickupRubbish() {
    final int bagCount = game.gameStateBloc.state.bagCount;
    final int maxBagCount = game.gameStateBloc.state.maxBagCount;
    if (bagCount < maxBagCount) {
      game.gameStateBloc.add(BagCountChange(bagCount + 1));
      sprite = null;
      remove(_hitbox);
    } else {
      _showBagFullMessage();
    }
  }
}
