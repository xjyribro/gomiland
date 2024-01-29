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

  Light light = Light(position: Vector2(-36, -24));

  @override
  Future<void> onLoad() async {
    add(StreetLamp(position: Vector2.zero(), size: size));
  }

  void addLight() {
    add(light);
  }

  void removeLight() {
    remove(light);
  }
}

class StreetLamp extends SpriteComponent {
  StreetLamp({
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
        );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_objects_street_lamp_png);
  }
}

class Light extends SpriteComponent {
  Light({
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
