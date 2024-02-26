import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/player/player.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:jenny/jenny.dart';

Vector2 getMovement(int moveDirection) {
  switch (moveDirection) {
    case 0:
      return Vector2.zero();
    case 1:
      return Vector2(0, -1);
    case 2:
      return Vector2(0, 1);
    case 3:
      return Vector2(-1, 0);
    case 4:
      return Vector2(1, 0);
    default:
      return Vector2.zero();
  }
}

Future<void> rejectFromRoom(GomilandGame game, Player player) async {
  game.freezePlayer();
  await _showBagIsEmptyDialogue(game);
  player.setRejectFromRoom(true);
}

Future<void> _showBagIsEmptyDialogue(GomilandGame game) async {
  DialogueControllerComponent dialogueControllerComponent =
      game.dialogueControllerComponent;
  YarnProject yarnProject = YarnProject();

  // DIALOGUE
  yarnProject.parse(
    await rootBundle.loadString(Assets.assets_yarn_general_yarn),
  );
  DialogueRunner dialogueRunner = DialogueRunner(
    yarnProject: yarnProject,
    dialogueViews: [dialogueControllerComponent],
  );
  await dialogueRunner.startDialogue('bag_is_empty');
}

Vector2 translatePlayerMiniMapPosit(Vector2 position) {
  double translatedX = position.x / mapSizeX * miniMapSizeX;
  double translatedY = position.y / mapSizeY * miniMapSizeY;
  return Vector2(translatedX, translatedY);
}