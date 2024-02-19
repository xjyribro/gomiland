import 'package:flutter/material.dart';
import 'package:gomiland/screens/profile/widgets/request_friend_row.dart';
import 'package:gomiland/utils/other_player.dart';

class PlayersList extends StatelessWidget {
  final Map<String, OtherPlayer> playersList;

  const PlayersList({super.key, required this.playersList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: playersList.entries.map(
              (player) => RequestFriendRow(
                name: player.value.playerName,
                country: player.value.country,
                daysInGame: player.value.daysInGame.toString(),
                otherPlayerId: player.key,
                isSendRequest: true,
              ),
            )
            .toList(),
      ),
    );
  }
}
