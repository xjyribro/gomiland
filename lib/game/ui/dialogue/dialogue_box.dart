import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/game/controllers/dialogue_controller.dart';
import 'package:gomiland/game/ui/dialogue/button_row.dart';

class DialogueBox extends StatelessWidget {
  const DialogueBox({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTextStyle(
      style: TextStyles.dialogueTextStyle,
      child: BlocBuilder<DialogueBloc, DialogueState>(
        builder: (context, state) => Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                Assets.assets_images_ui_dialogue_box_png,
                width: size.width,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(64),
                child: AnimatedTextKit(
                  key: Key(state.text),
                  animatedTexts: [
                    TyperAnimatedText(
                      state.text,
                      speed: const Duration(milliseconds: textSpeed),
                    ),
                  ],
                  isRepeatingAnimation: false,
                  onFinished: () {
                    // TODO add next button?
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonRow(
                key: Key(state.dialogueOptions.toString()),
                state: state,
                options: state.dialogueOptions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
