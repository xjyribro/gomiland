import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/objects/lights/light_sprite.dart';

class StoneLight extends PositionComponent {
  StoneLight({
    required Vector2 position,
    required Vector2 size,
    required bool shouldAddLight,
  }) : super(position: position, size: size) {
    _shouldAddLight = shouldAddLight;
  }

  late bool _shouldAddLight;
  LightSprite light = LightSprite(position: Vector2(-48, -16));

  @override
  Future<void> onLoad() async {
    add(StoneLamp(position: Vector2.zero(), size: size));
    if (_shouldAddLight) {
      add(light);
    }
  }

  void addLight() {
    List<LightSprite> lightChildren = children.query<LightSprite>();
    if (lightChildren.isEmpty) {
      add(light);
    }
  }

  void removeLight() {
    List<LightSprite> lightChildren = children.query<LightSprite>();
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
