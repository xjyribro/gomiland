import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/game/data/other_player.dart';
import 'package:gomiland/screens/profile/widgets/score_row.dart';

class HighScoreTable extends StatelessWidget {
  final List<OtherPlayer> playersList;

  const HighScoreTable({super.key, required this.playersList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: playersList.mapIndexed(
          (i, player) {
            return ScoreRow(
              index: i + 1,
              playerName: player.playerName,
              paper: player.paper.toString(),
              plastic: player.plastic.toString(),
              electronics: player.electronics.toString(),
              metal: player.metal.toString(),
              glass: player.glass.toString(),
              food: player.food.toString(),
            );
          },
        ).toList(),
      ),
    );
  }
}
