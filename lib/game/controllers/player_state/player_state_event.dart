part of 'player_state_bloc.dart';

abstract class PlayerStatesEvent extends Equatable {
  const PlayerStatesEvent();
}

class PlayerPositionChange extends PlayerStatesEvent {
  const PlayerPositionChange(this.playerPosition);

  final Vector2 playerPosition;

  @override
  List<Object?> get props => [playerPosition];
}

class PlayerDirectionChange extends PlayerStatesEvent {
  const PlayerDirectionChange(this.playerDirection);

  final Vector2 playerDirection;

  @override
  List<Object?> get props => [playerDirection];
}

class PlayerHitboxChange extends PlayerStatesEvent {
  const PlayerHitboxChange(this.playerHitbox);

  final RectangleHitbox playerHitbox;

  @override
  List<Object?> get props => [playerHitbox];
}

class ShowControls extends PlayerStatesEvent {
  const ShowControls(this.showControls);

  final bool showControls;

  @override
  List<Object?> get props => [showControls];
}

class SetIsMale extends PlayerStatesEvent {
  const SetIsMale(this.isMale);

  final bool isMale;

  @override
  List<Object?> get props => [isMale];
}

class SetPlayerName extends PlayerStatesEvent {
  const SetPlayerName(this.playerName);

  final String playerName;

  @override
  List<Object?> get props => [playerName];
}

class SetCountry extends PlayerStatesEvent {
  const SetCountry(this.country);

  final String country;

  @override
  List<Object?> get props => [country];
}