part of 'game_state_bloc.dart';

class GameState extends Equatable {
  final bool isMute;
  final int coinAmount;
  final SceneName sceneName;
  final int bagCount;
  final int bagSize;
  final int minutes;
  final int daysInGame;
  final bool playerFrozen;

  const GameState({
    required this.isMute,
    required this.coinAmount,
    required this.sceneName,
    required this.bagCount,
    required this.bagSize,
    required this.minutes,
    required this.daysInGame,
    required this.playerFrozen,
  });

  const GameState.empty()
      : this(
          isMute: false,
          coinAmount: 0,
          sceneName: SceneName.menu,
          bagCount: 0,
          bagSize: 1,
          minutes: gameStartTime,
          daysInGame: 0,
          playerFrozen: false,
        );

  GameState copyWith({
    bool? isMute,
    int? coinAmount,
    SceneName? sceneName,
    int? bagCount,
    int? bagSize,
    int? minutes,
    int? daysInGame,
    bool? playerFrozen,
  }) {
    return GameState(
      isMute: isMute ?? this.isMute,
      coinAmount: coinAmount ?? this.coinAmount,
      sceneName: sceneName ?? this.sceneName,
      bagCount: bagCount ?? this.bagCount,
      bagSize: bagSize ?? this.bagSize,
      minutes: minutes ?? this.minutes,
      daysInGame: daysInGame ?? this.daysInGame,
      playerFrozen: playerFrozen ?? this.playerFrozen,
    );
  }

  void resetGameState(BuildContext context) {
    context
        .read<GameStateBloc>()
        .add(const SetGameState(0, 0, 1, gameStartTime, 0));
  }

  void setGameState({
    required BuildContext context,
    required int coinAmount,
    required int bagCount,
    required int bagSize,
    required int minutes,
    required int daysInGame,
  }) {
    context.read<GameStateBloc>().add(
          SetGameState(
            coinAmount,
            bagCount,
            bagSize,
            minutes,
            daysInGame,
          ),
        );
  }

  @override
  List<Object?> get props => [
        coinAmount,
        isMute,
        sceneName,
        bagCount,
        bagSize,
        minutes,
        daysInGame,
        playerFrozen,
      ];
}
