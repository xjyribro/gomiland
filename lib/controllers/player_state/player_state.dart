part of 'player_state_bloc.dart';

class PlayerState extends Equatable {
  final Vector2 playerPosition;
  final Vector2 playerDirection;
  final SceneName savedLocation;
  final bool isMale;
  final String playerName;
  final String country;
  final int playerSpeed;
  final List<String> friendRequestsSent;
  final List<String> friendRequestsReceived;
  final Map<String, OtherPlayer> friends;
  final Map<String, bool> zenGarden;

  // this is for ignore hitbox during raycast
  final RectangleHitbox? playerHitbox;

  const PlayerState({
    required this.playerPosition,
    required this.playerDirection,
    required this.playerHitbox,
    required this.isMale,
    required this.playerName,
    required this.country,
    required this.playerSpeed,
    required this.savedLocation,
    required this.friendRequestsSent,
    required this.friendRequestsReceived,
    required this.friends,
    required this.zenGarden,
  });

  PlayerState.empty()
      : this(
    playerPosition: Vector2.zero(),
    playerDirection: Vector2.zero(),
    playerHitbox: null,
    isMale: true,
    playerName: '',
    country: '',
    playerSpeed: playerBaseSpeed,
    savedLocation: SceneName.hood,
    friendRequestsSent: [],
    friendRequestsReceived: [],
    friends: {},
    zenGarden: {},
  );

  PlayerState copyWith({
    Vector2? playerPosition,
    Vector2? playerDirection,
    RectangleHitbox? playerHitbox,
    bool? isMale,
    String? playerName,
    String? country,
    int? playerSpeed,
    SceneName? savedLocation,
    List<String>? friendRequestsSent,
    List<String>? friendRequestsReceived,
    Map<String, OtherPlayer>? friends,
    Map<String, bool>? zenGarden,
  }) {
    return PlayerState(
      playerPosition: playerPosition ?? this.playerPosition,
      playerDirection: playerDirection ?? this.playerDirection,
      playerHitbox: playerHitbox ?? this.playerHitbox,
      isMale: isMale ?? this.isMale,
      playerName: playerName ?? this.playerName,
      country: country ?? this.country,
      playerSpeed: playerSpeed ?? this.playerSpeed,
      savedLocation: savedLocation ?? this.savedLocation,
      friendRequestsSent: friendRequestsSent ?? this.friendRequestsSent,
      friendRequestsReceived:
      friendRequestsReceived ?? this.friendRequestsReceived,
      friends: friends ?? this.friends,
      zenGarden: zenGarden != null ? Map<String, bool>.from(zenGarden) : this.zenGarden,
    );
  }

  void resetPlayerState(BuildContext context) {
    setPlayerState(
      context: context,
      playerName: '',
      country: '',
      isMale: true,
      friendRequestsSent: [],
      friendRequestsReceived: [],
      friends: {},
      playerXPosit: hoodStartFromRoomX,
      playerYPosit: hoodStartFromRoomY,
      playerSpeed: playerBaseSpeed,
      zenGarden: defaultZenGardenData,
    );
  }

  void setPlayerStateForNewGame(BuildContext context) {
    setPlayerState(
      context: context,
      playerXPosit: hoodStartFromRoomX,
      playerYPosit: hoodStartFromRoomY,
      playerSpeed: playerBaseSpeed,
      zenGarden: defaultZenGardenData,
    );
  }

  void setPlayerState({
    required BuildContext context,
    String? playerName,
    String? country,
    bool? isMale,
    int? playerSpeed,
    SceneName? savedLocation,
    num? playerXPosit,
    num? playerYPosit,
    num? playerXDir,
    num? playerYDir,
    List<String>? friendRequestsSent,
    List<String>? friendRequestsReceived,
    Map<String, OtherPlayer>? friends,
    Map<String, bool>? zenGarden,
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
    if (playerSpeed != null) {
      context.read<PlayerStateBloc>().add(SetPlayerSpeed(playerSpeed));
    }
    if (savedLocation != null) {
      context.read<PlayerStateBloc>().add(SetSavedLocation(savedLocation));
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
    if (friends != null) {
      context.read<PlayerStateBloc>().add(SetFriends(friends));
    }
    if (zenGarden != null) {
      context.read<PlayerStateBloc>().add(SetZenGarden(zenGarden));
    }
  }

  @override
  List<Object?> get props =>
      [
        playerPosition,
        playerDirection,
        playerHitbox,
        isMale,
        playerName,
        country,
        playerSpeed,
        savedLocation,
        friendRequestsSent,
        friendRequestsReceived,
        friends,
        zenGarden,
      ];
}
