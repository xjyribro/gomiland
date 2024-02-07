// flame
const isDebugMode = false;
const double gameWidth = 1000;
const double gameHeight = 600;

// ui
const double boxMarginFromLeft = 28;

// map
const double tileSize = 32;
const double parkStartX = 96;
const double parkStartY = 3660;
const double hoodStartFromRoomX = 1585;
const double hoodStartFromRoomY = 578;
const double hoodStartFromParkX = 6270;
const double hoodStartFromParkY = 4300;

// player
const double playerSpeed = 4;
const double maxRaycastDist = 40;

// day cycle
const gameMinToRealSecond = 0.5;
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

class Strings {
  static const String minecraft = 'minecraft';
}
