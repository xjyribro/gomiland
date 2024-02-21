import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/game/data/days_of_week.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/npc.dart';
import 'package:gomiland/game/npcs/utils.dart';
import 'package:gomiland/game/player/utils.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:gomiland/game/ui/info_popup/info_popup.dart';
import 'package:gomiland/game/ui/info_popup/info_popup_data.dart';
import 'package:gomiland/utils/directions.dart';
import 'package:jenny/jenny.dart';

class Himiko extends Npc with HasGameReference<GomilandGame> {
  Himiko({required super.position});

  int _moveDirection = 0;
  late SpriteAnimation moveUp;
  late SpriteAnimation moveDown;
  late SpriteAnimation moveLeft;
  late SpriteAnimation moveRight;
  late SpriteAnimation idleUp;
  late SpriteAnimation idleDown;
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;
  final double _speed = tileSize * playerSpeed;
  bool _isTutorial = false;

  @override
  void onLoad() async {
    final image = await Flame.images.load(Assets.assets_images_npcs_himiko_png);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2.all(tileSize),
    );

    moveUp = spriteSheet.createAnimation(row: 1, stepTime: stepTime, from: 1);
    moveDown = spriteSheet.createAnimation(row: 0, stepTime: stepTime, from: 1);
    moveLeft = spriteSheet.createAnimation(row: 3, stepTime: stepTime, from: 1);
    moveRight =
        spriteSheet.createAnimation(row: 2, stepTime: stepTime, from: 1);
    idleUp =
        spriteSheet.createAnimation(row: 1, stepTime: stepTime, from: 0, to: 1);
    idleDown =
        spriteSheet.createAnimation(row: 0, stepTime: stepTime, from: 0, to: 1);
    idleLeft =
        spriteSheet.createAnimation(row: 3, stepTime: stepTime, from: 0, to: 1);
    idleRight =
        spriteSheet.createAnimation(row: 2, stepTime: stepTime, from: 0, to: 1);

    animation = idleDown;
    if (game.gameStateBloc.state.bagSize == 0) {
      _isTutorial = true;
    }
    addAll([npcObstacle(Vector2.zero()), RectangleHitbox()]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_isTutorial) {
      Vector2 playerPosit = game.playerStateBloc.state.playerPosition;
      if (position.x > playerPosit.x + 24) {
        _moveToPlayer();
      } else {
        _stop();
        _talkToHimiko();
        _isTutorial = false;
      }
      _applyMovement(dt);
    }
  }

  void _applyMovement(double dt) {
    Vector2 movement = getMovement(_moveDirection);
    final movementThisFrame = movement * _speed * dt;
    position.add(movementThisFrame);
  }

  void _moveToPlayer() {
    _moveDirection = 3;
    animation = moveLeft;
  }

  void _stop() {
    _moveDirection = 0;
    animation = idleLeft;
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

  String getDayOfWeek() {
    int daysInGame = game.gameStateBloc.state.daysInGame;
    return getDayFromInt(daysInGame);
  }

  _talkToHimiko() async {
    // DIALOGUE
    DialogueControllerComponent dialogueControllerComponent =
        game.dialogueControllerComponent;
    YarnProject yarnProject = YarnProject();
    yarnProject
      ..commands.addCommand1('changeState', changeState)
      ..commands.addCommand1('increaseBagSize', increaseBagSize)
      ..variables.setVariable('\$dayOfWeek', getDayOfWeek())
      ..parse(await rootBundle.loadString(Assets.assets_yarn_himiko_yarn));
    DialogueRunner dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
    await dialogueRunner.startDialogue(getDialogueName());
    game.unfreezePlayer();
    showHowToPlay();
  }

  @override
  Future<void> startConversation(Vector2 playerPosition) async {
    game.freezePlayer();
    _facePlayer(playerPosition);

    _talkToHimiko();
  }

  void changeState(String newState) {
    game.progressStateBloc.add(SetNeighbourState(newState));
  }

  void increaseBagSize(int newSize) {
    game.gameStateBloc.add(SetBagSize(newSize));
  }

  String getDialogueName() {
    return game.progressStateBloc.state.neighbour;
  }

  void showHowToPlay() {
    game.freezePlayer();
    InfoPopupObject infoPopupObject = getInfoPopupObject('how_to_play');
    InfoPopup popup = InfoPopup(infoPopupObject: infoPopupObject);
    game.cameraComponent.viewport.add(popup);
  }
}
