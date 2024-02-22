import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/screens/profile/widgets/friends_row.dart';
import 'package:gomiland/screens/profile/widgets/request_friend_row.dart';
import 'package:gomiland/game/data/other_player.dart';

class PlayersList extends StatelessWidget {
  final bool? isSendRequest;
  final Map<String, OtherPlayer> playersList;

  const PlayersList({
    super.key,
    required this.playersList,
    this.isSendRequest,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: playersList.entries.mapIndexed(
          (i, player) {
            if (isSendRequest == null) {
              return FriendsRow(
                index: i + 1,
                name: player.value.playerName,
                country: player.value.country,
                daysInGame: player.value.daysInGame.toString(),
              );
            }
            return RequestFriendRow(
              index: i + 1,
              name: player.value.playerName,
              country: player.value.country,
              daysInGame: player.value.daysInGame.toString(),
              otherPlayerId: player.key,
              isSendRequest: isSendRequest,
            );
          },
        ).toList(),
      ),
    );
  }
}
