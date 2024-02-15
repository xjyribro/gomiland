import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/data/rubbish/rubbish.dart';
import 'package:gomiland/game/data/rubbish/rubbish_object.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
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
  int rand = Random().nextInt(5);
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
  int index = rubbishObjects.length > 1
      ? Random().nextInt(rubbishObjects.length - 1)
      : 0;
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

String getIndefiniteArticle(String word) {
  String lowercaseWord = word.toLowerCase();
  bool startsWithVowel = vowels.contains(lowercaseWord[0]);
  String article = startsWithVowel ? 'an' : 'a';
  return '$article $word';
}

String getDialogueName(RubbishType binType) {
  switch (binType) {
    case RubbishType.plastic:
      return 'plastic_error';
    case RubbishType.electronics:
      return 'electronics_error';
    case RubbishType.glass:
      return 'glass_error';
    case RubbishType.food:
      return 'food_error';
    case RubbishType.metal:
      return 'metal_error';
    case RubbishType.paper:
      return 'paper_error';
    default:
      return 'rubbish_error';
  }
}

int getExtraReward(int progress) {
  int reward = progress.clamp(0, completedCharInt);
  return (reward / 100).floor();
}
