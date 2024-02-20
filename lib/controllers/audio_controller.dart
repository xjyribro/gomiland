import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static Future initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'sfx/pickup.mp3',
      'sfx/next.mp3',
      'sfx/correct.mp3',
      'sfx/incorrect.mp3',
    ]);
  }

  static void pickup() {
    FlameAudio.play('sfx/pickup.mp3', volume: 0.4);
  }

  static void next() {
    FlameAudio.play('sfx/next.mp3', volume: 0.3);
  }

  static void correct() {
    FlameAudio.play('sfx/correct.mp3', volume: 0.4);
  }

  static void incorrect() {
    FlameAudio.play('sfx/incorrect.mp3');
  }

  static void interact() {
    FlameAudio.play('sfx/pickup.mp3', volume: 0.4);
  }

  static stopBackgroundSound() {
    return  FlameAudio.bgm.stop();
  }

  static void playMainMenuBgm() async {
    FlameAudio.bgm.play('bgm/olib_oil.mp3');
  }

  static void playHoodBgm() {
    FlameAudio.bgm.play('bgm/hood_bgm.mp3');
  }

  static void playParkBgm() {
    FlameAudio.bgm.play('bgm/park_bgm.mp3');
  }

  static void playRoomBgm() {
    FlameAudio.bgm.play('bgm/behind_the_rocks.mp3');
  }

  static void pauseBackgroundSound() {
    FlameAudio.bgm.pause();
  }

  static void resumeBackgroundSound() {
    FlameAudio.bgm.resume();
  }

  static void dispose() {
    FlameAudio.bgm.dispose();
  }
}
