import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/ui/info_popup/info_popup_data.dart';
import 'package:gomiland/game/ui/info_popup/info_popup.dart';

class Sign extends SpriteComponent with HasGameReference<GomilandGame> {
  Sign({required Vector2 position, required String signName})
      : super(position: position) {
    _signName = signName;
  }

  late String _signName;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_objects_general_sign_png);
    RectangleHitbox hitbox = RectangleHitbox(
      size: Vector2(32, 48),
      position: Vector2(0, 16),
      collisionType: CollisionType.passive,
    );
    add(hitbox);
  }

  void readSign() {
    game.freezePlayer();
    InfoPopupObject infoPopupObject = getInfoPopupObject(_signName);
    InfoPopup popup = InfoPopup(infoPopupObject: infoPopupObject);
    game.cameraComponent.viewport.add(popup);
  }
}
