import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';

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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
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
                  const SpacerNormal(),
                  const Text(
                    'Menu',
                    style: TextStyles.mainHeaderTextStyle,
                  ),
                  const SpacerNormal(),
                  MenuButton(
                    onPressed: () {
                      Sounds.resumeBackgroundSound();
                      game.resumeEngine();
                      game.overlays.remove('GameMenu');
                    },
                    text: 'Resume',
                  ),
                  const SpacerNormal(),
                  MenuButton(
                    onPressed: () {
                      Sounds.resumeBackgroundSound();
                      game.resumeEngine();
                      game.overlays.remove('GameMenu');
                    },
                    text: 'Save game',
                  ),
                  const SpacerNormal(),
                  MenuButton(
                    onPressed: () {
                      game.overlays.add('ConfirmExitGame');
                    },
                    text: 'Back to main menu',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
