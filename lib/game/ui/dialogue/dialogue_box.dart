import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/ui/dialogue/button_row.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_main_text_box.dart';
import 'package:jenny/jenny.dart';

class DialogueBoxComponent extends HudMarginComponent {
  DialogueBoxComponent({
    super.margin = const EdgeInsets.only(
      left: boxMarginFromLeft,
      top: 270,
    ),
  });

  late final DialogueBoxSpriteComponent _dialogueBoxSpriteComponent =
      DialogueBoxSpriteComponent();

  void changeText(String text, bool isFirstLine) {
    _dialogueBoxSpriteComponent.changeText(text, isFirstLine);
  }

  void showNextButton(Function onClose) {
    _dialogueBoxSpriteComponent.showNextButton(onClose);
  }

  void showOptions({
    required Function onChoice,
    required DialogueOption option1,
    required DialogueOption option2,
  }) {
    _dialogueBoxSpriteComponent.showOptions(
      onChoice: onChoice,
      option1: option1,
      option2: option2,
    );
  }

  void showCloseButton(Function onClose) {
    _dialogueBoxSpriteComponent.showCloseButton(onClose);
  }

  @override
  Future<void> onLoad() async {
    add(_dialogueBoxSpriteComponent);
  }
}

class DialogueBoxSpriteComponent extends SpriteComponent {
  DialogueMainTextBox _textBox = DialogueMainTextBox(text: '');
  late final ButtonRow _buttonRow = ButtonRow(size: _size);
  final Vector2 _size = Vector2(736, 128);
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      Assets.assets_images_ui_dialogue_box_png,
      srcSize: _size,
    );
    add(_buttonRow);
    return super.onLoad();
  }

  void removeTextBox() {
    remove(_textBox);
  }

  void changeText(String text, bool isFirstLine) {
    if (!isFirstLine) {
      removeTextBox();
    }
    _textBox = DialogueMainTextBox(text: text);
    add(_textBox);
  }

  void showOptions({
    required Function onChoice,
    required DialogueOption option1,
    required DialogueOption option2,
  }) {
    _buttonRow.showOptionButtons(
      onChoice: onChoice,
      option1: option1,
      option2: option2,
    );
  }

  void showNextButton(Function goNextLine) {
    _buttonRow.showNextButton(goNextLine);
  }

  void showCloseButton(Function onClose) {
    void closeDialogue () {
      removeTextBox();
      onClose();
    }
    _buttonRow.showCloseButton(closeDialogue);
  }
}
