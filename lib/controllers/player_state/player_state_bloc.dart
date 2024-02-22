import 'package:equatable/equatable.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/scenes/scene_name.dart';
import 'package:gomiland/game/data/other_player.dart';

part 'player_state.dart';

part 'player_state_event.dart';

class PlayerStateBloc extends Bloc<PlayerStatesEvent, PlayerState> {
  PlayerStateBloc() : super(PlayerState.empty()) {
    on<SetPlayerPosition>(
      (event, emit) => emit(
        state.copyWith(playerPosition: event.playerPosition),
      ),
    );

    on<SetPlayerDirection>(
      (event, emit) => emit(
        state.copyWith(playerDirection: event.playerDirection),
      ),
    );

    on<SetSavedLocation>(
      (event, emit) => emit(
        state.copyWith(savedLocation: event.playerLocation),
      ),
    );

    on<PlayerHitboxChange>(
      (event, emit) => emit(
        state.copyWith(playerHitbox: event.playerHitbox),
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

    on<SetPlayerSpeed>(
      (event, emit) => emit(
        state.copyWith(playerSpeed: event.playerSpeed),
      ),
    );

    on<SetFriendsList>(
      (event, emit) => emit(
        state.copyWith(friendsList: event.friendsList),
      ),
    );

    on<SetFriendRequestSent>(
      (event, emit) => emit(
        state.copyWith(friendRequestsSent: event.friendRequestsSent),
      ),
    );

    on<SetFriendRequestReceived>(
      (event, emit) => emit(
        state.copyWith(friendRequestsReceived: event.friendRequestsReceived),
      ),
    );

    on<SetFriends>(
      (event, emit) => emit(
        state.copyWith(friends: event.friends),
      ),
    );
  }
}
