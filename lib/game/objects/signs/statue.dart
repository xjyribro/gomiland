import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/ui/info_popup/info_popup.dart';
import 'package:gomiland/game/ui/info_popup/info_popup_data.dart';

class Statue extends PositionComponent with HasGameReference<GomilandGame> {
  Statue({required Vector2 super.position, required bool isMainQuestCompleted})
      : super() {
    _isMainQuestCompleted = isMainQuestCompleted;
  }

  late bool _isMainQuestCompleted;

  @override
  Future<void> onLoad() async {
    if (_isMainQuestCompleted) {
      await add(
        SpriteComponent(
          sprite: await Sprite.load(Assets.assets_images_objects_samurai_png),
        ),
      );
    }
    RectangleHitbox hitbox = RectangleHitbox(
      size: Vector2(64, 64),
      position: Vector2(0, 64),
      collisionType: CollisionType.passive,
    );
    add(hitbox);
  }

  void readSign() {
    game.freezePlayer();
    InfoPopupObject infoPopupObject =
        getInfoPopupObject(_isMainQuestCompleted ? 'warrior' : 'statue');
    InfoPopup popup = InfoPopup(infoPopupObject: infoPopupObject);
    game.cameraComponent.viewport.add(popup);
  }
}
