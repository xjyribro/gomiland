// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/constants/enums.dart';

class GameStateBloc extends Bloc<GameStatesEvent, GameState> {
  GameStateBloc() : super(const GameState.empty()) {
    on<SceneChanged>(
          (event, emit) => emit(
        state.copyWith(sceneName: event.sceneName),
      ),
    );

    on<ScoreChanged>(
          (event, emit) => emit(
        state.copyWith(score: state.score + event.score),
      ),
    );

    on<MuteChanged>(
          (event, emit) => emit(
        state.copyWith(isMute: !state.isMute),
      ),
    );

    on<BagCountChange>(
          (event, emit) => emit(
        state.copyWith(bagCount: state.bagCount + event.bagCount),
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

class ScoreChanged extends GameStatesEvent {
  const ScoreChanged(this.score);

  final int score;

  @override
  List<Object?> get props => [score];
}

class MuteChanged extends GameStatesEvent {
  const MuteChanged();

  @override
  List<Object?> get props => [];
}

class BagCountChange extends GameStatesEvent {
  const BagCountChange(this. bagCount);

  final int bagCount;

  @override
  List<Object?> get props => [bagCount];
}

class GameState extends Equatable {
  final int score;
  final bool isMute;
  final SceneName sceneName;
  final int bagCount;
  // time

  const GameState({
    required this.score,
    required this.isMute,
    required this.sceneName,
    required this.bagCount,
  });

  const GameState.empty()
      : this(
    score: 0,
    isMute: false,
    sceneName: SceneName.menu,
    bagCount: 0,
  );

  GameState copyWith({
    int? score,
    bool? isMute,
    SceneName? sceneName,
    int? bagCount,
  }) {
    return GameState(
      score: score ?? this.score,
      isMute: isMute ?? this.isMute,
      sceneName: sceneName ?? this.sceneName,
      bagCount: bagCount ?? this.bagCount,
    );
  }

  @override
  List<Object?> get props => [score, isMute, sceneName, bagCount];
}
