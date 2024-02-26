import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/ui/dialogue/button_row.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_text_box.dart';
import 'package:jenny/jenny.dart';

class DialogueBoxComponent extends HudMarginComponent {
  DialogueBoxComponent({
    super.margin = const EdgeInsets.only(
      left: boxMarginFromLeft,
      top: dialogueBoxMarginFromTop,
    ),
  });

  late final DialogueBoxSpriteComponent _dialogueBoxSpriteComponent =
      DialogueBoxSpriteComponent();

  void changeText(String text, bool isFirstLine, Function goNextLine) {
    _dialogueBoxSpriteComponent.changeText(text, isFirstLine, goNextLine);
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
  DialogueTextBox _textBox = DialogueTextBox(text: '', showFullText: true,);
  late final ButtonRow _buttonRow = ButtonRow(size: _size);
  final Vector2 _size = Vector2(736, 128);
  String _text = '';
  Function _goNextLine = () {};
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

  void changeText(String text, bool isFirstLine, Function goNextLine) {
    if (!isFirstLine) {
      removeTextBox();
    }
    _text = text;
    _goNextLine = goNextLine;
    // this line removes extra ":" when Jenny does not have a char name at the start of the line
    if (text.startsWith(':')) {
      _text = text.substring(2);
    }
    showTyperText();
    _buttonRow.showNextButton(onNextButtonPressed);
  }

  void showTyperText() {
    _textBox = DialogueTextBox(text: _text, showFullText: false,);
    add(_textBox);
  }

  void onNextButtonPressed() {
    // go next line if the typer has finished
    if (_textBox.finished) {
      _goNextLine();
    } else {
      // else show complete text and new next button
      removeTextBox();
      _textBox = DialogueTextBox(text: _text, showFullText: true,);
      add(_textBox);
      _buttonRow.showNextButton(_goNextLine);
    }
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

  void showCloseButton(Function onClose) {
    void closeDialogue () {
      removeTextBox();
      onClose();
    }
    _buttonRow.showCloseButton(closeDialogue);
  }
}
