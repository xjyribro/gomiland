import 'package:flame/components.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/data/rubbish/rubbish_object.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';

class RubbishData {
  RubbishData() {
    plasticObjects = [
      plasticCup,
      plasticBottle,
      plasticContainer,
      plasticBag,
      detergentBottle,
      noddleCup,
      straw,
    ];
    paperObjects = [
      cardboardBox,
      flier,
      eggTray,
      newspaper,
      milkCarton,
      toiletRoll,
      calendar,
      paperBag,
      letter,
    ];
    glassObjects = [
      jar,
      glassBottle,
      mug,
      glassPlate,
      bowl,
      teapot,
    ];
    electronicObjects = [
      drone,
      laptop,
      battery,
      gameDevice,
      tablet,
      mobilePhone,
    ];
    metalObjects = [
      drinkCan,
      tinCan,
      spanner,
      pot,
      fryingPan,
    ];
    foodObjects = [
      bananaPeel,
      burrito,
      chickenLeg,
      sandwich,
      pizza,
      apple,
      egg,
    ];
  }

  //PLASTIC
  List<RubbishObject> plasticObjects = [];
  RubbishObject plasticCup = RubbishObject(
    name: 'plastic cup',
    assetPath: Assets.assets_images_rubbish_plastic_cup_png,
    rubbishType: RubbishType.plastic,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject plasticBottle = RubbishObject(
    name: 'plastic bottle',
    assetPath: Assets.assets_images_rubbish_plastic_bottle_png,
    rubbishType: RubbishType.plastic,
    spriteCount: 1,
    size: Vector2(32, 96),
    hitboxSize: Vector2(16, 32),
  );
  RubbishObject plasticContainer = RubbishObject(
    name: 'plastic container',
    assetPath: Assets.assets_images_rubbish_container_png,
    rubbishType: RubbishType.plastic,
    spriteCount: 1,
    size: Vector2(64, 32),
    hitboxSize: Vector2(32, 16),
  );
  RubbishObject plasticBag = RubbishObject(
    name: 'plastic bag',
    assetPath: Assets.assets_images_rubbish_plastic_bag_png,
    rubbishType: RubbishType.plastic,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject detergentBottle = RubbishObject(
    name: 'detergent bottle',
    assetPath: Assets.assets_images_rubbish_detegent_bottle_png,
    rubbishType: RubbishType.plastic,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject noddleCup = RubbishObject(
    name: 'noodle cup',
    assetPath: Assets.assets_images_rubbish_cup_noodles_png,
    rubbishType: RubbishType.plastic,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject straw = RubbishObject(
    name: 'straw',
    assetPath: Assets.assets_images_rubbish_straw_png,
    rubbishType: RubbishType.plastic,
    spriteCount: 1,
    size: Vector2(32, 64),
    hitboxSize: Vector2(16, 32),
  );

  // PAPER
  List<RubbishObject> paperObjects = [];
  RubbishObject flier = RubbishObject(
    name: 'flier',
    assetPath: Assets.assets_images_rubbish_paper_fliers_png,
    rubbishType: RubbishType.paper,
    spriteCount: 3,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject cardboardBox = RubbishObject(
    name: 'cardboard box',
    assetPath: Assets.assets_images_rubbish_paper_cardboard_png,
    rubbishType: RubbishType.paper,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject eggTray = RubbishObject(
    name: 'egg tray',
    assetPath: Assets.assets_images_rubbish_egg_tray_png,
    rubbishType: RubbishType.paper,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject newspaper = RubbishObject(
    name: 'newspaper',
    assetPath: Assets.assets_images_rubbish_newspaper_png,
    rubbishType: RubbishType.paper,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject milkCarton = RubbishObject(
    name: 'milk carton',
    assetPath: Assets.assets_images_rubbish_milk_carton_png,
    rubbishType: RubbishType.paper,
    spriteCount: 2,
    size: Vector2(32, 64),
    hitboxSize: Vector2(16, 32),
  );
  RubbishObject toiletRoll = RubbishObject(
    name: 'toilet roll',
    assetPath: Assets.assets_images_rubbish_toilet_roll_png,
    rubbishType: RubbishType.paper,
    spriteCount: 1,
    size: Vector2(32, 32),
    hitboxSize: Vector2(16, 32),
  );
  RubbishObject calendar = RubbishObject(
    name: 'calendar',
    assetPath: Assets.assets_images_rubbish_calendar_png,
    rubbishType: RubbishType.paper,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject paperBag = RubbishObject(
    name: 'paper bag',
    assetPath: Assets.assets_images_rubbish_paper_bag_png,
    rubbishType: RubbishType.paper,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject letter = RubbishObject(
    name: 'letter',
    assetPath: Assets.assets_images_rubbish_letter_png,
    rubbishType: RubbishType.paper,
    spriteCount: 1,
    size: Vector2(32, 32),
    hitboxSize: Vector2(32, 16),
  );

  // GLASS
  List<RubbishObject> glassObjects = [];
  RubbishObject jar = RubbishObject(
    name: 'jar',
    assetPath: Assets.assets_images_rubbish_glass_jar_png,
    rubbishType: RubbishType.glass,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject glassBottle = RubbishObject(
    name: 'glass bottle',
    assetPath: Assets.assets_images_rubbish_glass_bottle_png,
    rubbishType: RubbishType.glass,
    spriteCount: 2,
    size: Vector2(32, 96),
    hitboxSize: Vector2(16, 32),
  );
  RubbishObject mug = RubbishObject(
    name: 'mug',
    assetPath: Assets.assets_images_rubbish_glass_mug_png,
    rubbishType: RubbishType.glass,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject glassPlate = RubbishObject(
    name: 'glass plate',
    assetPath: Assets.assets_images_rubbish_plate_png,
    rubbishType: RubbishType.glass,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject bowl = RubbishObject(
    name: 'glass bowl',
    assetPath: Assets.assets_images_rubbish_bowl_png,
    rubbishType: RubbishType.glass,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject teapot = RubbishObject(
    name: 'teapot',
    assetPath: Assets.assets_images_rubbish_teapot_png,
    rubbishType: RubbishType.glass,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );

  // ELECTRONICS
  List<RubbishObject> electronicObjects = [];
  RubbishObject drone = RubbishObject(
    name: 'drone',
    assetPath: Assets.assets_images_rubbish_e_drone_png,
    rubbishType: RubbishType.electronics,
    spriteCount: 1,
    size: Vector2(96, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject laptop = RubbishObject(
    name: 'laptop',
    assetPath: Assets.assets_images_rubbish_laptop_png,
    rubbishType: RubbishType.electronics,
    spriteCount: 1,
    size: Vector2(96, 64),
    hitboxSize: Vector2(64, 32),
  );
  RubbishObject battery = RubbishObject(
    name: 'battery',
    assetPath: Assets.assets_images_rubbish_battery_png,
    rubbishType: RubbishType.electronics,
    spriteCount: 1,
    size: Vector2(32, 64),
    hitboxSize: Vector2(16, 32),
  );
  RubbishObject gameDevice = RubbishObject(
    name: 'game device',
    assetPath: Assets.assets_images_rubbish_gameboy_png,
    rubbishType: RubbishType.electronics,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject tablet = RubbishObject(
    name: 'tablet',
    assetPath: Assets.assets_images_rubbish_tablet_png,
    rubbishType: RubbishType.electronics,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject mobilePhone = RubbishObject(
    name: 'mobile phone',
    assetPath: Assets.assets_images_rubbish_mobile_png,
    rubbishType: RubbishType.electronics,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );

  // METAL
  List<RubbishObject> metalObjects = [];
  RubbishObject drinkCan = RubbishObject(
    name: 'drink can',
    assetPath: Assets.assets_images_rubbish_metal_cans_png,
    rubbishType: RubbishType.metal,
    spriteCount: 3,
    size: Vector2(32, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject tinCan = RubbishObject(
    name: 'tin can',
    assetPath: Assets.assets_images_rubbish_metal_tins_png,
    rubbishType: RubbishType.metal,
    spriteCount: 2,
    size: Vector2(32, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject spanner = RubbishObject(
    name: 'spanner',
    assetPath: Assets.assets_images_rubbish_spanner_png,
    rubbishType: RubbishType.metal,
    spriteCount: 1,
    size: Vector2(64, 32),
    hitboxSize: Vector2(32, 16),
  );
  RubbishObject pot = RubbishObject(
    name: 'pot',
    assetPath: Assets.assets_images_rubbish_pot_png,
    rubbishType: RubbishType.metal,
    spriteCount: 1,
    size: Vector2(96, 64),
    hitboxSize: Vector2(64, 32),
  );
  RubbishObject fryingPan = RubbishObject(
    name: 'frying pan',
    assetPath: Assets.assets_images_rubbish_pan_png,
    rubbishType: RubbishType.metal,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );

  // FOOD
  List<RubbishObject> foodObjects = [];
  RubbishObject bananaPeel = RubbishObject(
    name: 'banana peel',
    assetPath: Assets.assets_images_rubbish_banana_png,
    rubbishType: RubbishType.food,
    spriteCount: 1,
    size: Vector2(64, 32),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject burrito = RubbishObject(
    name: 'burrito',
    assetPath: Assets.assets_images_rubbish_burrito_png,
    rubbishType: RubbishType.food,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject chickenLeg = RubbishObject(
    name: 'chicken leg',
    assetPath: Assets.assets_images_rubbish_chicken_leg_png,
    rubbishType: RubbishType.food,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject sandwich = RubbishObject(
    name: 'sandwich',
    assetPath: Assets.assets_images_rubbish_sandwich_png,
    rubbishType: RubbishType.food,
    spriteCount: 1,
    size: Vector2(64, 64),
    hitboxSize: Vector2(32, 32),
  );
  RubbishObject pizza = RubbishObject(
    name: 'pizza',
    assetPath: Assets.assets_images_rubbish_pizza_png,
    rubbishType: RubbishType.food,
    spriteCount: 1,
    size: Vector2(64, 32),
    hitboxSize: Vector2(32, 16),
  );
  RubbishObject apple = RubbishObject(
    name: 'apple',
    assetPath: Assets.assets_images_rubbish_apple_png,
    rubbishType: RubbishType.food,
    spriteCount: 1,
    size: Vector2(32, 64),
    hitboxSize: Vector2(16, 32),
  );
  RubbishObject egg = RubbishObject(
    name: 'egg shell',
    assetPath: Assets.assets_images_rubbish_egg_png,
    rubbishType: RubbishType.food,
    spriteCount: 1,
    size: Vector2(32, 32),
    hitboxSize: Vector2(32, 32),
  );
}
