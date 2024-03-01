import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/game/data/other_player.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/npc.dart';
import 'package:gomiland/game/npcs/utils.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:gomiland/utils/directions.dart';
import 'package:jenny/jenny.dart';

class Friend extends Npc with HasGameReference<GomilandGame> {
  Friend({required super.position, required OtherPlayer friendInfo}) : super() {
    _friendInfo = friendInfo;
  }

  late SpriteAnimation idleUp;
  late SpriteAnimation idleDown;
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;
  late OtherPlayer _friendInfo;

  @override
  void onLoad() async {
    final image = await Flame.images.load(_friendInfo.isMale
        ? Assets.assets_images_player_female_png
        : Assets.assets_images_player_female_png);
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

    DialogueControllerComponent dialogueControllerComponent =
        game.dialogueControllerComponent;
    YarnProject yarnProject = YarnProject()..strictCharacterNames = false;

    yarnProject
      ..variables
          .setVariable('\$playerName', game.playerStateBloc.state.playerName)
      ..variables.setVariable('\$coins', game.gameStateBloc.state.coinAmount)
      ..variables.setVariable('\$friendName', _friendInfo.playerName)
      ..variables.setVariable('\$country', _friendInfo.country)
      ..variables.setVariable('\$daysInGame', _friendInfo.daysInGame)
      ..commands.addCommand0('upgradeShoe', upgradeShoe)
      ..commands.addCommand0('upgradeBag', upgradeBag)
      ..parse(await rootBundle.loadString(Assets.assets_yarn_friend_yarn));
    DialogueRunner dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
    await dialogueRunner.startDialogue(getFriendDialogue(_friendInfo, game));
    game.unfreezePlayer();
  }

  void upgradeShoe() {
    game.playerStateBloc.add(const SetPlayerSpeed(playerFastSpeed));
    deductCoins(game, buyObjectCost);
  }

  void upgradeBag() {
    game.gameStateBloc.add(const SetBagSize(20));
    deductCoins(game, buyObjectCost);
  }
}
