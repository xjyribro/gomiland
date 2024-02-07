import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/room/spawner_utils.dart';
import 'package:jenny/jenny.dart';

class RubbishSpawner extends PositionComponent
    with HasGameReference<GomilandGame> {
  RubbishSpawner({
    required Vector2 centerOfScene,
    required Function showScore,
  }) : super() {
    _centerOfScene = centerOfScene;
    _showScore = showScore;
  }

  late Vector2 _centerOfScene;
  late Function _showScore;
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

  Future<void> _binCheck(
      RubbishType binType, RubbishType rubbishType, String rubbishName) async {
    if (rubbishType == binType) {
      // show reward
      int reward = _rewardMap[rubbishType] ?? 1;
      game.gameStateBloc.add(CoinAmountChange(reward));
      _showScore(binType, reward);
    } else {
      // show penalty
      int rubbishFine = _rewardMap[rubbishType] ?? 1;
      int binFine = _rewardMap[binType] ?? 1;
      int totalFine = rubbishFine + binFine;
      game.gameStateBloc.add(CoinAmountChange(-totalFine));
      _showScore(binType, -totalFine);
      await _showErrorDialogue(binType, rubbishType, rubbishName);
    }

    int bagCount = game.gameStateBloc.state.bagCount;
    if (bagCount > 0) {
      _addRubbishUpdateBag();
      // control sorting game
    }
  }

  Future<void> _showErrorDialogue(
    RubbishType binType,
    RubbishType rubbishType,
    String rubbishName,
  ) async {
    YarnProject yarnProject = YarnProject();
    yarnProject
      ..parse(
          await rootBundle.loadString(Assets.assets_yarn_rubbish_error_yarn))
      ..variables
          .setVariable('\$rubbishName', getIndefiniteArticle(rubbishName));
    DialogueRunner dialogueRunner = DialogueRunner(
        yarnProject: yarnProject,
        dialogueViews: [game.dialogueControllerComponent]);
    await dialogueRunner.startDialogue(getDialogueName(binType));
  }

  void _initRewardMap() {
    int plasticReward =
        basePlasticReward + game.progressStateBloc.state.plastic;
    int paperReward = basePaperReward + game.progressStateBloc.state.paper;
    int metalReward = baseMetalReward + game.progressStateBloc.state.metal;
    int foodReward = baseFoodReward + game.progressStateBloc.state.food;
    int electronicsReward =
        baseElectronicsReward + game.progressStateBloc.state.electronics;
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
