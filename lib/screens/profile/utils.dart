import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/utils/other_player.dart';

Map<String, OtherPlayer> getPlayersFromSearchResult(QuerySnapshot<Object?> players) {
  Map<String, OtherPlayer> playersList = {};
  String playerId = FirebaseAuth.instance.currentUser?.uid ?? '';
  for (var doc in players.docs) {
    if (doc.data() != null && doc.id != playerId) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      playersList[doc.id] = OtherPlayer.fromJson(data);
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