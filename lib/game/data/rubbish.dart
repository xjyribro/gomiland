import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/enums.dart';

class RubbishObject {
  String name;
  String assetPath;
  RubbishType rubbishType;
  int spriteCount;
  Vector2 size;

  RubbishObject({
    required this.name,
    required this.assetPath,
    required this.rubbishType,
    required this.spriteCount,
    required this.size,
  });
}

class RubbishData {
  RubbishData() {
    plasticObjects = [
      plasticCup,
      plasticBottle,
    ];
    paperObjects = [
      cardboardBox,
      flier,
    ];
    glassObjects = [
      jar,
      glassBottle,
      mug
    ];
    electronicObjects = [
      drone,
    ];
    metalObjects = [
      drinkCan,
      tinCan,
    ];
    foodObjects = [
      bananaPeel,
    ];
  }

  List<RubbishObject> plasticObjects = [];
  RubbishObject plasticCup = RubbishObject(
    name: 'plastic cup',
    assetPath: Assets.assets_images_rubbish_plastic_cup_png,
    rubbishType: RubbishType.plastic,
    spriteCount: 1,
    size: Vector2(64, 64),
  );
  RubbishObject plasticBottle = RubbishObject(
    name: 'plastic bottle',
    assetPath: Assets.assets_images_rubbish_plastic_bottle_png,
    rubbishType: RubbishType.plastic,
    spriteCount: 1,
    size: Vector2(32, 96),
  );

  List<RubbishObject> paperObjects = [];
  RubbishObject cardboardBox = RubbishObject(
    name: 'cardboard box',
    assetPath: Assets.assets_images_rubbish_paper_cardboard_png,
    rubbishType: RubbishType.paper,
    spriteCount: 1,
    size: Vector2(64, 64),
  );
  RubbishObject flier = RubbishObject(
    name: 'flier',
    assetPath: Assets.assets_images_rubbish_paper_fliers_png,
    rubbishType: RubbishType.paper,
    spriteCount: 3,
    size: Vector2(64, 64),
  );

  List<RubbishObject> glassObjects = [];
  RubbishObject jar = RubbishObject(
    name: 'jar',
    assetPath: Assets.assets_images_rubbish_glass_jar_png,
    rubbishType: RubbishType.glass,
    spriteCount: 1,
    size: Vector2(64, 64),
  );
  RubbishObject glassBottle = RubbishObject(
    name: 'glass bottle',
    assetPath: Assets.assets_images_rubbish_glass_bottle_png,
    rubbishType: RubbishType.glass,
    spriteCount: 2,
    size: Vector2(32, 96),
  );
  RubbishObject mug = RubbishObject(
    name: 'mug',
    assetPath: Assets.assets_images_rubbish_glass_mug_png,
    rubbishType: RubbishType.glass,
    spriteCount: 1,
    size: Vector2(64, 64),
  );

  List<RubbishObject> electronicObjects = [];
  RubbishObject drone = RubbishObject(
    name: 'drone',
    assetPath: Assets.assets_images_rubbish_e_drone_png,
    rubbishType: RubbishType.electronics,
    spriteCount: 1,
    size: Vector2(96, 64),
  );

  List<RubbishObject> metalObjects = [];
  RubbishObject drinkCan = RubbishObject(
    name: 'drink can',
    assetPath: Assets.assets_images_rubbish_metal_cans_png,
    rubbishType: RubbishType.metal,
    spriteCount: 3,
    size: Vector2(32, 64),
  );
  RubbishObject tinCan = RubbishObject(
    name: 'tin can',
    assetPath: Assets.assets_images_rubbish_metal_tins_png,
    rubbishType: RubbishType.metal,
    spriteCount: 2,
    size: Vector2(32, 64),
  );

  List<RubbishObject> foodObjects = [];
  RubbishObject bananaPeel = RubbishObject(
    name: 'banana peel',
    assetPath: Assets.assets_images_rubbish_food_banana_png,
    rubbishType: RubbishType.food,
    spriteCount: 1,
    size: Vector2(64, 32),
  );
}
