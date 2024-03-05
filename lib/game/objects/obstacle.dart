import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Obstacle extends RectangleComponent {
  Obstacle({
    required Vector2 size,
    required Vector2 position,
  }) : super(
          position: position,
          size: size,
          paint: Paint()..color = Colors.transparent,
        );
}
