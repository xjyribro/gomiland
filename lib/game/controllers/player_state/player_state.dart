part of 'player_state_bloc.dart';

class PlayerState extends Equatable {
  final Vector2 playerPosition;
  final Vector2 playerDirection;
  final bool showControls;
  final bool isMale;
  final String playerName;
  final String country;

  // this is for ignore hitbox during raycast
  final RectangleHitbox? playerHitbox;

  const PlayerState({
    required this.playerPosition,
    required this.playerDirection,
    required this.showControls,
    required this.playerHitbox,
    required this.isMale,
    required this.playerName,
    required this.country,
  });

  PlayerState.empty()
      : this(
          playerPosition: Vector2.zero(),
          playerDirection: Vector2.zero(),
          showControls: kIsWeb ? false : true,
          playerHitbox: null,
          isMale: true,
          playerName: '',
          country: '',
        );

  PlayerState copyWith({
    Vector2? playerPosition,
    Vector2? playerDirection,
    bool? showControls,
    RectangleHitbox? playerHitbox,
    bool? isMale,
    String? playerName,
    String? country,
  }) {
    return PlayerState(
      playerPosition: playerPosition ?? this.playerPosition,
      playerDirection: playerDirection ?? this.playerDirection,
      showControls: showControls ?? this.showControls,
      playerHitbox: playerHitbox ?? this.playerHitbox,
      isMale: isMale ?? this.isMale,
      playerName: playerName ?? this.playerName,
      country: country ?? this.country,
    );
  }

  @override
  List<Object?> get props => [
        showControls,
        playerPosition,
        playerDirection,
        playerHitbox,
        isMale,
        playerName,
        country,
      ];
}
