import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/game_state.dart';
import 'package:gomiland/game/controllers/progress/progress_state_bloc.dart';
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

  void _handleCorrectBin(
    RubbishType binType,
    RubbishType rubbishType,
  ) {
    int reward = _rewardMap[rubbishType] ?? 1;
    game.gameStateBloc.add(CoinAmountChange(reward));
    _showScore(binType, reward);
    _updateProgress(rubbishType);
  }

  Future<void> _handleWrongBin(
    RubbishType binType,
    RubbishType rubbishType,
    String rubbishName,
  ) async {
    int rubbishFine = _rewardMap[rubbishType] ?? 1;
    int binFine = _rewardMap[binType] ?? 1;
    int totalFine = rubbishFine + binFine;
    _showScore(binType, -totalFine);
    game.gameStateBloc.add(CoinAmountChange(-totalFine));
    _updateFailureProgress();
    await _showErrorDialogue(binType, rubbishType, rubbishName);
  }

  void _updateProgress(RubbishType rubbishType) {
    switch (rubbishType) {
      case RubbishType.plastic:
        int plastic = game.progressStateBloc.state.plastic;
        game.progressStateBloc.add(PlasticProgressChange(plastic + 1));
        int risa = game.progressStateBloc.state.risa;
        if (risa >= levelOneBaseInt && risa < levelTwoBaseInt) {
          risa += 1;
          game.progressStateBloc.add(RisaProgressChange(
              risa.clamp(levelOneBaseInt, levelTwoBaseInt - 1)));
        }
        if (risa >= levelTwoBaseInt && risa < completedCharInt) {
          risa += 1;
          game.progressStateBloc.add(RisaProgressChange(
              risa.clamp(levelTwoBaseInt, completedCharInt - 1)));
        }
        break;
      case RubbishType.glass:
        int glass = game.progressStateBloc.state.glass;
        game.progressStateBloc.add(GlassProgressChange(glass + 1));
        int manuka = game.progressStateBloc.state.manuka;
        if (manuka >= levelOneBaseInt && manuka < levelTwoBaseInt) {
          manuka += 1;
          game.progressStateBloc
              .add(ManukaProgressChange(manuka.clamp(levelOneBaseInt, 199)));
        }
        if (manuka >= levelTwoBaseInt && manuka < completedCharInt) {
          manuka += 1;
          game.progressStateBloc
              .add(ManukaProgressChange(manuka.clamp(levelTwoBaseInt, 299)));
        }
        break;
      case RubbishType.paper:
        int paper = game.progressStateBloc.state.paper;
        game.progressStateBloc.add(PaperProgressChange(paper + 1));
        int qianbi = game.progressStateBloc.state.qianBi;
        if (qianbi >= levelOneBaseInt && qianbi < levelTwoBaseInt) {
          qianbi += 1;
          game.progressStateBloc
              .add(QianBiProgressChange(qianbi.clamp(levelOneBaseInt, 199)));
        }
        if (qianbi >= levelTwoBaseInt && qianbi < completedCharInt) {
          qianbi += 1;
          game.progressStateBloc
              .add(QianBiProgressChange(qianbi.clamp(levelTwoBaseInt, 299)));
        }
        break;
      case RubbishType.metal:
        int metal = game.progressStateBloc.state.metal;
        game.progressStateBloc.add(MetalProgressChange(metal + 1));
        int stark = game.progressStateBloc.state.stark;
        if (stark >= levelOneBaseInt && stark < levelTwoBaseInt) {
          stark += 1;
          game.progressStateBloc
              .add(StarkProgressChange(stark.clamp(levelOneBaseInt, 199)));
        }
        if (stark >= levelTwoBaseInt && stark < completedCharInt) {
          stark += 1;
          game.progressStateBloc
              .add(StarkProgressChange(stark.clamp(levelTwoBaseInt, 299)));
        }
        break;
      case RubbishType.electronics:
        int electronics = game.progressStateBloc.state.electronics;
        game.progressStateBloc.add(ElectronicsProgressChange(electronics + 1));
        int asimov = game.progressStateBloc.state.asimov;
        if (asimov >= levelOneBaseInt && asimov < levelTwoBaseInt) {
          asimov += 1;
          game.progressStateBloc
              .add(AsimovProgressChange(asimov.clamp(levelOneBaseInt, 199)));
        }
        if (asimov >= levelTwoBaseInt && asimov < completedCharInt) {
          asimov += 1;
          game.progressStateBloc
              .add(AsimovProgressChange(asimov.clamp(levelTwoBaseInt, 299)));
        }
        break;
      case RubbishType.food:
        int food = game.progressStateBloc.state.food;
        game.progressStateBloc.add(FoodProgressChange(food + 1));
        int moon = game.progressStateBloc.state.moon;
        if (moon >= levelOneBaseInt && moon < levelTwoBaseInt) {
          moon += 1;
          game.progressStateBloc
              .add(MoonProgressChange(moon.clamp(levelOneBaseInt, 199)));
        }
        if (moon >= levelTwoBaseInt && moon < completedCharInt) {
          moon += 1;
          game.progressStateBloc
              .add(MoonProgressChange(moon.clamp(levelTwoBaseInt, 299)));
        }
        break;
      default:
        break;
    }
  }

  void _updateFailureProgress() {
    game.progressStateBloc
        .add(WrongProgressChange(game.progressStateBloc.state.wrong + 1));
  }

  Future<void> _binCheck(
    RubbishType binType,
    RubbishType rubbishType,
    String rubbishName,
  ) async {
    if (rubbishType == binType) {
      _handleCorrectBin(binType, rubbishType);
    } else {
      _handleWrongBin(binType, rubbishType, rubbishName);
    }

    int bagCount = game.gameStateBloc.state.bagCount;
    if (bagCount > 0) {
      _addRubbishUpdateBag();
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
    int risaReward = getExtraReward(game.progressStateBloc.state.risa);
    int qianbiReward = getExtraReward(game.progressStateBloc.state.qianBi);
    int starkReward = getExtraReward(game.progressStateBloc.state.stark);
    int moonReward = getExtraReward(game.progressStateBloc.state.moon);
    int asimovReward = getExtraReward(game.progressStateBloc.state.asimov);
    int manukaReward = getExtraReward(game.progressStateBloc.state.manuka);

    int plasticReward = basePlasticReward + risaReward;
    int paperReward = basePaperReward + qianbiReward;
    int metalReward = baseMetalReward + starkReward;
    int foodReward = baseFoodReward + moonReward;
    int electronicsReward = baseElectronicsReward + asimovReward;
    int glassReward = baseGlassReward + manukaReward;
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
