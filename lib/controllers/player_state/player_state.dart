part of 'player_state_bloc.dart';

class PlayerState extends Equatable {
  final Vector2 playerPosition;
  final Vector2 playerDirection;
  final SceneName savedLocation;
  final bool isMale;
  final String playerName;
  final String country;
  final List<String> friendsList;
  final List<String> friendRequestsSent;
  final List<String> friendRequestsReceived;

  // this is for ignore hitbox during raycast
  final RectangleHitbox? playerHitbox;

  const PlayerState({
    required this.playerPosition,
    required this.playerDirection,
    required this.playerHitbox,
    required this.isMale,
    required this.playerName,
    required this.country,
    required this.savedLocation,
    required this.friendsList,
    required this.friendRequestsSent,
    required this.friendRequestsReceived,
  });

  PlayerState.empty()
      : this(
          playerPosition: Vector2.zero(),
          playerDirection: Vector2.zero(),
          playerHitbox: null,
          isMale: true,
          playerName: '',
          country: '',
          savedLocation: SceneName.hood,
          friendsList: [],
          friendRequestsSent: [],
          friendRequestsReceived: [],
        );

  PlayerState copyWith({
    Vector2? playerPosition,
    Vector2? playerDirection,
    RectangleHitbox? playerHitbox,
    bool? isMale,
    String? playerName,
    String? country,
    SceneName? savedLocation,
    List<String>? friendsList,
    List<String>? friendRequestsSent,
    List<String>? friendRequestsReceived,
  }) {
    return PlayerState(
      playerPosition: playerPosition ?? this.playerPosition,
      playerDirection: playerDirection ?? this.playerDirection,
      playerHitbox: playerHitbox ?? this.playerHitbox,
      isMale: isMale ?? this.isMale,
      playerName: playerName ?? this.playerName,
      country: country ?? this.country,
      savedLocation: savedLocation ?? this.savedLocation,
      friendsList: friendsList ?? this.friendsList,
      friendRequestsSent: friendRequestsSent ?? this.friendRequestsSent,
      friendRequestsReceived:
          friendRequestsReceived ?? this.friendRequestsReceived,
    );
  }

  void resetPlayerState(BuildContext context) {
    setPlayerState(
      context: context,
      playerXPosit: hoodStartFromRoomX,
      playerYPosit: hoodStartFromRoomY,
    );
  }

  void setPlayerState({
    required BuildContext context,
    String? playerName,
    String? country,
    bool? isMale,
    SceneName? savedLocation,
    num? playerXPosit,
    num? playerYPosit,
    num? playerXDir,
    num? playerYDir,
    List<String>? friendsList,
    List<String>? friendRequestsSent,
    List<String>? friendRequestsReceived,
  }) {
    if (playerName != null) {
      context.read<PlayerStateBloc>().add(SetPlayerName(playerName));
    }
    if (country != null) {
      context.read<PlayerStateBloc>().add(SetCountry(country));
    }
    if (isMale != null) context.read<PlayerStateBloc>().add(SetIsMale(isMale));
    if (playerXPosit != null && playerYPosit != null) {
      Vector2 position =
          Vector2(playerXPosit.toDouble(), playerYPosit.toDouble());
      context.read<PlayerStateBloc>().add(SetPlayerPosition(position));
    }
    if (playerXDir != null && playerYDir != null) {
      Vector2 direction = Vector2(playerXDir.toDouble(), playerYDir.toDouble());
      context.read<PlayerStateBloc>().add(SetPlayerDirection(direction));
    }
    if (savedLocation != null) {
      context.read<PlayerStateBloc>().add(SetSavedLocation(savedLocation));
    }
    if (friendsList != null) {
      context.read<PlayerStateBloc>().add(SetFriendsList(friendsList));
    }
    if (friendRequestsSent != null) {
      context
          .read<PlayerStateBloc>()
          .add(SetFriendRequestSent(friendRequestsSent));
    }
    if (friendRequestsReceived != null) {
      context
          .read<PlayerStateBloc>()
          .add(SetFriendRequestReceived(friendRequestsReceived));
    }
  }

  @override
  List<Object?> get props => [
        playerPosition,
        playerDirection,
        playerHitbox,
        isMale,
        playerName,
        country,
        savedLocation,
        friendsList,
        friendRequestsSent,
        friendRequestsReceived,
      ];
}
