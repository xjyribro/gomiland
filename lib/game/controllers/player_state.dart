// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerStateBloc extends Bloc<PlayerStatesEvent, PlayerState> {
  PlayerStateBloc() : super(PlayerState.empty()) {
    on<PlayerPositionChange>(
      (event, emit) => emit(
        state.copyWith(playerPosition: event.playerPosition),
      ),
    );

    on<PlayerDirectionChange>(
      (event, emit) => emit(
        state.copyWith(playerDirection: event.playerDirection),
      ),
    );

    on<PlayerHitboxChange>(
          (event, emit) => emit(
        state.copyWith(playerHitbox: event.playerHitbox),
      ),
    );
  }
}

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

class PlayerState extends Equatable {
  final Vector2 playerPosition;
  final Vector2 playerDirection;
  final RectangleHitbox? playerHitbox;

  const PlayerState({
    required this.playerPosition,
    required this.playerDirection,
    required this.playerHitbox,
  });

  PlayerState.empty()
      : this(
          playerPosition: Vector2.zero(),
          playerDirection: Vector2.zero(),
          playerHitbox: null,
        );

  PlayerState copyWith({
    Vector2? playerPosition,
    Vector2? playerDirection,
    RectangleHitbox? playerHitbox,
  }) {
    return PlayerState(
      playerPosition: playerPosition ?? this.playerPosition,
      playerDirection: playerDirection ?? this.playerDirection,
      playerHitbox: playerHitbox ?? this.playerHitbox,
    );
  }

  @override
  List<Object?> get props => [
        playerPosition,
        playerDirection,
      ];
}
