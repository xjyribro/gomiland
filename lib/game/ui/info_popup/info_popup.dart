import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/ui/info_popup/info_popup_data.dart';

class InfoPopup extends HudMarginComponent {
  InfoPopup({
    required InfoPopupObject infoPopupObject,
    super.margin = const EdgeInsets.only(
      left: 28,
      top: 16,
    ),
  }) : super() {
    _infoPopupObject = infoPopupObject;
  }

  late InfoPopupObject _infoPopupObject;

  @override
  Future<void> onLoad() async {
    InfoPopupSpriteComponent infoPopupSpriteComponent =
        InfoPopupSpriteComponent(infoPopupObject: _infoPopupObject);
    add(infoPopupSpriteComponent);
  }
}

class InfoPopupSpriteComponent extends SpriteComponent {
  InfoPopupSpriteComponent({
    required InfoPopupObject infoPopupObject,
  }) : super() {
    _infoPopupObject = infoPopupObject;
  }

  late InfoPopupObject _infoPopupObject;

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
        position: Vector2(16, 16),
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: infoPopupFontSize,
            color: Colors.black,
            fontFamily: Strings.minecraft,
          ),
        ),
      ),
    );
    return super.onLoad();
  }
}
