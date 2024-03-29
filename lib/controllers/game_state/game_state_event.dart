part of 'game_state_bloc.dart';

abstract class GameStateEvent extends Equatable {
  const GameStateEvent();
}

class SceneChanged extends GameStateEvent {
  const SceneChanged(this.sceneName);

  final SceneName sceneName;

  @override
  List<Object?> get props => [sceneName];
}

class ChangeCoinAmount extends GameStateEvent {
  const ChangeCoinAmount(this.coinAmount);

  final int coinAmount;

  @override
  List<Object?> get props => [coinAmount];
}

class MuteChanged extends GameStateEvent {
  const MuteChanged();

  @override
  List<Object?> get props => [];
}

class SetBagCount extends GameStateEvent {
  const SetBagCount(this.bagCount);

  final int bagCount;

  @override
  List<Object?> get props => [bagCount];
}

class AddOneToBag extends GameStateEvent {
  const AddOneToBag();

  @override
  List<Object?> get props => [];
}

class SetBagSize extends GameStateEvent {
  const SetBagSize(this.bagSize);

  final int bagSize;

  @override
  List<Object?> get props => [bagSize];
}

class AddOneMin extends GameStateEvent {
  const AddOneMin();

  @override
  List<Object?> get props => [];
}

class SetMinsInGame extends GameStateEvent {
  const SetMinsInGame(this.minutes);

  final int minutes;

  @override
  List<Object?> get props => [minutes];
}

class SetHoodSpawnersList extends GameStateEvent {
  const SetHoodSpawnersList(this.spawners);

  final List<int> spawners;

  @override
  List<Object?> get props => [spawners];
}

class SetParkSpawnersList extends GameStateEvent {
  const SetParkSpawnersList(this.spawners);

  final List<int> spawners;

  @override
  List<Object?> get props => [spawners];
}

class PlayerFrozen extends GameStateEvent {
  const PlayerFrozen(this.playerFrozen);

  final bool playerFrozen;

  @override
  List<Object?> get props => [playerFrozen];
}

class IncreaseDays extends GameStateEvent {
  const IncreaseDays();

  @override
  List<Object?> get props => [];
}

class SetDaysInGame extends GameStateEvent {
  const SetDaysInGame(this.days);

  final int days;

  @override
  List<Object?> get props => [days];
}

class ShowControls extends GameStateEvent {
  const ShowControls(this.showControls);

  final bool showControls;

  @override
  List<Object?> get props => [showControls];
}

class SetGameState extends GameStateEvent {
  const SetGameState({
   required this.coinAmount,
   required this.bagCount,
   required this.bagSize,
   required this.minutes,
   required this.daysInGame,
   required this.hoodSpawners,
   required this.parkSpawners,
  });

  final int coinAmount;
  final int bagCount;
  final int bagSize;
  final int minutes;
  final int daysInGame;
  final List<int> hoodSpawners;
  final List<int> parkSpawners;

  @override
  List<Object?> get props => [
        coinAmount,
        bagCount,
        bagSize,
        minutes,
        daysInGame,
        hoodSpawners,
        parkSpawners,
      ];
}
