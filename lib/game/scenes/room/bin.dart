import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
import 'package:gomiland/game/scenes/room/score_text_component.dart';

class Bin extends PositionComponent {
  Bin({
    required Vector2 position,
    required RubbishType binType,
  }) : super(position: position) {
    _binType = binType;
  }

  late RubbishType _binType;

  RubbishType get binType => _binType;

  void showScore(int score) {
    String sign = score > 0 ? '+' : '';
    ScoreTextComponent scoreText = ScoreTextComponent(
        text: '$sign $score',
        position: Vector2.all(24),
        color: score > 0 ? Colors.lightGreen : Colors.redAccent);
    add(scoreText);
  }

  @override
  Future<void> onLoad() async {
    RectangleHitbox binOpening = RectangleHitbox(
      position: Vector2(16, 16),
      size: Vector2(32, 32),
    );
    add(binOpening);
  }
}
