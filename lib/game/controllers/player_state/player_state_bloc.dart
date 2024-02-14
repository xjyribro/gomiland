import 'package:equatable/equatable.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'player_state_event.dart';
part 'player_state.dart';

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

    on<ShowControls>(
      (event, emit) => emit(
        state.copyWith(showControls: event.showControls),
      ),
    );

    on<SetIsMale>(
      (event, emit) => emit(
        state.copyWith(isMale: event.isMale),
      ),
    );

    on<SetPlayerName>(
          (event, emit) => emit(
        state.copyWith(playerName: event.playerName),
      ),
    );

    on<SetCountry>(
          (event, emit) => emit(
        state.copyWith(country: event.country),
      ),
    );
  }
}
