import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/game/data/rubbish/rubbish_object.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/room/spawner_utils.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_button.dart';
import 'package:gomiland/game/ui/info_popup/utils.dart';

class RubbishInfoPopup extends HudMarginComponent
    with HasGameReference<GomilandGame> {
  RubbishInfoPopup({
    required RubbishType rubbishType,
    super.margin = const EdgeInsets.only(
      left: boxMarginFromLeft,
      top: 16,
    ),
    super.priority = 2,
  }) : super() {
    _rubbishType = rubbishType;
  }

  late RubbishType _rubbishType;

  @override
  Future<void> onLoad() async {
    game.freezePlayer();
    RubbishInfoPopupSpriteComponent infoPopupSpriteComponent =
        RubbishInfoPopupSpriteComponent(rubbishType: _rubbishType);
    add(infoPopupSpriteComponent);
  }
}

class RubbishInfoPopupSpriteComponent extends SpriteComponent
    with HasGameReference<GomilandGame> {
  RubbishInfoPopupSpriteComponent({
    required RubbishType rubbishType,
  }) : super() {
    _rubbishType = rubbishType;
  }

  late RubbishType _rubbishType;

  void _onClosePopup() {
    game.cameraComponent.viewport.children
        .query<RubbishInfoPopup>()
        .forEach((component) {
      component.removeFromParent();
    });
    game.unfreezePlayer();
  }

  Future<void> _addRubbishSprites(List<RubbishObject> rubbishObjects) async {
    double positX = 160;
    int count = 0;
    int curr = 0;
    const maxWidth = 96;
    while (count < 5 && curr < rubbishObjects.length - 1) {
      RubbishObject object = rubbishObjects[curr];
      curr++;
      if (object.size.x > maxWidth) {
        continue;
      }
      Sprite sprite = await getSprite(object);
      add(SpriteComponent(
        sprite: sprite,
        position: Vector2(positX, getSpriteYPosit(object.size.y)),
        size: object.size,
      ));
      positX = positX + object.size.x + 16;
      count++;
    }
  }

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      Assets.assets_images_ui_info_box_png,
      srcSize: Vector2(736, 352),
    );
    List<RubbishObject> rubbishObjectList = getRubbishListFromDB(_rubbishType);
    _addRubbishSprites(rubbishObjectList);
    add(
      TextBoxComponent(
        text:
            '${_rubbishType.string.capitalize()} bin. Example items that go here:',
        size: Vector2(704, 32),
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
