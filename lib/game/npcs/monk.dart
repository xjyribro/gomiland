import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:gomiland/utils/directions.dart';
import 'package:jenny/jenny.dart';

class Monk extends SpriteAnimationComponent
    with HasGameReference<GomilandGame> {
  Monk({required Vector2 position})
      : super(
          position: position,
          size: Vector2.all(32),
          anchor: Anchor.center,
        );

  late SpriteAnimation idleUp;
  late SpriteAnimation idleDown;
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;
  final double _stepTime = 0.2;

  @override
  void onLoad() async {
    final image = await Flame.images.load(Assets.assets_images_npcs_qianbi_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2.all(tileSize),
    );

    idleUp = spriteSheet.createAnimation(
        row: 1, stepTime: _stepTime, from: 0, to: 1);
    idleDown = spriteSheet.createAnimation(
        row: 0, stepTime: _stepTime, from: 0, to: 1);
    idleLeft = spriteSheet.createAnimation(
        row: 3, stepTime: _stepTime, from: 0, to: 1);
    idleRight = spriteSheet.createAnimation(
        row: 2, stepTime: _stepTime, from: 0, to: 1);

    animation = idleDown;
    add(RectangleHitbox(
      position: Vector2.zero(),
      size: size,
      collisionType: CollisionType.passive,
    ));
  }

  void _facePlayer(Vector2 playerPosition) {
    Direction direction =
        getDirection(getPlayerAngle(playerPosition, position));
    switch (direction) {
      case Direction.up:
        animation = idleUp;
        break;
      case Direction.down:
        animation = idleDown;
        break;
      case Direction.left:
        animation = idleLeft;
        break;
      case Direction.right:
        animation = idleRight;
        break;
    }
  }

  Future<void> startConversation(Vector2 playerPosition) async {
    _facePlayer(playerPosition);
    game.gameStateBloc.add(const PlayerFrozen(true));
    game.overlays.add('DialogueBox');

    DialogueControllerComponent dialogueControllerComponent =
        game.dialogueControllerComponent;
    YarnProject yarnProject = YarnProject();

    // DIALOGUE
    yarnProject
        .parse(await rootBundle.loadString(Assets.assets_yarn_example_yarn));
    DialogueRunner dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
    dialogueRunner.startDialogue('example');
  }
}
