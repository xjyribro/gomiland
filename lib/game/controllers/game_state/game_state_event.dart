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

class CoinAmountChange extends GameStateEvent {
  const CoinAmountChange(this.coinAmount);

  final int coinAmount;

  @override
  List<Object?> get props => [coinAmount];
}

class MuteChanged extends GameStateEvent {
  const MuteChanged();

  @override
  List<Object?> get props => [];
}

class BagCountChange extends GameStateEvent {
  const BagCountChange(this.bagCount);

  final int bagCount;

  @override
  List<Object?> get props => [bagCount];
}

class BagSizeChange extends GameStateEvent {
  const BagSizeChange(this.bagSize);

  final int bagSize;

  @override
  List<Object?> get props => [bagSize];
}

class AddOneMin extends GameStateEvent {
  const AddOneMin();

  @override
  List<Object?> get props => [];
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
