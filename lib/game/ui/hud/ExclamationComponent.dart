import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/constants/constants.dart';

class ExclamationComponent extends PositionComponent {
  ExclamationComponent({required Vector2 position})
      : super(
            position: Vector2(position.x + 14, position.y - 12),
            anchor: Anchor.center,
            children: [ExclamationMarkText()]);
}

class ExclamationMarkText extends TextComponent {
  ExclamationMarkText() : super(
    text: '!',
    textRenderer: TextPaint(
      style: const TextStyle(
        fontSize: dialogueBoxFontSize,
        color: Colors.red,
        fontFamily: Strings.minecraft,
      ),
    ),
  );
}