// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SceneName { menu, hood, park, room }

class GameStateBloc extends Bloc<GameStatesEvent, GameState> {
  GameStateBloc() : super(const GameState.empty()) {
    on<SceneChanged>(
          (event, emit) => emit(
        state.copyWith(sceneName: event.sceneName),
      ),
    );

    on<ScoreAdded>(
          (event, emit) => emit(
        state.copyWith(score: state.score + event.score),
      ),
    );

    on<MuteChanged>(
          (event, emit) => emit(
        state.copyWith(isMute: !state.isMute),
      ),
    );
  }
}

abstract class GameStatesEvent extends Equatable {
  const GameStatesEvent();
}

class SceneChanged extends GameStatesEvent {
  const SceneChanged(this.sceneName);

  final SceneName sceneName;

  @override
  List<Object?> get props => [sceneName];
}

class ScoreAdded extends GameStatesEvent {
  const ScoreAdded(this.score);

  final int score;

  @override
  List<Object?> get props => [score];
}

class MuteChanged extends GameStatesEvent {
  const MuteChanged();

  @override
  List<Object?> get props => [];
}

class GameState extends Equatable {
  final int score;
  final bool isMute;
  final SceneName sceneName;

  const GameState({
    required this.score,
    required this.isMute,
    required this.sceneName,
  });

  const GameState.empty()
      : this(
    score: 0,
    isMute: false,
    sceneName: SceneName.menu,
  );

  GameState copyWith({
    int? score,
    bool? isMute,
    SceneName? sceneName,
  }) {
    return GameState(
      score: score ?? this.score,
      isMute: isMute ?? this.isMute,
      sceneName: sceneName ?? this.sceneName,
    );
  }

  @override
  List<Object?> get props => [score, isMute, sceneName];
}
