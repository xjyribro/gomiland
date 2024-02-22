import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.black,
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: const Center(
          child: Text(
            'Loading...\nPlease wait',
            textAlign: TextAlign.center,
            style: TextStyles.menuWhiteTextStyle,
          ),
        ),
      ),
    );
  }
}
