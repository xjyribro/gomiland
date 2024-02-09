import 'package:flutter/material.dart';

class MainMenuButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double buttonWidth;
  final TextStyle? style;

  const MainMenuButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonWidth = 300,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          splashFactory: InkRipple.splashFactory,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          minimumSize: const Size(100, 40), //////// HERE
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(text, style: style,),
        ),
        onPressed: () {
          onPressed();
        },
        // choose input
      ),
    );
  }
}
