import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/game/data/other_player.dart';
import 'package:gomiland/utils/firestore.dart';

Map<String, OtherPlayer> getPlayersFromSearchResult(
    QuerySnapshot<Object?> players, Map<String, OtherPlayer> friendsList) {
  Map<String, OtherPlayer> playersList = {};
  String playerId = FirebaseAuth.instance.currentUser?.uid ?? '';
  for (var doc in players.docs) {
    String otherPlayerId = doc.id;
    if (doc.data() != null &&
        otherPlayerId != playerId &&
        !friendsList.keys.contains(otherPlayerId)) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      playersList[doc.id] = OtherPlayer.fromJson(data);
    }
  }
  return playersList;
}

Future<Map<String, OtherPlayer>> getPlayersFromList(
    List<String> playerIdList) async {
  Map<String, OtherPlayer> playersList = {};
  for (var playerId in playerIdList) {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await getPlayerById(playerId);
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      playersList[doc.id] = OtherPlayer.fromJson(data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  return playersList;
}

void updateFriendRequestSentList(BuildContext context, String receiverId) {
  List<String> friendRequestsSent =
      context.read<PlayerStateBloc>().state.friendRequestsSent;
  if (!friendRequestsSent.contains(receiverId)) {
    friendRequestsSent.add(receiverId);
  }
  context.read<PlayerStateBloc>().add(SetFriendRequestSent(friendRequestsSent));
}

Future<void> onAcceptFriendRequest(
    BuildContext context, String senderId) async {
  List<String> friendRequestsReceived =
      context.read<PlayerStateBloc>().state.friendRequestsReceived;
  if (friendRequestsReceived.contains(senderId)) {
    friendRequestsReceived.remove(senderId);
  }
  context
      .read<PlayerStateBloc>()
      .add(SetFriendRequestReceived(friendRequestsReceived));

  Map<String, OtherPlayer> friends =
      context.read<PlayerStateBloc>().state.friends;
  if (!friends.keys.contains(senderId)) {
    DocumentSnapshot<Map<String, dynamic>> doc = await getPlayerById(senderId);
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    friends[doc.id] = OtherPlayer.fromJson(data);
  }
  if (context.mounted) {
    context.read<PlayerStateBloc>().add(SetFriends(friends));
  }
}

void updateFriendRequestReceivedList(BuildContext context, String senderId) {
  List<String> friendRequestsReceived =
      context.read<PlayerStateBloc>().state.friendRequestsReceived;
  if (friendRequestsReceived.contains(senderId)) {
    friendRequestsReceived.remove(senderId);
  }
  context
      .read<PlayerStateBloc>()
      .add(SetFriendRequestReceived(friendRequestsReceived));
}
