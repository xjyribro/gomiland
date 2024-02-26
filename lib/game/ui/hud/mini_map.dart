import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/scene_name.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_button.dart';

class MiniMap extends HudMarginComponent with HasGameReference<GomilandGame> {
  MiniMap({
    super.margin = const EdgeInsets.only(
      left: miniMapMarginFromLeft,
      top: 16,
    ),
  });

  @override
  Future<void> onLoad() async {
    game.freezePlayer();
    SceneName currSceneName = game.gameStateBloc.state.sceneName;
    bool isHood = currSceneName == SceneName.hood;
    MiniMapSprite infoPopupSpriteComponent = MiniMapSprite(
      mapSpritePath: isHood
          ? Assets.assets_images_tile_maps_mini_hood_png
          : Assets.assets_images_tile_maps_mini_park_png,
    );
    add(infoPopupSpriteComponent);
  }
}

class MiniMapSprite extends SpriteComponent
    with HasGameReference<GomilandGame> {
  MiniMapSprite({
    required String mapSpritePath,
  }) : super() {
    _mapSpritePath = mapSpritePath;
  }

  late String _mapSpritePath;

  void _onClosePopup() {
    game.cameraComponent.viewport.children
        .query<MiniMap>()
        .forEach((component) {
      component.removeFromParent();
    });
    game.unfreezePlayer();
  }

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      _mapSpritePath,
      srcSize: Vector2(512, 384),
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
