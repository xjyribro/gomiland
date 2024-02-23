part of 'player_state_bloc.dart';

abstract class PlayerStatesEvent extends Equatable {
  const PlayerStatesEvent();
}

class SetPlayerPosition extends PlayerStatesEvent {
  const SetPlayerPosition(this.playerPosition);

  final Vector2 playerPosition;

  @override
  List<Object?> get props => [playerPosition];
}

class SetPlayerDirection extends PlayerStatesEvent {
  const SetPlayerDirection(this.playerDirection);

  final Vector2 playerDirection;

  @override
  List<Object?> get props => [playerDirection];
}

class SetPlayerSpeed extends PlayerStatesEvent {
  const SetPlayerSpeed(this.playerSpeed);

  final int playerSpeed;

  @override
  List<Object?> get props => [playerSpeed];
}

class SetSavedLocation extends PlayerStatesEvent {
  const SetSavedLocation(this.playerLocation);

  final SceneName playerLocation;

  @override
  List<Object?> get props => [playerLocation];
}

class PlayerHitboxChange extends PlayerStatesEvent {
  const PlayerHitboxChange(this.playerHitbox);

  final RectangleHitbox playerHitbox;

  @override
  List<Object?> get props => [playerHitbox];
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

class SetFriendRequestSent extends PlayerStatesEvent {
  const SetFriendRequestSent(this.friendRequestsSent);

  final List<String> friendRequestsSent;

  @override
  List<Object?> get props => [friendRequestsSent];
}

class SetFriendRequestReceived extends PlayerStatesEvent {
  const SetFriendRequestReceived(this.friendRequestsReceived);

  final List<String> friendRequestsReceived;

  @override
  List<Object?> get props => [friendRequestsReceived];
}

class SetZenGarden extends PlayerStatesEvent {
  const SetZenGarden(this.zenGarden);

  final Map<String, bool> zenGarden;

  @override
  List<Object?> get props => [zenGarden];
}

class SetFriends extends PlayerStatesEvent {
  const SetFriends(this.friends);

  final Map<String, OtherPlayer> friends;

  @override
  List<Object?> get props => [friends];
}