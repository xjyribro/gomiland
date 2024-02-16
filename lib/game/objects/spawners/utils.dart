import 'package:flutter/services.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/scene_name.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:jenny/jenny.dart';

List<int> generateRandomSpawnerList(int spawnerCount, int numToPick) {
  List<int> list = List<int>.generate(spawnerCount, (i) => i + 1);
  list.shuffle();
  return list.take(numToPick).toList();
}

List<int> generateNewHoodRubbishList() {
  List<int> newList = generateRandomSpawnerList(
      spawnerCount, (spawnerCount * spawnRatio).floor());
  if (!newList.contains(0)) {
    // rubbish always appears outside the house
    newList.add(0);
  }
  return newList;
}

List<int> generateNewParkRubbishList() {
  return generateRandomSpawnerList(
      spawnerCount, (spawnerCount * spawnRatio).floor());
}

void respawnRubbishAndSetState(GomilandGame game) {
  List<int> hoodSpawnList = generateNewHoodRubbishList();
  List<int> parkSpawnList = generateNewParkRubbishList();
  game.gameStateBloc.add(SetHoodSpawnersList(hoodSpawnList));
  game.gameStateBloc.add(SetParkSpawnersList(parkSpawnList));
}

void removeIndexFromSpawnerList({
  required GomilandGame game,
  required SceneName sceneName,
  required int index,
}) {
  bool isHood = sceneName == SceneName.hood;
  List<int> spawners = isHood
      ? game.gameStateBloc.state.hoodSpawners
      : game.gameStateBloc.state.parkSpawners;
  if (spawners.contains(index)) {
    spawners.remove(index);
  }
  game.gameStateBloc.add(
    isHood ? SetHoodSpawnersList(spawners) : SetParkSpawnersList(spawners),
  );
}

void playPickUpSound(GomilandGame game) {
  bool isMute = game.gameStateBloc.state.isMute;
  if (!isMute) Sounds.pickup();
}

void increaseBagCount(GomilandGame game) {
  game.gameStateBloc.add(const AddOneToBag());
}

Future<void> showBagFullMessage(GomilandGame game) async {
  game.freezePlayer();
  DialogueControllerComponent dialogueControllerComponent =
      game.dialogueControllerComponent;
  YarnProject yarnProject = YarnProject();

  // DIALOGUE
  yarnProject.parse(
    await rootBundle.loadString(Assets.assets_yarn_general_yarn),
  );
  DialogueRunner dialogueRunner = DialogueRunner(
    yarnProject: yarnProject,
    dialogueViews: [dialogueControllerComponent],
  );
  await dialogueRunner.startDialogue('bag_is_full');
  game.unfreezePlayer();
}
