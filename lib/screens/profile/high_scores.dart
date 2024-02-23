import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/styles.dart';
import 'package:gomiland/controllers/game_state/game_state_bloc.dart';
import 'package:gomiland/controllers/player_state/player_state_bloc.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/game/data/other_player.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
import 'package:gomiland/screens/profile/widgets/high_score_table.dart';
import 'package:gomiland/screens/profile/widgets/score_row.dart';
import 'package:gomiland/screens/widgets/menu_button.dart';
import 'package:gomiland/screens/widgets/spacer.dart';
import 'package:gomiland/utils/firestore.dart';

class HighScores extends StatefulWidget {
  const HighScores({super.key});

  @override
  State<HighScores> createState() => _HighScoresState();
}

class _HighScoresState extends State<HighScores> {
  bool _isGlobal = false;
  RubbishType _criteria = RubbishType.plastic;
  List<OtherPlayer> _playersList = [];

  void _changeCriteria(RubbishType type) {
    setState(() {
      _criteria = type;
    });
  }

  void _switchList() {
    setState(() {
      _isGlobal = !_isGlobal;
    });
    _getSortedList();
  }

  Future<void> _getSortedList() async {
    List<OtherPlayer> playersList = [];
    if (_isGlobal) {
      QuerySnapshot<Object?>? result = await getHiScorePlayers(_criteria);
      if (result != null) {
        List<OtherPlayer> tempPlayersList = [];
        for (var doc in result.docs) {
          if (doc.data() != null ) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            OtherPlayer player = OtherPlayer.fromJson(data);
            tempPlayersList.add(player);
          }
        }
        playersList = sortPlayersList(tempPlayersList);
      }
    } else {
      Map<String, OtherPlayer> playersMap =
          context.read<PlayerStateBloc>().state.friends;
      String playerId = FirebaseAuth.instance.currentUser?.uid ?? '';
      ProgressState progressState = context.read<ProgressStateBloc>().state;
      PlayerState playerState = context.read<PlayerStateBloc>().state;
      GameState gameState = context.read<GameStateBloc>().state;
      playersMap[playerId] = OtherPlayer.fromBlocState(
        progressState: progressState,
        playerState: playerState,
        gameState: gameState,
      );
      playersList = sortPlayersList(playersMap.values.toList());
    }
    setState(() {
      _playersList = playersList;
    });
  }

  List<OtherPlayer> sortPlayersList(List<OtherPlayer> players) {
    if (_criteria == RubbishType.plastic) {
      players.sort((a, b) => b.plastic.compareTo(a.plastic));
    }
    if (_criteria == RubbishType.glass) {
      players.sort((a, b) => b.glass.compareTo(a.glass));
    }
    if (_criteria == RubbishType.metal) {
      players.sort((a, b) => b.metal.compareTo(a.metal));
    }
    if (_criteria == RubbishType.food) {
      players.sort((a, b) => b.food.compareTo(a.food));
    }
    if (_criteria == RubbishType.electronics) {
      players.sort((a, b) => b.electronics.compareTo(a.electronics));
    }
    if (_criteria == RubbishType.paper) {
      players.sort((a, b) => b.paper.compareTo(a.paper));
    }
    return players;
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
                    '${_isGlobal ? 'Global' : 'Friend'} scores',
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
