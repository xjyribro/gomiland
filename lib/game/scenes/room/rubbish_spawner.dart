import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';

class RubbishSpawner extends PositionComponent{

  RubbishSpawner({required Vector2 centerOfScene}) : super() {
    _centerOfScene = centerOfScene;
  }

  late Vector2 _centerOfScene;

  @override
  Future<void> onLoad() async {
    // check bag amount
    final int bagAmount = 1;
    // add rubbish sprites one by one
    List<SpriteComponent> rubbishComponentsList = [];
    for (int i = 0; i < bagAmount; i++) {
      Sprite rubbishSprite = await Sprite.load(Assets.assets_images_rubbish_jar_png);
      SpriteComponent rubbishComponent = SpriteComponent(sprite: rubbishSprite, position: _centerOfScene);
      rubbishComponentsList.add(rubbishComponent);
    }

    addAll(rubbishComponentsList);
    // control sorting game

  }
}