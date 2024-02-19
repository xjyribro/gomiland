import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/screens/profile/widgets/friends_row.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/utils/navigation.dart';

class FriendsListPage extends StatelessWidget {
  const FriendsListPage({super.key});

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
                    width: 260,
                    child: MenuButton(
                      onPressed: () => goToAddFriends(context),
                      text: 'Add friends',
                    ),
                  ),
                  const Text(
                    'Friends list',
                    style: TextStyles.mainHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 260,
                    child: MenuButton(
                      onPressed: () => goToAddFriends(context),
                      text: 'Friend requests',
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
