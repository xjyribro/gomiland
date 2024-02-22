import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/screens/profile/utils.dart';
import 'package:gomiland/screens/profile/widgets/players_list.dart';
import 'package:gomiland/screens/profile/widgets/request_friend_row.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/game/data/other_player.dart';

class FriendRequestsPage extends StatefulWidget {
  const FriendRequestsPage({super.key});

  @override
  State<FriendRequestsPage> createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends State<FriendRequestsPage> {
  Map<String, OtherPlayer> _playersList = {};

  void _setPlayersList(Map<String, OtherPlayer> playersList) {
    setState(() {
      _playersList = playersList;
    });
  }

  Future<void> _getRequestInfo() async {
    List<String> friendRequestsReceived =
        context.read<PlayerStateBloc>().state.friendRequestsReceived;
    Map<String, OtherPlayer> playersList =
        await getPlayersFromList(friendRequestsReceived);
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
              const Text(
                'Friend requests',
                style: TextStyles.mainHeaderTextStyle,
              ),
              const SpacerNormal(),
              const RequestFriendRow(
                name: 'Name',
                country: 'Country',
                daysInGame: 'Days in game',
                isSendRequest: false,
              ),
              const SpacerNormal(),
              _playersList.isNotEmpty
                  ? PlayersList(
                      playersList: _playersList,
                      isSendRequest: false,
                    )
                  : const Text('No requests to show',
                      style: TextStyles.mainHeaderTextStyle,
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
