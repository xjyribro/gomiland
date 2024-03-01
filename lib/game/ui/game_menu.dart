import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/audio_controller.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/scene_name.dart';
import 'package:gomiland/screens/popups/popups.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/utils/firestore.dart';

class GameMenu extends StatefulWidget {
  final GomilandGame game;

  const GameMenu({super.key, required this.game});

  @override
  State<GameMenu> createState() => _GameMenuState();
}

class _GameMenuState extends State<GameMenu> {
  bool _isLoading = false;

  void _setIsLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _resume() {
    Sounds.resumeBackgroundSound();
    widget.game.resumeEngine();
    widget.game.overlays.remove('GameMenu');
  }

  Future<void> _saveGame(User user) async {
    _setIsLoading(true);
    SceneName sceneName = widget.game.gameStateBloc.state.sceneName;
    if (sceneName == SceneName.room) {
      Popups.showMessage(
        context: context,
        title: 'Exit room to save game',
        subTitle: '',
      );
      _setIsLoading(false);
    } else {
      await Popups.showSaveOverrideWarning(
          context: context,
          onAccept: () async {
            await saveGameState(playerId: user.uid, context: context)
                .then((success) async {
              await Popups.showMessage(
                context: context,
                title:
                    success ? 'Saving game successful' : 'Saving game failed',
                subTitle: success
                    ? ''
                    : 'Please check internet connection and try again',
              );
            });
          });
      _setIsLoading(false);
    }
  }

  void _returnToMainMenu() {
    if (_isLoading) return;
    widget.game.overlays.add('ConfirmExitGame');
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;
    return Material(
      color: Colors.transparent,
      child: Container(
        color: GameColors.whiteTranslucent,
        width: screenSize.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 400,
              width: 400,
              decoration: ContainerStyles.gameMenuStyle,
              child: Column(
                children: [
                  const SpacerNormal(),
                  const Text(
                    'Menu',
                    style: TextStyles.mainHeaderTextStyle,
                  ),
                  const SpacerNormal(),
                  MenuButton(
                    onPressed: _resume,
                    text: 'Resume',
                  ),
                  const SpacerNormal(),
                  if (user != null) ...[
                    MenuButton(
                      onPressed: () {
                        _saveGame(user);
                      },
                      text: 'Save game',
                      isLoading: _isLoading,
                    ),
                    const SpacerNormal(),
                  ],
                  MenuButton(
                    onPressed: _returnToMainMenu,
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
