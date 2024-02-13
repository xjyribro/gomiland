import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/scenes/room/score_text_component.dart';

class Bin extends PositionComponent {
  Bin({
    required Vector2 openingPosition,
    required Vector2 openingSize,
    required RubbishType binType,
  }) : super() {
    _openingPosition = openingPosition;
    _openingSize = openingSize;
    _binType = binType;
  }

  // game world vars
  late Vector2 _openingPosition;
  late Vector2 _openingSize;

  // custom object data
  late RubbishType _binType;

  RubbishType get binType => _binType;

  void showScore(int score) {
    String sign = score > 0 ? '+' : '';
    ScoreTextComponent scoreText = ScoreTextComponent(
      text: '$sign $score',
      position: _openingPosition + Vector2.all(24),
      color: score > 0 ? Colors.lightGreen : Colors.redAccent
    );
    add(scoreText);
  }

  @override
  Future<void> onLoad() async {
    RectangleHitbox binOpening = RectangleHitbox(
      position: _openingPosition,
      size: _openingSize,
    );
    add(binOpening);
  }
}
