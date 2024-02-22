import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/game/scenes/scene_name.dart';
import 'package:gomiland/screens/profile/utils.dart';

Future<void> savePlayerInfo({
  required String playerId,
  required String playerName,
  required String country,
  required bool isMale,
}) async {
  DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
      .collection(Strings.playersCollection)
      .doc(playerId)
      .get();
  if (doc.exists) {
    await doc.reference.update({
      Strings.playerName: playerName,
      Strings.country: country,
      Strings.isMale: isMale,
    });
  } else {
    await doc.reference.set({
      Strings.playerName: playerName,
      Strings.country: country,
      Strings.isMale: isMale,
    });
  }
}

Future<bool> saveGameState({
  required BuildContext context,
  required String playerId,
}) async {
  try {
    GameState gameState = context.read<GameStateBloc>().state;
    PlayerState playerState = context.read<PlayerStateBloc>().state;
    ProgressState progressState = context.read<ProgressStateBloc>().state;
    await FirebaseFirestore.instance
        .collection(Strings.playersCollection)
        .doc(playerId)
        .update({
      Strings.hasSave: true,
      Strings.playerSpeed: playerState.playerSpeed,
      Strings.playerXPosit: playerState.playerPosition.x,
      Strings.playerYPosit: playerState.playerPosition.y,
      Strings.playerXDir: playerState.playerDirection.x,
      Strings.playerYDir: playerState.playerDirection.y,
      Strings.savedLocation: gameState.sceneName.string,
      Strings.coinAmount: gameState.coinAmount,
      Strings.bagCount: gameState.bagCount,
      Strings.bagSize: gameState.bagSize,
      Strings.minutes: gameState.minutes,
      Strings.daysInGame: gameState.daysInGame,
      Strings.hoodSpawners: gameState.hoodSpawners,
      Strings.parkSpawners: gameState.parkSpawners,
      Strings.plastic: progressState.plastic,
      Strings.paper: progressState.paper,
      Strings.metal: progressState.metal,
      Strings.electronics: progressState.electronics,
      Strings.glass: progressState.glass,
      Strings.food: progressState.food,
      Strings.wrong: progressState.wrong,
      Strings.manuka: progressState.manuka,
      Strings.qianBi: progressState.qianBi,
      Strings.risa: progressState.risa,
      Strings.stark: progressState.stark,
      Strings.asimov: progressState.asimov,
      Strings.moon: progressState.moon,
      Strings.neighbour: progressState.neighbour,
    });
    return true;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
}

Future<bool> refreshFriends({
  required String playerId,
  required BuildContext context,
}) async {
  return await getPlayerById(playerId).then((doc) {
    if (doc.data() == null) {
      return false;
    } else {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<String> friendsList = data[Strings.friendsList] != null
          ? List.from(data[Strings.friendsList])
          : [];
      List<String> friendRequestsSent = data[Strings.friendRequestsSent] != null
          ? List.from(data[Strings.friendRequestsSent])
          : [];
      List<String> friendRequestsReceived =
          data[Strings.friendRequestsReceived] != null
              ? List.from(data[Strings.friendRequestsReceived])
              : [];
      context.read<PlayerStateBloc>().state.setPlayerState(
            context: context,
            friendsList: friendsList,
            friendRequestsSent: friendRequestsSent,
            friendRequestsReceived: friendRequestsReceived,
          );
      return true;
    }
  });
}

Future<bool> loadSaved({
  required String playerId,
  required BuildContext context,
}) async {
  return await getPlayerById(playerId).then((doc) async {
    if (doc.data() == null) {
      return false;
    } else {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      setGame(context, data);
      setProgress(context, data);
      await setPlayer(context, data);
      return true;
    }
  });
}

Future<void> setPlayer(BuildContext context, Map<String, dynamic> data) async {
  String savedLocation = data[Strings.savedLocation] ?? SceneName.hood.string;
  List<String> friendsList = data[Strings.friendsList] != null
      ? List.from(data[Strings.friendsList])
      : [];
  List<String> friendRequestsSent = data[Strings.friendRequestsSent] != null
      ? List.from(data[Strings.friendRequestsSent])
      : [];
  List<String> friendRequestsReceived =
      data[Strings.friendRequestsReceived] != null
          ? List.from(data[Strings.friendRequestsReceived])
          : [];
  await getPlayersFromList(friendsList).then((friends) {
    context.read<PlayerStateBloc>().state.setPlayerState(
          context: context,
          playerName: data[Strings.playerName] ?? '',
          country: data[Strings.country] ?? '',
          isMale: data[Strings.isMale] ?? true,
          playerSpeed: data[Strings.playerSpeed] ?? 2,
          playerXPosit: data[Strings.playerXPosit],
          playerYPosit: data[Strings.playerYPosit],
          playerXDir: data[Strings.playerXDir],
          playerYDir: data[Strings.playerYDir],
          savedLocation: savedLocation.sceneName,
          friendsList: friendsList,
          friendRequestsSent: friendRequestsSent,
          friendRequestsReceived: friendRequestsReceived,
          friends: friends,
        );
  });
}

void setGame(BuildContext context, Map<String, dynamic> data) {
  List<int> hoodSpawners = data[Strings.hoodSpawners]?.cast<int>() ?? [];
  List<int> parkSpawners = data[Strings.parkSpawners]?.cast<int>() ?? [];
  context.read<GameStateBloc>().state.setGameState(
        context: context,
        coinAmount: data[Strings.coinAmount] ?? 0,
        bagCount: data[Strings.bagCount] ?? 0,
        bagSize: data[Strings.bagSize] ?? 1,
        minutes: data[Strings.minutes] ?? gameStartTime,
        daysInGame: data[Strings.daysInGame] ?? 0,
        hoodSpawners: hoodSpawners,
        parkSpawners: parkSpawners,
      );
}

void setProgress(BuildContext context, Map<String, dynamic> data) {
  context.read<ProgressStateBloc>().state.setProgress(
        context: context,
        hasSave: data[Strings.hasSave] ?? false,
        neighbour: data[Strings.neighbour] ?? 'intro',
        plastic: data[Strings.plastic] ?? 0,
        paper: data[Strings.paper] ?? 0,
        metal: data[Strings.metal] ?? 0,
        electronics: data[Strings.electronics] ?? 0,
        glass: data[Strings.glass] ?? 0,
        food: data[Strings.food] ?? 0,
        wrong: data[Strings.wrong] ?? 0,
        manuka: data[Strings.manuka] ?? -1,
        qianBi: data[Strings.qianBi] ?? -1,
        risa: data[Strings.risa] ?? -1,
        stark: data[Strings.stark] ?? -1,
        asimov: data[Strings.asimov] ?? -1,
        moon: data[Strings.moon] ?? -1,
      );
}

Future<DocumentSnapshot<Map<String, dynamic>>> getPlayerById(
    String playerId) async {
  return await FirebaseFirestore.instance
      .collection(Strings.playersCollection)
      .doc(playerId)
      .get();
}

Future<QuerySnapshot<Object?>?> getPlayers({
  String? playerName,
  String? country,
  bool? isMale,
}) async {
  try {
    Query collection =
        FirebaseFirestore.instance.collection(Strings.playersCollection);
    if (playerName != null) {
      collection = collection.where(Strings.playerName, isEqualTo: playerName);
    }
    if (country != null) {
      collection = collection.where(Strings.country, isEqualTo: country);
    }
    if (isMale != null) {
      collection = collection.where(Strings.isMale, isEqualTo: isMale);
    }
    return await collection.get();
  } catch (e) {
    return null;
  }
}

Future<bool> sendFriendRequest({
  required String senderId,
  required String receiverId,
}) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> receiverDoc = await FirebaseFirestore
        .instance
        .collection(Strings.playersCollection)
        .doc(receiverId)
        .get();
    if (receiverDoc.exists) {
      List<String> friendRequestsReceived =
          receiverDoc.data()?[Strings.friendRequestsReceived] != null
              ? List.from(receiverDoc.data()![Strings.friendRequestsReceived])
              : [];
      if (!friendRequestsReceived.contains(senderId)) {
        friendRequestsReceived.add(senderId);
      }
      await receiverDoc.reference.update({
        Strings.friendRequestsReceived: friendRequestsReceived,
      });
    }
    DocumentSnapshot<Map<String, dynamic>> senderDoc = await FirebaseFirestore
        .instance
        .collection(Strings.playersCollection)
        .doc(senderId)
        .get();
    if (senderDoc.exists) {
      List<String> friendRequestsSent =
          receiverDoc.data()?[Strings.friendRequestsSent] != null
              ? List.from(receiverDoc.data()![Strings.friendRequestsSent])
              : [];
      if (!friendRequestsSent.contains(receiverId)) {
        friendRequestsSent.add(receiverId);
      }
      await senderDoc.reference.update({
        Strings.friendRequestsSent: friendRequestsSent,
      });
    }
    return true;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
}

