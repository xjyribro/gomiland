part of 'game_state_bloc.dart';

class GameState extends Equatable {
  final int coinAmount;
  final bool isMute;
  final SceneName sceneName;
  final int bagCount;
  final int bagSize;
  final int minutes;
  final bool playerFrozen;
  final int daysInGame;

  const GameState({
    required this.coinAmount,
    required this.isMute,
    required this.sceneName,
    required this.bagCount,
    required this.bagSize,
    required this.minutes,
    required this.playerFrozen,
    required this.daysInGame,
  });

  const GameState.empty()
      : this(
    coinAmount: 0,
    isMute: false,
    sceneName: SceneName.menu,
    bagCount: 0,
    bagSize: 1,
    minutes: gameStartTime,
    playerFrozen: false,
    daysInGame: 0,
  );

  GameState copyWith({
    int? coinAmount,
    bool? isMute,
    SceneName? sceneName,
    int? bagCount,
    int? bagSize,
    int? minutes,
    int? daysInGame,
    bool? playerFrozen,
  }) {
    return GameState(
      coinAmount: coinAmount ?? this.coinAmount,
      isMute: isMute ?? this.isMute,
      sceneName: sceneName ?? this.sceneName,
      bagCount: bagCount ?? this.bagCount,
      bagSize: bagSize ?? this.bagSize,
      minutes: minutes ?? this.minutes,
      playerFrozen: playerFrozen ?? this.playerFrozen,
      daysInGame: daysInGame ?? this.daysInGame,
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
    playerFrozen,
    daysInGame,
  ];
}