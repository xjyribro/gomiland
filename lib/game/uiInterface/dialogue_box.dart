import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';

class DialogueBox extends StatelessWidget {
  final String text;

  const DialogueBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTextStyle(
      style: const TextStyle(
        fontFamily: 'minecraft',
        fontSize: 32,
      ),
      child: Stack(
        children: [
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Image.asset(
              Assets.assets_images_ui_dialogue_box_png,
              width: size.width,
            ),
          ),
          Positioned(
            bottom: 100,
            left: 150,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    text,
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: false,
                onFinished: () {
                  // fill
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
