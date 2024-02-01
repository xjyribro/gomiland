import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';

class LightSprite extends SpriteComponent {
  LightSprite({
    required Vector2 position,
  }) : super(
    position: position,
    size: Vector2(128, 96),
  );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_objects_light_png);
    add(
      OpacityEffect.to(
        0.85,
        EffectController(
          duration: 0.4,
          reverseDuration: .4,
          infinite: true,
          curve: Curves.easeOut,
        ),
      ),
    );
  }
}