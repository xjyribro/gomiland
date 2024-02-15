// flame
const isDebugMode = false;
const double gameWidth = 1000;
const double gameHeight = 600;
const double viewportWidth = 800;
const double viewportHeight = 400;

// ui
const double boxMarginFromLeft = 28;

// map
const double tileSize = 32;
const double parkStartX = 96;
const double parkStartY = 3660;
const double hoodStartFromRoomX = 1780;
const double hoodStartFromRoomY = 580;
const double hoodStartFromParkX = 6270;
const double hoodStartFromParkY = 4300;

// player
const double playerSpeed = 16;
const double maxRaycastDist = 40;

// day cycle
// const gameMinToRealSecond = 0.5;
const gameMinToRealSecond = 0.001;
const gameStartTime = 360;
const minsInADay = 1440;
const morningStartMins = 360;
const afternoonStartMins = 720;
const eveningStartMins = 1080;
const nightStartMins = 0;

// dialogue
const textSpeed = 100;
const double dialogueBoxFontSize = 24;
const double infoPopupFontSize = 16;
const double dialogueButtonFontSize = 16;
const double timePerChar = 0.1;
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

class Strings {
  static const minecraft = 'minecraft';
  static const playersCollection = 'players';
  static const hasSave = 'hasSave';
  static const playerName = 'playerName';
  static const country = 'country';
  static const isMale = 'isMale';
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
}
