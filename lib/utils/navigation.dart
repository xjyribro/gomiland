import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/screens/auth/sign_in_page.dart';
import 'package:gomiland/screens/credits.dart';
import 'package:gomiland/screens/main_menu.dart';
import 'package:gomiland/screens/profile/add_friends_page.dart';
import 'package:gomiland/screens/profile/friend_requests_page.dart';
import 'package:gomiland/screens/profile/friends_list_page.dart';
import 'package:gomiland/screens/profile/high_scores.dart';
import 'package:gomiland/screens/profile/profile.dart';

void goToSettings(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ProfilePage(),
    ),
  );
}

void goToCredits(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const CreditsPage(),
    ),
  );
}

void goToSignIn(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SignInPage(),
    ),
  );
}

void pushReplacementToMainMenu(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const MainMenu(),
    ),
  );
}

void pushReplacementToSettings(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const ProfilePage(),
    ),
  );
}

void goToGame({
  required BuildContext context,
  required bool loadFromSave,
}) {
  if (!loadFromSave) {
    context.read<ProgressStateBloc>().state.setProgressForNewGame(context);
    context.read<GameStateBloc>().state.setGameStateForNewGame(context);
    context.read<PlayerStateBloc>().state.setPlayerStateForNewGame(context);
  }
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return GameWidgetWrapper(loadFromSave: loadFromSave);
    }),
  );
}

void goToFriendsList(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const FriendsListPage(),
    ),
  );
}

void goToAddFriends(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AddFriendsPage(),
    ),
  );
}

void goToFriendRequestsPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const FriendRequestsPage(),
    ),
  );
}

void goToHighScores(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const HighScores(),
    ),
  );
}
