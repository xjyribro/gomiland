import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/audio_controller.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/room/spawner_utils.dart';
import 'package:jenny/jenny.dart';

class RubbishSpawner extends PositionComponent
    with HasGameReference<GomilandGame> {
  RubbishSpawner({
    required Vector2 centerOfScene,
    required Function showScore,
    required Function setHasUncleared,
  }) : super() {
    _centerOfScene = centerOfScene;
    _showScore = showScore;
    _setHasUncleared = setHasUncleared;
  }

  late Vector2 _centerOfScene;
  late Function _showScore;
  late Function _setHasUncleared;
  late final Map<RubbishType, int> _rewardMap = {};

  void _addRubbishUpdateBag() async {
    int risaQuestState = game.progressStateBloc.state.risa;
    bool isPlasticsReduced = risaQuestState >= completedCharInt;
    SpriteComponent rubbishComponent =
        await getRubbishComponent(_binCheck, isPlasticsReduced);
    await add(rubbishComponent);
    _setHasUncleared(true);
    _removeOneFromBag();
  }

  void _removeOneFromBag() {
    int bagCount = game.gameStateBloc.state.bagCount;
    game.gameStateBloc.add(SetBagCount(bagCount - 1));
  }

  void _handleCorrectBin(
    RubbishType binType,
    RubbishType rubbishType,
  ) {
    int reward = _rewardMap[rubbishType] ?? 1;
    changeCoinAmount(game, reward);
    updateProgress(game, rubbishType);
    _showScore(binType, reward);
    if (game.gameStateBloc.state.bagSize < 2) {
      _onFirstThrow(true);
    }
  }

  Future<void> _handleWrongBin(
    RubbishType binType,
    RubbishType rubbishType,
    String rubbishName,
  ) async {
    int rubbishFine = _rewardMap[rubbishType] ?? 1;
    int binFine = _rewardMap[binType] ?? 1;
    int totalFine = rubbishFine + binFine;
    changeCoinAmount(game, -totalFine);
    _showScore(binType, -totalFine);
    _updateFailureProgress();
    await _showErrorDialogue(binType, rubbishType, rubbishName);
    if (game.gameStateBloc.state.bagSize < 2) {
      _onFirstThrow(false);
    }
  }

  void _updateFailureProgress() {
    game.progressStateBloc
        .add(SetWrongProgress(game.progressStateBloc.state.wrong + 1));
  }

  void _onFirstThrow(bool isCorrect) {
    game.progressStateBloc.add(
      SetNeighbourState('level_1_${isCorrect ? 'correct' : 'incorrect'}'),
    );
  }

  Future<void> _binCheck(
    RubbishType binType,
    RubbishType rubbishType,
    String rubbishName,
  ) async {
    _setHasUncleared(false);
    bool isMute = game.gameStateBloc.state.isMute;
    if (rubbishType == binType) {
      if (!isMute) Sounds.correct();
      _handleCorrectBin(binType, rubbishType);
    } else {
      if (!isMute) Sounds.incorrect();
      await _handleWrongBin(binType, rubbishType, rubbishName);
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
    ProgressState progressState = game.progressStateBloc.state;
    String dialogueName = getDialogueName(binType, progressState);
    bool shouldCapitalise = !(dialogueName == 'rubbish_error');
    yarnProject
      ..parse(
          await rootBundle.loadString(Assets.assets_yarn_rubbish_error_yarn))
      ..variables.setVariable(
          '\$rubbishName', getIndefiniteArticle(rubbishName, shouldCapitalise));
    DialogueRunner dialogueRunner = DialogueRunner(
        yarnProject: yarnProject,
        dialogueViews: [game.dialogueControllerComponent]);
    await dialogueRunner.startDialogue(getDialogueName(binType, progressState));
  }

  void _initRewardMap() {
    int risaReward = getExtraReward(game.progressStateBloc.state.risa);
    int qianBiReward = getExtraReward(game.progressStateBloc.state.qianBi);
    int starkReward = getExtraReward(game.progressStateBloc.state.stark);
    int moonReward = getExtraReward(game.progressStateBloc.state.moon);
    int asimovReward = getExtraReward(game.progressStateBloc.state.asimov);
    int manukaReward = getExtraReward(game.progressStateBloc.state.manuka);

    int plasticReward = basePlasticReward + risaReward;
    int paperReward = basePaperReward + qianBiReward;
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
