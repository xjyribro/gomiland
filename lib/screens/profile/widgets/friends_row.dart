import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';

class FriendsRow extends StatelessWidget {
  final int? index;
  final String name;
  final String country;
  final String daysInGame;

  const FriendsRow({
    super.key,
    this.index,
    required this.name,
    required this.country,
    required this.daysInGame,
  });

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
            flex: 6,
            child: Text(
              name,
              style: TextStyles.menuWhiteTextStyle,
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              country,
              style: TextStyles.menuWhiteTextStyle,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              daysInGame,
              style: TextStyles.menuWhiteTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
