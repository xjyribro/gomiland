import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_button.dart';
import 'package:jenny/jenny.dart';

class ButtonRow extends PositionComponent {
  ButtonRow() : super(position: Vector2(0, 128));

  void removeButtons() {
    List<DialogueButton> buttonList = children.query<DialogueButton>();
    if (buttonList.isNotEmpty) {
      for (DialogueButton dialogueButton in buttonList) {
        if (dialogueButton.parent != null) {
          dialogueButton.removeFromParent();
        }
      }
    }
  }

  void showNextButton(Function goNextLine) {
    removeButtons();
    DialogueButton nextButton = DialogueButton(
      assetPath: Assets.assets_images_ui_blue_button_png,
      text: 'Next',
      posit: Vector2(400, 0),
      onTap: () {
        goNextLine();
        removeButtons();
      },
    );
    add(nextButton);
  }

  void showOptionButtons({
    required Function onChoice,
    required DialogueOption option1,
    required DialogueOption option2,
  }) {
    removeButtons();
    List<DialogueButton> optionButtons = [
      DialogueButton(
        assetPath: Assets.assets_images_ui_blue_button_png,
        text: option1.text,
        posit: Vector2(200, 0),
        onTap: () {
          onChoice(0);
          removeButtons();
        },
      ),
      DialogueButton(
        assetPath: Assets.assets_images_ui_blue_button_png,
        text: option2.text,
        posit: Vector2(600, 0),
        onTap: () {
          onChoice(1);
          removeButtons();
        },
      ),
    ];
    addAll(optionButtons);
  }

  void showCloseButton(Function onClose) {
    DialogueButton closeButton = DialogueButton(
      assetPath: Assets.assets_images_ui_blue_button_png,
      text: 'Close',
      onTap: onClose,
      posit: Vector2(400, 0),
    );
    add(closeButton);
  }
}
