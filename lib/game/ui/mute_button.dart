import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';

class MuteButton extends StatelessWidget {
  const MuteButton({super.key});

  void _playBgm(BuildContext context, SceneName sceneName) {
    switch (sceneName) {
      case SceneName.menu:
        Sounds.playMainMenuBgm();
      case SceneName.hood:
        Sounds.playHoodBgm();
        break;
      case SceneName.park:
        Sounds.playParkBgm();
        break;
      case SceneName.room:
        Sounds.playRoomBgm();
        break;
      default:
        Sounds.playMainMenuBgm();
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameStateBloc, GameState>(
      builder: (context, state) => IconButton(
        onPressed: () {
          if (state.isMute) {
            _playBgm(context, state.sceneName);
          } else {
            Sounds.stopBackgroundSound();
          }
          context.read<GameStateBloc>().add(const MuteChanged());
        },
        icon: Icon(
          state.isMute ? Icons.volume_off : Icons.volume_down,
          size: 60,
        ),
      ),
    );
  }
}
