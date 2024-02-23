import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';

class ScoreRow extends StatelessWidget {
  final int index;
  final String playerName;
  final String plastic;
  final String paper;
  final String glass;
  final String food;
  final String metal;
  final String electronics;
  final TextStyle style;

  const ScoreRow({
    super.key,
    required this.index,
    required this.plastic,
    required this.paper,
    required this.glass,
    required this.food,
    required this.metal,
    required this.electronics,
    required this.playerName,
    this.style = TextStyles.smallMenuTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(index.toString(), style: style),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(playerName, style: style),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Center(child: Text(plastic, style: style)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Center(child: Text(paper, style: style)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Center(child: Text(glass, style: style)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Center(child: Text(food, style: style)),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Center(child: Text(metal, style: style)),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Center(child: Text(electronics, style: style)),
            ),
          ),
        ],
      ),
    );
  }
}
