import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
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
            height: 400,
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
                const SizedBox(height: 40),
                SizedBox(
                  width: 192,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () {
                      game.resumeEngine();
                      game.overlays.remove('GameMenu');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: whiteTextColor,
                    ),
                    child: const Text(
                      'Play',
                      style: TextStyle(
                        fontSize: 40.0,
                        color: blackTextColor,
                      ),
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