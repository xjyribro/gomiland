import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/game/data/rubbish/rubbish.dart';
import 'package:gomiland/game/data/rubbish/rubbish_object.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/room/rubbish_component.dart';

Future<RubbishComponent> getRubbishComponent(Function binCheck) async {
  RubbishType rubbishType = getRandomRubbishType();
  RubbishComponent component = await getRandomRubbishComponent(
    rubbishType: rubbishType,
    binCheck: binCheck,
  );
  return component;
}

RubbishType getRandomRubbishType() {
  int rand = Random().nextInt(6);
  List<RubbishType> types = [
    RubbishType.plastic,
    RubbishType.paper,
    RubbishType.food,
    RubbishType.glass,
    RubbishType.metal,
    RubbishType.electronics,
  ];
  return types[rand];
}

Future<RubbishComponent> getRandomRubbishComponent({
  required RubbishType rubbishType,
  required Function binCheck,
}) async {
  List<RubbishObject> objectsList = getRubbishListFromDB(rubbishType);
  RubbishObject rubbishObject = getRandomRubbishObject(objectsList);
  RubbishComponent rubbishComponent = await getRubbishComponentFromObject(
    rubbishObject: rubbishObject,
    binCheck: binCheck,
  );
  return rubbishComponent;
}

List<RubbishObject> getRubbishListFromDB(RubbishType rubbishType) {
  RubbishData rubbishData = RubbishData();
  switch (rubbishType) {
    case RubbishType.plastic:
      return rubbishData.plasticObjects;
    case RubbishType.paper:
      return rubbishData.paperObjects;
    case RubbishType.food:
      return rubbishData.foodObjects;
    case RubbishType.metal:
      return rubbishData.metalObjects;
    case RubbishType.electronics:
      return rubbishData.electronicObjects;
    case RubbishType.glass:
      return rubbishData.glassObjects;
    case RubbishType.unknown:
      return rubbishData.plasticObjects;
  }
}

RubbishObject getRandomRubbishObject(List<RubbishObject> rubbishObjects) {
  int index = Random().nextInt(rubbishObjects.length);
  return rubbishObjects[index];
}

Future<RubbishComponent> getRubbishComponentFromObject({
  required RubbishObject rubbishObject,
  required Function binCheck,
}) async {
  Sprite rubbishSprite = await getRandomSprite(rubbishObject);
  return RubbishComponent(
    sprite: rubbishSprite,
    name: rubbishObject.name,
    rubbishType: rubbishObject.rubbishType,
    binCheck: binCheck,
    hitboxSize: rubbishObject.hitboxSize,
  );
}

Future<Sprite> getRandomSprite(RubbishObject rubbishObject) async {
  int index = rubbishObject.spriteCount > 1
      ? Random().nextInt(rubbishObject.spriteCount - 1)
      : 0;
  final image = await Flame.images.load(rubbishObject.assetPath);
  final spriteSheet = SpriteSheet(
    image: image,
    srcSize: rubbishObject.size,
  );
  return spriteSheet.getSprite(0, index);
}

