import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/game/game.dart';

class BrightnessOverlay extends RectangleComponent
    with HasGameReference<GomilandGame> {
  @override
  Future<void> onLoad() async {
    size = game.size;
    paint = Paint()..color = const Color.fromARGB(0, 40, 40, 70);
  }

  void makeEveningDim() {
    add(
      OpacityEffect.to(
        0.2,
        EffectController(
          duration: 1,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  void makeNightDim() {
    add(
      OpacityEffect.to(
        0.4,
        EffectController(
          duration: 1,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  void removeNightDim() {
    add(
      OpacityEffect.to(
        0,
        EffectController(
          duration: 1,
          curve: Curves.easeOut,
        ),
      ),
    );
  }
}
