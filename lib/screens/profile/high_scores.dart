import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/game/data/other_player.dart';
import 'package:gomiland/screens/profile/widgets/high_score_table.dart';
import 'package:gomiland/screens/profile/widgets/score_row.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';

class HighScores extends StatefulWidget {
  const HighScores({super.key});

  @override
  State<HighScores> createState() => _HighScoresState();
}

class _HighScoresState extends State<HighScores> {
  bool _isGlobal = false;
  List<OtherPlayer> _playersList = [];

  void _switchList() {
    setState(() {
      _isGlobal = !_isGlobal;
    });
    _getSortedList();
  }

  void _getSortedList() {
    List<OtherPlayer> playersList = [];
    if (_isGlobal) {
      // call firebase
    } else {
      Map<String, OtherPlayer> friends = context.read<PlayerStateBloc>().state.friends;

    }
    setState(() {
      _playersList = playersList;
    });
  }


  @override
  void initState() {
    super.initState();
    _getSortedList();
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
                      text: 'Back',
                      style: TextStyles.menuRedTextStyle,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text(
                    '${_isGlobal ? 'Global' : 'Friends'} high scores',
                    style: TextStyles.mainHeaderTextStyle,
                  ),
                  SizedBox(
                    width: 200,
                    child: MenuButton(
                      onPressed: _switchList,
                      text: 'Switch to ${_isGlobal ? 'Friends' : 'Global'}',
                      style: TextStyles.smallMenuTextStyle,
                    ),
                  ),
                ],
              ),
              const SpacerNormal(),
              const ScoreRow(
                playerName: 'Player Name',
                plastic: 'Plastic',
                paper: 'Paper',
                glass: 'Glass',
                food: 'Food',
                metal: 'Metal',
                electronics: 'Electronics',
                style: TextStyles.creditsTextStyle,
              ),
              const SpacerNormal(),
              HighScoreTable(playersList: _playersList),
              const SpacerNormal(),
            ],
          ),
        ),
      ),
    );
  }
}
