import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/npc.dart';
import 'package:gomiland/game/npcs/utils.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:gomiland/utils/directions.dart';
import 'package:jenny/jenny.dart';

class Rocky extends Npc with HasGameReference<GomilandGame> {
  Rocky({required super.position});

  late SpriteAnimation idleUp;
  late SpriteAnimation idleDown;
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;

  @override
  void onLoad() async {
    final image =
        await Flame.images.load(Assets.assets_images_npcs_muscle_man_png);
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

    Map<String, bool> zenGarden = game.playerStateBloc.state.zenGarden;

    DialogueControllerComponent dialogueControllerComponent =
        game.dialogueControllerComponent;
    YarnProject yarnProject = YarnProject();

    yarnProject
      ..variables.setVariable('\$coins', game.gameStateBloc.state.coinAmount)
      ..commands.addCommand1('buyRock', buyRock)
      ..parse(await rootBundle.loadString(Assets.assets_yarn_rocky_yarn));
    DialogueRunner dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
    await dialogueRunner
        .startDialogue(getZenGardenSellerDialogue(zenGarden, 'rocky'));
    game.unfreezePlayer();
  }

  void buyRock(int index) {
    Map<String, bool> zenGarden = game.playerStateBloc.state.zenGarden;
    zenGarden[getRockStringFromInt(index)] = true;
    game.playerStateBloc.add(SetZenGarden(zenGarden));
    deductCoins(game, 500);
  }
}
