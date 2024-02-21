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
  final List<int> hoodSpawners;
  final List<int> parkSpawners;
  final bool showControls;

  const GameState({
    required this.isMute,
    required this.coinAmount,
    required this.sceneName,
    required this.bagCount,
    required this.bagSize,
    required this.minutes,
    required this.daysInGame,
    required this.playerFrozen,
    required this.hoodSpawners,
    required this.parkSpawners,
    required this.showControls,
  });

  GameState.empty()
      : this(
          isMute: false,
          coinAmount: 0,
          sceneName: SceneName.menu,
          bagCount: 0,
          bagSize: 0,
          minutes: gameStartTime,
          daysInGame: 0,
          playerFrozen: false,
          hoodSpawners: [],
          parkSpawners: [],
          showControls: kIsWeb ? false : true,
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
    List<int>? hoodSpawners,
    List<int>? parkSpawners,
    bool? showControls,
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
      hoodSpawners: hoodSpawners ?? this.hoodSpawners,
      parkSpawners: parkSpawners ?? this.parkSpawners,
      showControls: showControls ?? this.showControls,
    );
  }

  void resetGameState(BuildContext context) {
    List<int> hoodSpawnList = generateNewHoodRubbishList();
    List<int> parkSpawnList = generateNewParkRubbishList();
    context.read<GameStateBloc>().add(SetGameState(
          coinAmount: 0,
          bagCount: 0,
          bagSize: 0,
          minutes: gameStartTime,
          daysInGame: 0,
          hoodSpawners: hoodSpawnList,
          parkSpawners: parkSpawnList,
        ));
  }

  void setGameState({
    required BuildContext context,
    required int coinAmount,
    required int bagCount,
    required int bagSize,
    required int minutes,
    required int daysInGame,
    required List<int> hoodSpawners,
    required List<int> parkSpawners,
  }) {
    context.read<GameStateBloc>().add(
          SetGameState(
            coinAmount: coinAmount,
            bagCount: bagCount,
            bagSize: bagSize,
            minutes: minutes,
            daysInGame: daysInGame,
            hoodSpawners: hoodSpawners,
            parkSpawners: parkSpawners,
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
        hoodSpawners,
        parkSpawners,
        showControls,
      ];
}
