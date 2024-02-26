import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/npcs/anri.dart';
import 'package:gomiland/game/npcs/asimov.dart';
import 'package:gomiland/game/npcs/brock.dart';
import 'package:gomiland/game/npcs/brocky.dart';
import 'package:gomiland/game/npcs/florence.dart';
import 'package:gomiland/game/npcs/gaia.dart';
import 'package:gomiland/game/npcs/hardy.dart';
import 'package:gomiland/game/npcs/himiko_static.dart';
import 'package:gomiland/game/npcs/manuka.dart';
import 'package:gomiland/game/npcs/margret.dart';
import 'package:gomiland/game/npcs/mr_kushi.dart';
import 'package:gomiland/game/npcs/mr_moon.dart';
import 'package:gomiland/game/npcs/peach.dart';
import 'package:gomiland/game/npcs/qian_bi.dart';
import 'package:gomiland/game/npcs/risa.dart';
import 'package:gomiland/game/npcs/rocky.dart';
import 'package:gomiland/game/npcs/stark.dart';
import 'package:gomiland/game/player/min_map_player.dart';
import 'package:gomiland/game/player/utils.dart';
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
    MiniMapSprite miniMapSprite = MiniMapSprite(
      mapSpritePath: isHood
          ? Assets.assets_images_tile_maps_mini_hood_png
          : Assets.assets_images_tile_maps_mini_park_png,
    );
    Vector2 playerPosit = game.playerStateBloc.state.playerPosition;
    bool isMale = game.playerStateBloc.state.isMale;
    MiniMapPlayer player = MiniMapPlayer(
      position: translateMiniMapPosit(playerPosit),
      isMale: isMale,
    );
    await add(miniMapSprite);
    if (isHood) {
      await _loadHoodItems();
    } else {
      await _loadParkItems();
    }
    await add(player);
  }

  Future<void> _loadHoodItems() async {
    final TiledComponent map = await TiledComponent.load(
      'hood.tmx',
      Vector2.all(32),
    );
    final npcs = map.tileMap.getLayer<ObjectGroup>('npc');
    if (npcs != null) {
      await _loadHoodNpcs(npcs);
    }
  }

  Future<void> _loadHoodNpcs(ObjectGroup npcs) async {
    for (final TiledObject npc in npcs.objects) {
      Vector2 posit = translateMiniMapPosit(Vector2(npc.x, npc.y));
      posit.x -= 16;
      posit.y -= 16;
      switch (npc.name) {
        case 'himiko':
          await add(HimikoStatic(position: Vector2(posit.x, posit.y)));
          break;
        case 'asimov':
          await add(Asimov(position: Vector2(posit.x, posit.y)));
          break;
        case 'kushi':
          await add(MrKushi(position: Vector2(posit.x, posit.y)));
          break;
        case 'florence':
          await add(Florence(position: Vector2(posit.x, posit.y)));
          break;
        case 'stark':
          await add(Stark(position: Vector2(posit.x, posit.y)));
          break;
        case 'risa':
          await add(Risa(position: Vector2(posit.x, posit.y)));
          break;
        case 'hardy':
          await add(Hardy(position: Vector2(posit.x, posit.y)));
          break;
        case 'rocky':
          await add(Rocky(position: Vector2(posit.x, posit.y)));
          break;
        case 'ms_margret':
          await add(Margret(position: Vector2(posit.x, posit.y)));
          break;
      }
    }
  }

  Future<void> _loadParkItems() async {
    final TiledComponent map = await TiledComponent.load(
      'park.tmx',
      Vector2.all(tileSize),
    );
    final npcs = map.tileMap.getLayer<ObjectGroup>('npcs');
    if (npcs != null) {
      await _loadParkNpcs(npcs);
    }
  }

  Future<void> _loadParkNpcs(ObjectGroup npcs) async {
    for (final TiledObject npc in npcs.objects) {
      Vector2 posit = translateMiniMapPosit(Vector2(npc.x, npc.y));
      posit.x -= 16;
      posit.y -= 16;
      switch (npc.name) {
        case 'qianbi':
          await add(QianBi(position: Vector2(posit.x, posit.y)));
          break;
        case 'moon':
          await add(MrMoon(position: Vector2(posit.x, posit.y)));
          break;
        case 'manuka':
          await add(Manuka(position: Vector2(posit.x, posit.y)));
          break;
        case 'brock':
          await add(Brock(position: Vector2(posit.x, posit.y)));
          break;
        case 'brocky':
          await add(Brocky(position: Vector2(posit.x, posit.y)));
          break;
        case 'gaia':
          await add(Gaia(position: Vector2(posit.x, posit.y)));
          break;
        case 'peach':
          await add(Peach(position: Vector2(posit.x, posit.y)));
          break;
        case 'anri':
          await add(Anri(position: Vector2(posit.x, posit.y)));
          break;
      }
    }
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
