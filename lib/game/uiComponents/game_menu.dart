import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/game.dart';

class GameMenu extends StatelessWidget {
  final GomilandGame game;

  const GameMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);
    const whiteTranslucent = Color.fromRGBO(255, 255, 255, 0.5);
    Size screenSize = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: Container(
        color: whiteTranslucent,
        width: screenSize.width,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            height: 600,
            width: 400,
            decoration: const BoxDecoration(
              color: blackTextColor,
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
                      backgroundColor: whiteTextColor,
                    ),
                    child: const Text(
                      'Resume',
                      style: TextStyle(
                        fontSize: 24,
                        color: blackTextColor,
                      ),
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
                      backgroundColor: whiteTextColor,
                    ),
                    child: const Text(
                      'Save game',
                      style: TextStyle(
                        fontSize: 24,
                        color: blackTextColor,
                      ),
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
                      backgroundColor: whiteTextColor,
                    ),
                    child: const Text(
                      'Back to main menu',
                      style: TextStyle(
                        fontSize: 24,
                        color: blackTextColor,
                      ),
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