import 'package:flutter/material.dart';

class ScoreRow extends StatelessWidget {
  final int? index;
  final String playerName;
  final String plastic;
  final String paper;
  final String glass;
  final String food;
  final String metal;
  final String electronics;

  const ScoreRow({
    super.key,
    this.index,
    required this.plastic,
    required this.paper,
    required this.glass,
    required this.food,
    required this.metal,
    required this.electronics, required this.playerName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(index != null ? index.toString() : ''),
          Text(playerName),
          Text(plastic),
          Text(paper),
          Text(glass),
          Text(food),
          Text(metal),
          Text(electronics),
        ],
      ),
    );
  }
}
