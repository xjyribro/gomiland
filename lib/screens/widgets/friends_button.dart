import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/utils/navigation.dart';

class FriendsButton extends StatelessWidget {
  final bool isLoading;

  const FriendsButton({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerStateBloc, PlayerState>(builder: (context, state) {
      if (state.playerName != '') {
        return Column(
          children: [
            MenuButton(
              text: 'Friends',
              style: TextStyles.menuPurpleTextStyle,
              onPressed: () async {
                if (isLoading) return;
                goToFriendsList(context);
              },
            ),
            const SpacerNormal(),
          ],
        );
      }
      return Container();
    });
  }
}
