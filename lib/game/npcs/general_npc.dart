import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/npc.dart';
import 'package:gomiland/game/npcs/utils.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:gomiland/utils/directions.dart';
import 'package:jenny/jenny.dart';

class GeneralNpc extends Npc with HasGameReference<GomilandGame> {
  GeneralNpc({
    required super.position,
    required String imgPath,
    required String dialoguePath,
    required NpcName npcName,
  }) : super() {
    _imgPath = imgPath;
    _dialoguePath = dialoguePath;
    _npcName = npcName;
  }

  late SpriteAnimation idleUp;
  late SpriteAnimation idleDown;
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;
  late String _imgPath;
  late String _dialoguePath;
  late NpcName _npcName;

  @override
  void onLoad() async {
    final image = await Flame.images.load(_imgPath);
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

  @override
  Future<void> startConversation(Vector2 playerPosition) async {
    game.freezePlayer();
    _facePlayer(playerPosition);
    DialogueControllerComponent dialogueControllerComponent =
        game.dialogueControllerComponent;
    YarnProject yarnProject = YarnProject();

    // DIALOGUE
    yarnProject.parse(await rootBundle.loadString(_dialoguePath));
    DialogueRunner dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
    await dialogueRunner.startDialogue(_npcName.string);
    game.unfreezePlayer();
  }
}
