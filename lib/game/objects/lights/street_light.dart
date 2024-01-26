import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:gomiland/assets.dart';

class StreetLight extends PositionComponent {
  StreetLight({
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
    
        );

  @override
  Future<void> onLoad() async {
    addAll([
      ParkLamp(position: Vector2.zero(), size: size),
      Light(position: Vector2.all(-48)),
    ]);
  }
}

class ParkLamp extends SpriteComponent {
  ParkLamp({
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
        );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_objects_park_lamp_png);
  }
}

class Light extends SpriteComponent {
  Light({
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2(128, 128),
        );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_objects_light_png);
    add(
      OpacityEffect.to(
        0.9,
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
