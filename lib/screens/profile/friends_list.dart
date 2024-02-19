import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/screens/profile/widgets/friends_row.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/utils/navigation.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({super.key});

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
                    child: Container(),
                  ),
                  const Text(
                    'Friends list',
                    style: TextStyles.mainHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 228,
                    child: MenuButton(
                      onPressed: () => goToAddFriends(context),
                      text: 'Add friends',
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
              const FriendsRow(
                index: 3,
                name: '34rq23rw34trw34t',
                country: '34g45tg45tg54t',
                daysInGame: '23',
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
