import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double buttonWidth;
  final bool? isLoading;
  final TextStyle? style;

  const MenuButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonWidth = 300,
    this.isLoading,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final bool showIsLoading = isLoading != null ? isLoading! : false;
    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          splashFactory: InkRipple.splashFactory,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          minimumSize: const Size(100, 40),
        ),
        child: showIsLoading
            ? const Padding(
                padding: EdgeInsets.all(4),
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  text,
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
        onPressed: () {
          onPressed();
        },
        // choose input
      ),
    );
  }
}
