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

class SetCoinAmount extends GameStateEvent {
  const SetCoinAmount(this.coinAmount);

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

class SetGameState extends GameStateEvent {
  const SetGameState(
    this.sceneName,
    this.coinAmount,
    this.bagCount,
    this.bagSize,
    this.minutes,
    this.daysInGame,
  );

  final SceneName sceneName;
  final int coinAmount;
  final int bagCount;
  final int bagSize;
  final int minutes;
  final int daysInGame;

  @override
  List<Object?> get props => [
        sceneName,
        coinAmount,
        bagCount,
        bagSize,
        minutes,
        daysInGame,
      ];
}
