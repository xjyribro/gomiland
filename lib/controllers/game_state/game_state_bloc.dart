// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/scenes/scene_name.dart';

part 'game_state.dart';

part 'game_state_event.dart';

class GameStateBloc extends Bloc<GameStateEvent, GameState> {
  GameStateBloc() : super(const GameState.empty()) {
    on<SceneChanged>(
      (event, emit) => emit(
        state.copyWith(sceneName: event.sceneName),
      ),
    );

    on<SetCoinAmount>(
      (event, emit) {
        int coinAmount = state.coinAmount + event.coinAmount;
        return emit(
          state.copyWith(coinAmount: coinAmount.clamp(0, 999999)),
        );
      },
    );

    on<MuteChanged>(
      (event, emit) => emit(
        state.copyWith(isMute: !state.isMute),
      ),
    );

    on<SetBagCount>(
      (event, emit) => emit(
        state.copyWith(bagCount: event.bagCount),
      ),
    );

    on<SetBagSize>(
      (event, emit) => emit(
        state.copyWith(bagSize: event.bagSize),
      ),
    );

    on<AddOneMin>(
      (event, emit) => emit(
        state.copyWith(minutes: state.minutes + 1),
      ),
    );

    on<SetMinsInGame>(
      (event, emit) => emit(
        state.copyWith(minutes: event.minutes),
      ),
    );

    on<PlayerFrozen>(
      (event, emit) => emit(
        state.copyWith(playerFrozen: event.playerFrozen),
      ),
    );

    on<IncreaseDays>(
      (event, emit) => emit(
        state.copyWith(daysInGame: state.daysInGame + 1),
      ),
    );

    on<SetDaysInGame>(
      (event, emit) => emit(
        state.copyWith(daysInGame: event.days),
      ),
    );

    on<ShowControls>(
          (event, emit) => emit(
        state.copyWith(showControls: event.showControls),
      ),
    );

    on<SetGameState>(
      (event, emit) => emit(
        state.copyWith(
          coinAmount: event.coinAmount,
          bagCount: event.bagCount,
          bagSize: event.bagSize,
          minutes: event.minutes,
          daysInGame: event.daysInGame,
        ),
      ),
    );
  }
}
