import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/screens/profile/widgets/request_friend_row.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';

class AddFriends extends StatelessWidget {
  const AddFriends({super.key});

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
                'Search players',
                style: TextStyles.mainHeaderTextStyle,
              ),
              const SpacerNormal(),
              const RequestFriendRow(
                name: 'Name',
                country: 'Country',
                daysInGame: 'Days in game',
                playerId: '',
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
