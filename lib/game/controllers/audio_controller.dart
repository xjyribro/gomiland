import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static Future initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'pickup.mp3',
      'next.mp3',
      'correct.mp3',
      'incorrect.mp3',
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
    return FlameAudio.bgm.stop();
  }

  static void playMainMenuBgm() async {
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.play('bgm/olib_oil.mp3');
  }

  static void playHoodBgm() {
    FlameAudio.bgm.play('bgm/wumwob_squarewave.mp3');
  }

  static void playParkBgm() {
    FlameAudio.bgm.play('bgm/roomboi.mp3');
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
