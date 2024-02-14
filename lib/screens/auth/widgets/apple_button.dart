import 'package:flutter/material.dart';
import 'package:gomiland/assets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppleButton extends StatelessWidget {
  final String text;
  final Function onPress;

  const AppleButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        onPress();
      },
      child: SizedBox(
        width: screen.width * 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  Assets.assets_images_apple_logo_png,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              text,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
