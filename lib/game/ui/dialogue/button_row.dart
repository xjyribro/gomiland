import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_button.dart';
import 'package:jenny/jenny.dart';

class ButtonRow extends PositionComponent {
  ButtonRow({required Vector2 size}) : super(position: Vector2(0, 96), size: size);

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

  void showNextButton(Function onNextButtonPressed) {
    removeButtons();
    DialogueButton nextButton = DialogueButton(
      assetPath: Assets.assets_images_ui_blue_button_png,
      text: 'Next',
      posit: Vector2(size.x/2, 0),
      onTap: () {
        onNextButtonPressed();
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
        assetPath: Assets.assets_images_ui_green_button_png,
        text: option1.text,
        posit: Vector2(size.x/4, 0),
        onTap: () {
          onChoice(0);
          removeButtons();
        },
      ),
      DialogueButton(
        assetPath: Assets.assets_images_ui_red_button_png,
        text: option2.text,
        posit: Vector2(3*size.x/4, 0),
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
      posit: Vector2(size.x/2, 0),
    );
    add(closeButton);
  }
}
