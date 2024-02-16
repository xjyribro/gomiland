import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/game.dart';
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

void showBagIsEmptyDialogue(GomilandGame game) async {
  game.freezePlayer();
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
  game.unfreezePlayer();
}