import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';

class DialogueButton extends StatelessWidget {
  final String imageAssetPath;
  final String text;
  final Function onTap;

  const DialogueButton({
    super.key,
    required this.imageAssetPath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Image.asset(
              imageAssetPath,
              width: 96,
              height: 64,
            ),
          ),
          SizedBox(
            width: 96,
            height: 64,
            child: GestureDetector(
              onTap: () {
                onTap();
              },
              child: Center(
                child: Text(
                  text,
                  style: TextStyles.dialogueButtonsTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