String getIndefiniteArticle(String word, bool shouldCapitalise) {
  String lowercaseWord = word.toLowerCase();
  bool startsWithVowel = vowels.contains(lowercaseWord[0]);
  String article = (startsWithVowel ? 'an' : 'a');
  if (shouldCapitalise) {
    article = article.capitalize();
  }
  return '$article $word';
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

String getDialogueName(RubbishType binType, ProgressState progressState) {
  switch (binType) {
    case RubbishType.plastic:
      return progressState.risa < 0 ? 'rubbish_error' : 'plastic_error';
    case RubbishType.electronics:
      return progressState.asimov < 0 ? 'rubbish_error' : 'electronics_error';
    case RubbishType.glass:
      return progressState.manuka < 0 ? 'rubbish_error' : 'glass_error';
    case RubbishType.food:
      return progressState.moon < 0 ? 'rubbish_error' : 'food_error';
    case RubbishType.metal:
      return progressState.stark < 0 ? 'rubbish_error' : 'metal_error';
    case RubbishType.paper:
      return progressState.qianBi < 0 ? 'rubbish_error' : 'paper_error';
    default:
      return 'rubbish_error';
  }
}

int getExtraReward(int progress) {
  int reward = progress.clamp(0, completedCharInt);
  return (reward / 100).floor();
}

void changeCoinAmount(GomilandGame game, int amount) {
  game.gameStateBloc.add(SetCoinAmount(amount));
}

void updateProgress(GomilandGame game, RubbishType rubbishType) {
  switch (rubbishType) {
    case RubbishType.plastic:
      int plastic = game.progressStateBloc.state.plastic;
      game.progressStateBloc.add(SetPlasticProgress(plastic + 1));
      int risa = game.progressStateBloc.state.risa;
      if (risa >= levelOneBaseInt && risa < levelTwoBaseInt) {
        risa += 1;
        game.progressStateBloc.add(SetRisaProgress(
            risa.clamp(levelOneBaseInt, levelTwoBaseInt - 1)));
      }
      if (risa >= levelTwoBaseInt && risa < completedCharInt) {
        risa += 1;
        game.progressStateBloc.add(SetRisaProgress(
            risa.clamp(levelTwoBaseInt, completedCharInt - 1)));
      }
      break;
    case RubbishType.glass:
      int glass = game.progressStateBloc.state.glass;
      game.progressStateBloc.add(SetGlassProgress(glass + 1));
      int manuka = game.progressStateBloc.state.manuka;
      if (manuka >= levelOneBaseInt && manuka < levelTwoBaseInt) {
        manuka += 1;
        game.progressStateBloc.add(SetManukaProgress(
            manuka.clamp(levelOneBaseInt, levelTwoBaseInt - 1)));
      }
      if (manuka >= levelTwoBaseInt && manuka < completedCharInt) {
        manuka += 1;
        game.progressStateBloc.add(SetManukaProgress(
            manuka.clamp(levelTwoBaseInt, completedCharInt - 1)));
      }
      break;
    case RubbishType.paper:
      int paper = game.progressStateBloc.state.paper;
      game.progressStateBloc.add(SetPaperProgress(paper + 1));
      int qianBi = game.progressStateBloc.state.qianBi;
      if (qianBi >= levelOneBaseInt && qianBi < levelTwoBaseInt) {
        qianBi += 1;
        game.progressStateBloc.add(SetQianBiProgress(
            qianBi.clamp(levelOneBaseInt, levelTwoBaseInt - 1)));
      }
      if (qianBi >= levelTwoBaseInt && qianBi < completedCharInt) {
        qianBi += 1;
        game.progressStateBloc.add(SetQianBiProgress(
            qianBi.clamp(levelTwoBaseInt, completedCharInt - 1)));
      }
      break;
    case RubbishType.metal:
      int metal = game.progressStateBloc.state.metal;
      game.progressStateBloc.add(SetMetalProgress(metal + 1));
      int stark = game.progressStateBloc.state.stark;
      if (stark >= levelOneBaseInt && stark < levelTwoBaseInt) {
        stark += 1;
        game.progressStateBloc.add(SetStarkProgress(
            stark.clamp(levelOneBaseInt, levelTwoBaseInt - 1)));
      }
      if (stark >= levelTwoBaseInt && stark < completedCharInt) {
        stark += 1;
        game.progressStateBloc.add(SetStarkProgress(
            stark.clamp(levelTwoBaseInt, completedCharInt - 1)));
      }
      break;
    case RubbishType.electronics:
      int electronics = game.progressStateBloc.state.electronics;
      game.progressStateBloc.add(SetElectronicsProgress(electronics + 1));
      int asimov = game.progressStateBloc.state.asimov;
      if (asimov >= levelOneBaseInt && asimov < levelTwoBaseInt) {
        asimov += 1;
        game.progressStateBloc.add(SetAsimovProgress(
            asimov.clamp(levelOneBaseInt, levelTwoBaseInt - 1)));
      }
      if (asimov >= levelTwoBaseInt && asimov < completedCharInt) {
        asimov += 1;
        game.progressStateBloc.add(SetAsimovProgress(
            asimov.clamp(levelTwoBaseInt, completedCharInt - 1)));
      }
      break;
    case RubbishType.food:
      int food = game.progressStateBloc.state.food;
      game.progressStateBloc.add(SetFoodProgress(food + 1));
      int moon = game.progressStateBloc.state.moon;
      if (moon >= levelOneBaseInt && moon < levelTwoBaseInt) {
        moon += 1;
        game.progressStateBloc.add(SetMoonProgress(
            moon.clamp(levelOneBaseInt, levelTwoBaseInt - 1)));
      }
      if (moon >= levelTwoBaseInt && moon < completedCharInt) {
        moon += 1;
        game.progressStateBloc.add(SetMoonProgress(
            moon.clamp(levelTwoBaseInt, completedCharInt - 1)));
      }
      break;
    default:
      break;
  }
}
