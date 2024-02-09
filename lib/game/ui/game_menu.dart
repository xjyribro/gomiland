import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/game.dart';

class GameMenu extends StatelessWidget {
  final GomilandGame game;

  const GameMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: Container(
        color: GameColors.whiteTranslucent,
        width: screenSize.width,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            height: 600,
            width: 400,
            decoration: const BoxDecoration(
              color: GameColors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(64),
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  Assets.assets_images_logo_gomiland_simple_png,
                  height: 164,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 192,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () {
                      Sounds.resumeBackgroundSound();
                      game.resumeEngine();
                      game.overlays.remove('GameMenu');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GameColors.white,
                    ),
                    child: const Text(
                      'Resume',
                      style: TextStyles.menuBlackTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 192,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO save game
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GameColors.white,
                    ),
                    child: const Text(
                      'Save game',
                      style: TextStyles.menuBlackTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 192,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () {
                      //TODO prompt save game
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GameColors.white,
                    ),
                    child: const Text(
                      'Back to main menu',
                      style: TextStyles.menuBlackTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
