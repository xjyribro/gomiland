// flame
// ignore_for_file: constant_identifier_names

const isDebugMode = false;
const double gameWidth = 1000;
const double gameHeight = 600;
const double viewportWidth = 800;
const double viewportHeight = 400;

// ui
const double boxMarginFromLeft = 28;
const double dialogueBoxMarginFromTop = 270;

// map
const double tileSize = 32;
const int spawnerCount = 100;
const double parkStartX = 96;
const double parkStartY = 3660;
const double hoodStartFromRoomX = 1780;
const double hoodStartFromRoomY = 580;
const double hoodStartFromParkX = 6270;
const double hoodStartFromParkY = 4300;

// game
const int playerSize = 32;
const int playerBaseSpeed = 2;
const double npcSpeed = 2;
const double maxRaycastDist = 40;
const int maxCoinAmount = 999999;

// day cycle
const gameMinToRealSecond = 0.5;
const gameStartTime = 360;
const minsInADay = 1440;
const morningStartMins = 360;
const afternoonStartMins = 720;
const eveningStartMins = 1080;
const nightStartMins = 0;
const newDayMins = 0;
const spawnRatio = .5;

// dialogue
const double dialogueBoxFontSize = 24;
const double infoPopupFontSize = 17;
const double dialogueButtonFontSize = 16;
const double timePerChar = 0.05;
const int npcDialogueCount = 5;

//animation
const stepTime = 0.1;

// sorting game
const basePlasticReward = 1;
const basePaperReward = 1;
const baseGlassReward = 1;
const baseElectronicsReward = 2;
const baseMetalReward = 2;
const baseFoodReward = 1;
const List<String> vowels = ['a', 'e', 'i', 'o', 'u'];
const int leaveRoomPenalty = 10;

// progress
const newCharProgress = -1;
const levelOneBaseInt = 0;
const levelTwoBaseInt = 100;
const completedCharInt = 200;

const List<String> genderOptions = ['Male', 'Female'];
const List<String> showControlOptions = ['Yes', 'No'];
const List<String> zenGardenObjects = [
  'rock_1',
  'rock_2',
  'rock_3',
  'rock_4',
  'bonsai_1',
  'bonsai_2',
  'bonsai_3',
  'bonsai_4',
];

const Map<String, bool> defaultZenGardenData = {
  ZenStrings.rock_4: false
};

class ZenStrings {
  static const rock_1 = 'rock_1';
  static const rock_2 = 'rock_2';
  static const rock_3 = 'rock_3';
  static const rock_4 = 'rock_4';
  static const bonsai_1 = 'bonsai_1';
  static const bonsai_2 = 'bonsai_2';
  static const bonsai_3 = 'bonsai_3';
  static const bonsai_4 = 'bonsai_4';
  static const pre_buy = 'pre_buy';
  static const buy = 'buy';
  static const post_buy = 'post_buy';
}

String getRockStringFromInt(int index) {
  return 'rock_$index';
}

String getBonsaiStringFromInt(int index) {
  return 'bonsai_$index';
}

class CollectionStrings {
  static const players = 'players';
  static const redemptionCode = 'redemptionCode';
}

class Strings {
  static const minecraft = 'minecraft';
  static const hasSave = 'hasSave';
  static const playerName = 'playerName';
  static const country = 'country';
  static const isMale = 'isMale';
  static const playerSpeed = 'playerSpeed';
  static const playerXPosit = 'playerXPosit';
  static const playerYPosit = 'playerYPosit';
  static const playerXDir = 'playerXDir';
  static const playerYDir = 'playerYDir';
  static const savedLocation = 'savedLocation';
  static const coinAmount = 'coinAmount';
  static const sceneName = 'sceneName';
  static const bagCount = 'bagCount';
  static const bagSize = 'bagSize';
  static const minutes = 'minutes';
  static const daysInGame = 'daysInGame';
  static const plastic = 'plastic';
  static const paper = 'paper';
  static const metal = 'metal';
  static const electronics = 'electronics';
  static const glass = 'glass';
  static const food = 'food';
  static const wrong = 'wrong';
  static const manuka = 'manuka';
  static const qianBi = 'qianBi';
  static const risa = 'risa';
  static const stark = 'stark';
  static const asimov = 'asimov';
  static const moon = 'moon';
  static const neighbour = 'neighbour';
  static const friendsList = 'friendsList';
  static const friendRequestsSent = 'friendRequestsSent';
  static const friendRequestsReceived = 'friendRequestsReceived';
  static const hoodSpawners = 'hoodSpawners';
  static const parkSpawners = 'parkSpawners';
  static const zenGarden = 'zenGarden';
  static const code = 'code';
  static const count = 'count';
  static const object = 'object';
}
