import 'package:flutter/material.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/game/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';

class ConfirmExitRoom extends StatelessWidget {
  final GomilandGame game;

  const ConfirmExitRoom({super.key, required this.game});

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
            height: 300,
            width: 800,
            decoration: const BoxDecoration(
              color: GameColors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(64),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'You have an uncleared piece.\nYou will incur a penalty if you leave now.\nLeave?',
                  textAlign: TextAlign.center,
                  style: TextStyles.menuWhiteTextStyle,
                ),
                const SpacerNormal(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MenuButton(
                      onPressed: () {
                        game.overlays.remove('ConfirmExitRoom');
                        int currentAmount = game.gameStateBloc.state.coinAmount;
                        game.gameStateBloc.add(SetCoinAmount(currentAmount - leaveRoomPenalty));
                        game.goToHoodScene();
                      },
                      text: 'Leave',
                      style: TextStyles.menuGreenTextStyle,
                    ),
                    MenuButton(
                      onPressed: () {
                        game.overlays.remove('ConfirmExitRoom');
                      },
                      text: 'Stay',
                      style: TextStyles.menuRedTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
