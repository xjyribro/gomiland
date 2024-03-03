import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_button.dart';
import 'package:gomiland/game/ui/info_popup/info_popup_data.dart';

class InfoPopup extends HudMarginComponent with HasGameReference<GomilandGame> {
  InfoPopup({
    required InfoPopupObject infoPopupObject,
    super.margin = const EdgeInsets.only(
      left: boxMarginFromLeft,
      top: 16,
    ),
    super.priority = 2,
  }) : super() {
    _infoPopupObject = infoPopupObject;
  }

  late InfoPopupObject _infoPopupObject;

  @override
  Future<void> onLoad() async {
    game.freezePlayer();
    InfoPopupSpriteComponent infoPopupSpriteComponent =
        InfoPopupSpriteComponent(infoPopupObject: _infoPopupObject);
    add(infoPopupSpriteComponent);
  }
}

class InfoPopupSpriteComponent extends SpriteComponent
    with HasGameReference<GomilandGame> {
  InfoPopupSpriteComponent({
    required InfoPopupObject infoPopupObject,
  }) : super() {
    _infoPopupObject = infoPopupObject;
  }

  late InfoPopupObject _infoPopupObject;

  void _onClosePopup() {
    game.cameraComponent.viewport.children
        .query<InfoPopup>()
        .forEach((component) {
      component.removeFromParent();
    });
    game.unfreezePlayer();
  }

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      Assets.assets_images_ui_info_box_png,
      srcSize: Vector2(736, 352),
    );
    add(
      TextBoxComponent(
        text: _infoPopupObject.text,
        size: Vector2(704, 320),
        position: Vector2(16, 24),
        textRenderer: TextPaint(
          style: TextStyles.popupTextStyle,
        ),
        align: Anchor.topCenter,
      ),
    );
    add(
      DialogueButton(
        assetPath: Assets.assets_images_ui_red_button_png,
        text: 'Close',
        posit: Vector2(size.x / 2, 10),
        onTap: _onClosePopup,
      ),
    );
    return super.onLoad();
  }
}
