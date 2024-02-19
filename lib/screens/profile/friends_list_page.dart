import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/screens/profile/utils.dart';
import 'package:gomiland/screens/profile/widgets/friends_row.dart';
import 'package:gomiland/screens/profile/widgets/players_list.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/utils/navigation.dart';
import 'package:gomiland/utils/other_player.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  Map<String, OtherPlayer> _friendsList = {};

  void _setPlayersList(Map<String, OtherPlayer> playersList) {
    setState(() {
      _friendsList = playersList;
    });
  }

  Future<void> _getRequestInfo() async {
    List<String> friendsList =
        context.read<PlayerStateBloc>().state.friendsList;
    Map<String, OtherPlayer> playersList =
        await getPlayersFromList(friendsList);
    _setPlayersList(playersList);
  }

  @override
  void initState() {
    super.initState();
    _getRequestInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 200,
                    child: MenuButton(
                      onPressed: () => goToAddFriends(context),
                      text: 'Add friends',
                      style: TextStyles.smallMenuTextStyle,
                    ),
                  ),
                  const Text(
                    'Friends list',
                    style: TextStyles.mainHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 200,
                    child: MenuButton(
                      onPressed: () => goToFriendRequestsPage(context),
                      text: 'Friend requests',
                      style: TextStyles.smallMenuTextStyle,
                    ),
                  ),
                ],
              ),
              const SpacerNormal(),
              const FriendsRow(
                name: 'Name',
                country: 'Country',
                daysInGame: 'Days in game',
              ),
              // list of friends
              const SpacerNormal(),
              _friendsList.isNotEmpty
                  ? PlayersList(playersList: _friendsList)
                  : const Text(
                      'No friends :(\nFind friends by pressing "Add friends on the top right"',
                      textAlign: TextAlign.center,
                      style: TextStyles.menuWhiteTextStyle,
                    ),
              const SpacerNormal(),
              MenuButton(
                text: 'Back',
                style: TextStyles.menuRedTextStyle,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SpacerNormal(),
            ],
          ),
        ),
      ),
    );
  }
}
