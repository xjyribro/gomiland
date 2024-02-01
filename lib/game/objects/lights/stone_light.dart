import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:gomiland/assets.dart';

class StoneLight extends PositionComponent {
  StoneLight({
    required Vector2 position,
    required Vector2 size,
  }) : super(
    position: position,
    size: size,
  );

  Light light = Light(position: Vector2(16, 8));

  @override
  Future<void> onLoad() async {
    add(
      StoneLamp(position: Vector2.zero(), size: size),
    );
  }

  void addLight() {
    List<Light> lightChildren = children.query<Light>();
    if (lightChildren.isEmpty) {
      add(light);
    }
  }

  void removeLight() {
    List<Light> lightChildren = children.query<Light>();
    if (lightChildren.isNotEmpty) {
      remove(light);
    }
  }
}

class StoneLamp extends SpriteComponent {
  StoneLamp({
    required Vector2 position,
    required Vector2 size,
  }) : super(
    position: position,
    size: size,
  );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_objects_stone_light_png);
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