Future<bool> acceptFriendRequest({
  required String senderId,
  required String receiverId,
}) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> receiverDoc = await FirebaseFirestore
        .instance
        .collection(Strings.playersCollection)
        .doc(receiverId)
        .get();
    if (receiverDoc.exists) {
      List<String> friendRequestsReceived =
          receiverDoc.data()?[Strings.friendRequestsReceived] != null
              ? List.from(receiverDoc.data()![Strings.friendRequestsReceived])
              : [];
      friendRequestsReceived.remove(senderId);

      List<String> friendsList =
          receiverDoc.data()?[Strings.friendsList] != null
              ? List.from(receiverDoc.data()![Strings.friendsList])
              : [];
      friendsList.add(senderId);
      await receiverDoc.reference.update({
        Strings.friendsList: friendsList,
        Strings.friendRequestsReceived: friendRequestsReceived,
      });
    }

    DocumentSnapshot<Map<String, dynamic>> senderDoc = await FirebaseFirestore
        .instance
        .collection(Strings.playersCollection)
        .doc(senderId)
        .get();
    if (senderDoc.exists) {
      List<String> friendRequestsSent =
          receiverDoc.data()?[Strings.friendRequestsSent] != null
              ? List.from(receiverDoc.data()![Strings.friendRequestsSent])
              : [];
      friendRequestsSent.remove(receiverId);
      List<String> friendsList =
          receiverDoc.data()?[Strings.friendsList] != null
              ? List.from(receiverDoc.data()![Strings.friendsList])
              : [];
      friendsList.add(receiverId);
      await senderDoc.reference.update({
        Strings.friendsList: friendsList,
        Strings.friendRequestsSent: friendRequestsSent,
      });
    }
    return true;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
}
