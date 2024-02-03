import 'package:flutter/material.dart';

class MainMenuButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double _buttonWidth = 300;

  const MainMenuButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _buttonWidth,
      child: InkWell(
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
            child: Text(text),
          ),
          onPressed: () {
            onPressed();
          },
          // choose input
        ),
      ),
    );
  }
}
