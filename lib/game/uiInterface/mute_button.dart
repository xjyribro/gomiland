import 'package:flutter/material.dart';
import 'package:gomiland/contants.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/providers/game_state.dart';
import 'package:gomiland/providers/prefs.dart';
import 'package:provider/provider.dart';

class MuteButton extends StatelessWidget {
  const MuteButton({super.key});

  void _playBgm(BuildContext context) {
    SceneName sceneName =
        Provider.of<GameState>(context, listen: false).sceneName;
    switch (sceneName) {
      case SceneName.MENU:
        Sounds.playMainMenuBgm();
      case SceneName.HOOD:
        Sounds.playHoodBgm();
        break;
      case SceneName.PARK:
        Sounds.playParkBgm();
        break;
      case SceneName.ROOM:
        Sounds.playMainMenuBgm();
        break;
      default:
        Sounds.playMainMenuBgm();
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMuted = Provider.of<Prefs>(context, listen: true).isMuted;
    return IconButton(
      onPressed: () {
        if (isMuted) {
          _playBgm(context);
        } else {
          Sounds.stopBackgroundSound();
        }
        Provider.of<Prefs>(context, listen: false).setIsMuted(!isMuted);
      },
      icon: Icon(
        isMuted ? Icons.volume_off : Icons.volume_down,
        size: 60,
      ),
    );
  }
}
