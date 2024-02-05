import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/room/spawner_utils.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:jenny/jenny.dart';

class RubbishSpawner extends PositionComponent
    with HasGameReference<GomilandGame> {
  RubbishSpawner({required Vector2 centerOfScene}) : super() {
    _centerOfScene = centerOfScene;
  }

  late Vector2 _centerOfScene;
  late final Map<RubbishType, int> _rewardMap = {};

  void _addRubbishUpdateBag() async {
    SpriteComponent rubbishComponent = await getRubbishComponent(_binCheck);
    await add(rubbishComponent);
    _removeOneFromBag();
  }

  void _removeOneFromBag() {
    int bagCount = game.gameStateBloc.state.bagCount;
    game.gameStateBloc.add(BagCountChange(bagCount - 1));
  }

  void _binCheck(RubbishType binType, RubbishType rubbishType, String rubbishName) {
    if (rubbishType == binType) {
      int reward = _rewardMap[rubbishType] ?? 1;
      game.gameStateBloc.add(CoinAmountChange(reward));
    } else {
      int rubbishFine = _rewardMap[rubbishType] ?? 1;
      int binFine = _rewardMap[binType] ?? 1;
      int totalFine = (rubbishFine + binFine);
      game.gameStateBloc.add(CoinAmountChange(-totalFine));
      _showErrorDialogue();
    }

    int bagCount = game.gameStateBloc.state.bagCount;
    if (bagCount > 0) {
      _addRubbishUpdateBag();
      // control sorting game
    }
  }

  Future<void> _showErrorDialogue() async {
    // stop sorting game
    game.overlays.add('DialogueBox');

    DialogueControllerComponent dialogueControllerComponent =
        game.dialogueControllerComponent;
    YarnProject yarnProject = YarnProject();

    // DIALOGUE
    yarnProject
        .parse(await rootBundle.loadString(Assets.assets_yarn_example_yarn));
    DialogueRunner dialogueRunner = DialogueRunner(
        yarnProject: yarnProject, dialogueViews: [dialogueControllerComponent]);
    dialogueRunner.startDialogue('example');
  }

  void _initRewardMap() {
    int plasticReward = basePlasticReward + game.progressStateBloc.state.plastic;
    int paperReward = basePaperReward + game.progressStateBloc.state.paper;
    int metalReward = baseMetalReward + game.progressStateBloc.state.metal;
    int foodReward = baseFoodReward + game.progressStateBloc.state.food;
    int electronicsReward = baseElectronicsReward + game.progressStateBloc.state.electronics;
    int glassReward = baseGlassReward + game.progressStateBloc.state.glass;
    _rewardMap[RubbishType.plastic] = plasticReward;
    _rewardMap[RubbishType.paper] = paperReward;
    _rewardMap[RubbishType.metal] = metalReward;
    _rewardMap[RubbishType.food] = foodReward;
    _rewardMap[RubbishType.electronics] = electronicsReward;
    _rewardMap[RubbishType.glass] = glassReward;
  }

  @override
  Future<void> onLoad() async {
    position = _centerOfScene;
    _initRewardMap();
    int bagCount = game.gameStateBloc.state.bagCount;
    if (bagCount > 0) {
      _addRubbishUpdateBag();
    }
  }
}
