import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/objects/lights/light_sprite.dart';

class StreetLight extends PositionComponent {
  StreetLight({
    required Vector2 position,
    required Vector2 size,
    required bool shouldAddLight,
  }) : super(position: position, size: size) {
    _shouldAddLight = shouldAddLight;
  }

  late bool _shouldAddLight;
  LightSprite light = LightSprite(position: Vector2(-36, -24));

  @override
  Future<void> onLoad() async {
    add(StreetLamp(position: Vector2.zero(), size: size));
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
      for (var light in lightChildren) {
        light.removeFromParent();
      }
    }
  }
}

class StreetLamp extends SpriteComponent with HasGameReference<GomilandGame> {
  StreetLamp({
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
        );

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache(
      Assets.assets_images_objects_street_lamp_png,
    ));
  }
}
