// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameStateBloc extends Bloc<GameStatesEvent, GameState> {
  GameStateBloc() : super(const GameState.empty()) {
    on<ScoreEventAdded>(
          (event, emit) => emit(
        state.copyWith(score: state.score + event.score),
      ),
    );

    on<PlayerRespawned>(
          (event, emit) => emit(
        state.copyWith(status: GameStatus.respawned),
      ),
    );

    on<PlayerDied>((event, emit) {
      if (state.lives > 1) {
        emit(
          state.copyWith(
            lives: state.lives - 1,
            status: GameStatus.respawn,
          ),
        );
      } else {
        emit(
          state.copyWith(
            lives: 0,
            status: GameStatus.gameOver,
          ),
        );
      }
    });

    on<GameReset>(
          (event, emit) => emit(
        const GameState.empty(),
      ),
    );
  }
}

abstract class GameStatesEvent extends Equatable {
  const GameStatesEvent();
}

class ScoreEventAdded extends GameStatesEvent {
  const ScoreEventAdded(this.score);

  final int score;

  @override
  List<Object?> get props => [score];
}

class PlayerDied extends GameStatesEvent {
  const PlayerDied();

  @override
  List<Object?> get props => [];
}

class PlayerRespawned extends GameStatesEvent {
  const PlayerRespawned();

  @override
  List<Object?> get props => [];
}

class GameReset extends GameStatesEvent {
  const GameReset();

  @override
  List<Object?> get props => [];
}

enum GameStatus {
  initial,
  respawn,
  respawned,
  gameOver,
}

class GameState extends Equatable {
  final int score;
  final int lives;
  final GameStatus status;

  const GameState({
    required this.score,
    required this.lives,
    required this.status,
  });

  const GameState.empty()
      : this(
    score: 0,
    lives: 3,
    status: GameStatus.initial,
  );

  GameState copyWith({
    int? score,
    int? lives,
    GameStatus? status,
  }) {
    return GameState(
      score: score ?? this.score,
      lives: lives ?? this.lives,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [score, lives, status];
}
