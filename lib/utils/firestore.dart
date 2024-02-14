import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/controllers/player_state/player_state_bloc.dart';

Future<void> savePlayerInfo({
  required String playerId,
  required String playerName,
  required String country,
  required bool isMale,
}) async {
  await FirebaseFirestore.instance.collection('players').doc(playerId).set({
    Strings.playerName: playerName,
    Strings.country: country,
    Strings.isMale: isMale,
  });
}

Future<void> saveGameState() async {}

Future<void> loadPlayerInfo({
  required String playerId,
  required BuildContext context,
}) async {
  await FirebaseFirestore.instance
      .collection(Strings.playersCollection)
      .doc(playerId)
      .get()
      .then((doc) {

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    context.read<PlayerStateBloc>().state.setPlayerBloc(
          context: context,
          playerName: data[Strings.playerName] ?? '',
          country: data[Strings.country] ?? '',
          isMale: data[Strings.isMale] ?? true,
        );
  });
}

Future<void> loadGameState() async {}
