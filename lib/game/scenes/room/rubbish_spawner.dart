import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/room/rubbish_component.dart';

class RubbishSpawner extends PositionComponent
    with HasGameReference<GomilandGame> {
  RubbishSpawner({required Vector2 centerOfScene}) : super() {
    _centerOfScene = centerOfScene;
  }

  late Vector2 _centerOfScene;
  late SpriteComponent _rubbishComponent;
  late int _bagCount;

  void _addRubbish() async {
    Sprite rubbishSprite =
        await Sprite.load(Assets.assets_images_rubbish_jar_png);
    _rubbishComponent = RubbishComponent(
      sprite: rubbishSprite,
      position: _centerOfScene,
      name: 'jar',
      rubbishType: RubbishType.glass,
      removeRubbish: _removeRubbish,
    );
    await add(_rubbishComponent);
  }

  void _removeRubbish() {
    _bagCount -= 1;
    game.gameStateBloc.add(BagCountChange(_bagCount -1));
    remove(_rubbishComponent);
    if (_bagCount > 0) {
      _addRubbish();
      // control sorting game
    }
  }


  @override
  Future<void> onLoad() async {
    _bagCount = game.gameStateBloc.state.bagCount;
    if (_bagCount > 0) {
      _addRubbish();
      // control sorting game
    }
  }
}
