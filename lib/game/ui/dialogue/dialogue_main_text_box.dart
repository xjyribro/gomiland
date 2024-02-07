import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/constants/constants.dart';

class DialogueMainTextBox extends TextBoxComponent {
  DialogueMainTextBox({
    required String text,
  }) : super(
    text: text,
    position: Vector2(16, 16),
    size: Vector2(704, 96),
    textRenderer: TextPaint(
      style: const TextStyle(
        fontSize: dialogueBoxFontSize,
        color: Colors.black,
        fontFamily: Strings.minecraft,
      ),
    ),
    boxConfig: TextBoxConfig(timePerChar: timePerChar),
  );
}