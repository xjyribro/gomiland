import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/npc.dart';
import 'package:gomiland/game/npcs/utils.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:gomiland/utils/directions.dart';
import 'package:jenny/jenny.dart';

class MrStar extends Npc with HasGameReference<GomilandGame> {
  MrStar({required super.position});

  late SpriteAnimation idleUp;
  late SpriteAnimation idleDown;
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;

  @override
  void onLoad() async {
    final image = await Flame.images.load(Assets.assets_images_npcs_mr_star_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2.all(tileSize),
    );

    idleUp =
        spriteSheet.createAnimation(row: 1, stepTime: stepTime, from: 0, to: 1);
    idleDown =
        spriteSheet.createAnimation(row: 0, stepTime: stepTime, from: 0, to: 1);
    idleLeft =
        spriteSheet.createAnimation(row: 3, stepTime: stepTime, from: 0, to: 1);
    idleRight =
        spriteSheet.createAnimation(row: 2, stepTime: stepTime, from: 0, to: 1);

    animation = idleDown;
    addAll([npcObstacle(Vector2.zero()), RectangleHitbox()]);
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

  @override
  Future<void> startConversation(Vector2 playerPosition) async {
    game.freezePlayer();
    _facePlayer(playerPosition);
    int progress =
        getCharProgress(RubbishType.food, game.progressStateBloc.state);

    DialogueControllerComponent dialogueControllerComponent =
        game.dialogueControllerComponent;
    YarnProject yarnProject = YarnProject();

    yarnProject
      ..variables.setVariable('\$progress', progress)
      ..parse(await rootBundle.loadString(Assets.assets_yarn_star_yarn));
    DialogueRunner dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
    await dialogueRunner.startDialogue('mr_Star');
    game.unfreezePlayer();
  }
}

class MrsStar extends Npc with HasGameReference<GomilandGame> {
  MrsStar({required super.position});

  late SpriteAnimation idleUp;
  late SpriteAnimation idleDown;
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;

  @override
  void onLoad() async {
    final image = await Flame.images.load(Assets.assets_images_npcs_mrs_star_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2.all(tileSize),
    );

    idleUp =
        spriteSheet.createAnimation(row: 1, stepTime: stepTime, from: 0, to: 1);
    idleDown =
        spriteSheet.createAnimation(row: 0, stepTime: stepTime, from: 0, to: 1);
    idleLeft =
        spriteSheet.createAnimation(row: 3, stepTime: stepTime, from: 0, to: 1);
    idleRight =
        spriteSheet.createAnimation(row: 2, stepTime: stepTime, from: 0, to: 1);

    animation = idleDown;
    addAll([npcObstacle(Vector2.zero()), RectangleHitbox()]);
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

  @override
  Future<void> startConversation(Vector2 playerPosition) async {
    game.freezePlayer();
    _facePlayer(playerPosition);
    int progress =
        getCharProgress(RubbishType.food, game.progressStateBloc.state);

    DialogueControllerComponent dialogueControllerComponent =
        game.dialogueControllerComponent;
    YarnProject yarnProject = YarnProject();

    yarnProject
      ..variables.setVariable('\$progress', progress)
      ..parse(await rootBundle.loadString(Assets.assets_yarn_star_yarn));
    DialogueRunner dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
    await dialogueRunner.startDialogue('mrs_Star');
    game.unfreezePlayer();
  }
}
