import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/constants/constants.dart';

class ScoreTextComponent extends TextComponent {
  ScoreTextComponent({
    required String text,
    required Vector2 position,
    required Color color,
  }) : super(
          text: text,
          position: position,
          textRenderer: TextPaint(
            style: TextStyle(
              fontSize: 16.0,
              color: color,
              fontFamily: Strings.minecraft,
            ),
          ),
        );

  @override
  Future<void> onLoad() async {
    final moveEffect = MoveByEffect(
      Vector2(0, -16),
      CurvedEffectController(1, Curves.easeOut),
    );
    final removeEffect = RemoveEffect(delay: 1);
    addAll([moveEffect, removeEffect]);
  }
}
