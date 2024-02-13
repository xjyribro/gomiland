part of 'game_state_bloc.dart';

class GameState extends Equatable {
  final int coinAmount;
  final bool isMute;
  final SceneName sceneName;
  final int bagCount;
  final int bagSize;
  final int minutes;
  final bool playerFrozen;
  final bool isMale;

  const GameState({
    required this.coinAmount,
    required this.isMute,
    required this.sceneName,
    required this.bagCount,
    required this.bagSize,
    required this.minutes,
    required this.playerFrozen,
    required this.isMale,
  });

  const GameState.empty()
      : this(
    coinAmount: 0,
    isMute: false,
    sceneName: SceneName.menu,
    bagCount: 1,
    bagSize: 1,
    minutes: gameStartTime,
    playerFrozen: false,
    isMale: true,
  );

  GameState copyWith({
    int? coinAmount,
    bool? isMute,
    SceneName? sceneName,
    int? bagCount,
    int? bagSize,
    int? minutes,
    bool? playerFrozen,
    bool? isMale,
  }) {
    return GameState(
      coinAmount: coinAmount ?? this.coinAmount,
      isMute: isMute ?? this.isMute,
      sceneName: sceneName ?? this.sceneName,
      bagCount: bagCount ?? this.bagCount,
      bagSize: bagSize ?? this.bagSize,
      minutes: minutes ?? this.minutes,
      playerFrozen: playerFrozen ?? this.playerFrozen,
      isMale: isMale ?? this.isMale,
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
  ];
}