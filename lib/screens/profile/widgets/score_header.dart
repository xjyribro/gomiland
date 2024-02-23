import 'package:flutter/material.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';

class ScoreHeader extends StatelessWidget {
  final Function changeCriteria;
  final TextStyle style;

  const ScoreHeader({
    super.key,
    required this.changeCriteria,
    this.style = TextStyles.verySmallMenuTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: MenuButton(
                onPressed: () => changeCriteria(RubbishType.plastic),
                text: 'Plastic',
                style: style,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: MenuButton(
                onPressed: () => changeCriteria(RubbishType.paper),
                text: 'Paper',
                style: style,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: MenuButton(
                onPressed: () => changeCriteria(RubbishType.glass),
                text: 'Glass',
                style: style,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: MenuButton(
                onPressed: () => changeCriteria(RubbishType.food),
                text: 'Food',
                style: style,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: MenuButton(
                onPressed: () => changeCriteria(RubbishType.metal),
                text: 'Metal',
                style: style,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: MenuButton(
                onPressed: () => changeCriteria(RubbishType.electronics),
                text: 'Electronics',
                style: style,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
