import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/objects/obsticle.dart';
import 'package:gomiland/game/ui/info_popup/info_popup_data.dart';
import 'package:gomiland/game/ui/info_popup/info_popup.dart';

class CombiniSign extends SpriteComponent with HasGameReference<GomilandGame> {
  CombiniSign({required Vector2 position});

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_objects_go_sign_png);
    Obstacle obstacle = Obstacle(size: Vector2(16, 32), position: Vector2(8, 64));
    RectangleHitbox hitbox = RectangleHitbox(
      size: Vector2(32, 32),
      position: Vector2(0, 64),
      collisionType: CollisionType.passive,
    );
    addAll([hitbox, obstacle]);
  }

  void readSign() {
    game.freezePlayer();
    InfoPopupObject infoPopupObject = getInfoPopupObject('combini');
    InfoPopup popup = InfoPopup(infoPopupObject: infoPopupObject);
    game.cameraComponent.viewport.add(popup);
  }
}
