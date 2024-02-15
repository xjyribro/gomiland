import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/scene_name.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:jenny/jenny.dart';

class RubbishSpawner extends SpriteComponent
    with HasGameReference<GomilandGame> {
  RubbishSpawner({
    required Vector2 position,
    required SceneName sceneName,
    required int index,
  }) : super(position: position) {
    _sceneName = sceneName;
    _index = index;
  }

  late RectangleHitbox _hitbox;
  late SceneName _sceneName;
  late int _index;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(Assets.assets_images_rubbish_rubbish_small_png);
    _hitbox = RectangleHitbox(
      size: Vector2(40, 40),
      position: Vector2(16, 16),
      anchor: Anchor.center,
      collisionType: CollisionType.passive,
    );
    add(_hitbox);
  }

  Future<void> _showBagFullMessage() async {
    game.freezePlayer();
    DialogueControllerComponent dialogueControllerComponent =
        game.dialogueControllerComponent;
    YarnProject yarnProject = YarnProject();

    // DIALOGUE
    yarnProject
        .parse(await rootBundle.loadString(Assets.assets_yarn_general_yarn));
    DialogueRunner dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
    await dialogueRunner.startDialogue('bag_is_full');
    game.unfreezePlayer();
  }

  void _onPickup(int bagCount) {
    bool isHood = _sceneName == SceneName.hood;
    List<int> spawners = isHood
        ? game.gameStateBloc.state.hoodSpawners
        : game.gameStateBloc.state.parkSpawners;
    spawners.remove(_index);
    game.gameStateBloc.add(
      isHood ? SetHoodSpawnersList(spawners) : SetParkSpawnersList(spawners),
    );
    game.gameStateBloc.add(SetBagCount(bagCount + 1));
    bool isMute = game.gameStateBloc.state.isMute;
    if (!isMute) Sounds.pickup();
    sprite = null;
    remove(_hitbox);
  }

  void pickupRubbish() {
    final int bagCount = game.gameStateBloc.state.bagCount;
    final int bagSize = game.gameStateBloc.state.bagSize;
    if (bagCount < bagSize) {
      _onPickup(bagCount);
    } else {
      _showBagFullMessage();
    }
  }
}
