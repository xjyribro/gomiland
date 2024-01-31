import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/controllers/dialogue_controller.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_button.dart';
import 'package:jenny/jenny.dart';

class ButtonRow extends StatelessWidget {
  final DialogueState state;
  final List<DialogueOption> options;
  final GomilandGame game;

  const ButtonRow({
    super.key,
    required this.state,
    required this.options,
    required this.game,
  });

  void onDialogueEnd() {
    game.gameStateBloc.add(const PlayerFrozen(false));
    game.overlays.remove('DialogueBox');
  }

  List<Widget> _getChoiceButtons() {
    if (state.isCompleted) {
      return [
        DialogueButton(
          imageAssetPath: Assets.assets_images_ui_blue_button_png,
          text: 'Close',
          onTap: onDialogueEnd,
        )
      ];
    }
    if (options.isEmpty) {
      return [
        DialogueButton(
            imageAssetPath: Assets.assets_images_ui_blue_button_png,
            text: 'Next',
            onTap: () {
              state.dialogueController.nextLine();
            })
      ];
    }
    return options
        .mapIndexed((i, option) => DialogueButton(
            imageAssetPath: i == 0
                ? Assets.assets_images_ui_green_button_png
                : Assets.assets_images_ui_red_button_png,
            text: option.text,
            onTap: () {
              state.dialogueController.chooseOption(i);
            }))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _getChoiceButtons(),
      ),
    );
  }
}
