import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/screens/profile/widgets/search_players.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';

class AddFriendsPage extends StatelessWidget {
  const AddFriendsPage({super.key});

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
              MenuButton(
                text: 'Back',
                style: TextStyles.menuRedTextStyle,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SpacerNormal(),
              const SearchPlayers(),
              const SpacerNormal(),
            ],
          ),
        ),
      ),
    );
  }
}
