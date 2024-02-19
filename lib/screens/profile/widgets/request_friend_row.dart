import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';

class RequestFriendRow extends StatelessWidget {
  final int? index;
  final String name;
  final String country;
  final String daysInGame;
  final String? playerId;

  const RequestFriendRow({
    super.key,
    this.index,
    required this.name,
    required this.country,
    required this.daysInGame,
    required this.playerId,
  });

  void _sendFriendRequest() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              index != null ? index.toString() : '',
              style: TextStyles.menuWhiteTextStyle,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              name,
              style: TextStyles.menuWhiteTextStyle,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              country,
              style: TextStyles.menuWhiteTextStyle,
            ),
          ),
          Expanded(
            flex: 3,
            child: playerId != null
                ? MenuButton(
                    onPressed: _sendFriendRequest,
                    text: 'Send friend request',
                    style: TextStyles.sendFriendRequestTextStyle,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
