import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';

class CreditsEntry extends StatelessWidget {
  final String name;
  final String country;
  final bool removeBrackets;

  const CreditsEntry({
    super.key,
    required this.name,
    required this.country,
    this.removeBrackets = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyles.creditsTextStyle,
            textAlign: TextAlign.center,
          ),
          Text(
            removeBrackets ? country : '( $country )',
            style: TextStyles.creditsTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
