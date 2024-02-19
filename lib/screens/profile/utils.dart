import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/utils/firestore.dart';
import 'package:gomiland/utils/other_player.dart';

Map<String, OtherPlayer> getPlayersFromSearchResult(QuerySnapshot<Object?> players, List<String> friendsList) {
  Map<String, OtherPlayer> playersList = {};
  String playerId = FirebaseAuth.instance.currentUser?.uid ?? '';
  for (var doc in players.docs) {
    String otherPlayerId = doc.id;
    if (doc.data() != null && otherPlayerId != playerId && !friendsList.contains(otherPlayerId)) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      playersList[doc.id] = OtherPlayer.fromJson(data);
    }
  }
  return playersList;
}

Future<Map<String, OtherPlayer>> getPlayersFromList(List<String> friendRequestsReceived) async {
  Map<String, OtherPlayer> playersList = {};
  for (var playerId in friendRequestsReceived) {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await getPlayerById(playerId);
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
  context
      .read<PlayerStateBloc>()
      .add(SetFriendRequestSent(friendRequestsSent));
}

void onAcceptFriendRequest(BuildContext context, String senderId) {
  List<String> friendsList =
      context.read<PlayerStateBloc>().state.friendsList;
  if (!friendsList.contains(senderId)) {
    friendsList.add(senderId);
  }
  context
      .read<PlayerStateBloc>()
      .add(SetFriendsList(friendsList));

  List<String> friendRequestsReceived =
      context.read<PlayerStateBloc>().state.friendRequestsReceived;
  if (friendRequestsReceived.contains(senderId)) {
    friendRequestsReceived.remove(senderId);
  }
  context
      .read<PlayerStateBloc>()
      .add(SetFriendRequestReceived(friendRequestsReceived));
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