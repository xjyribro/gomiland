// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressStateBloc extends Bloc<ProgressStatesEvent, ProgressState> {
  ProgressStateBloc() : super(const ProgressState.empty()) {
    on<PlasticProgressChange>(
      (event, emit) => emit(
        state.copyWith(plastic: event.plastic),
      ),
    );

    on<PaperProgressChange>(
      (event, emit) => emit(
        state.copyWith(paper: event.paper),
      ),
    );

    on<MetalProgressChange>(
      (event, emit) => emit(
        state.copyWith(metal: event.metal),
      ),
    );

    on<ElectronicsProgressChange>(
      (event, emit) => emit(
        state.copyWith(electronics: event.electronics),
      ),
    );

    on<GlassProgressChange>(
      (event, emit) => emit(
        state.copyWith(glass: event.glass),
      ),
    );

    on<FoodProgressChange>(
      (event, emit) => emit(
        state.copyWith(food: event.food),
      ),
    );
  }
}

abstract class ProgressStatesEvent extends Equatable {
  const ProgressStatesEvent();
}

class PlasticProgressChange extends ProgressStatesEvent {
  const PlasticProgressChange(this.plastic);

  final int plastic;

  @override
  List<Object?> get props => [plastic];
}

class PaperProgressChange extends ProgressStatesEvent {
  const PaperProgressChange(this.paper);

  final int paper;

  @override
  List<Object?> get props => [paper];
}

class MetalProgressChange extends ProgressStatesEvent {
  const MetalProgressChange(this.metal);

  final int metal;

  @override
  List<Object?> get props => [metal];
}

class ElectronicsProgressChange extends ProgressStatesEvent {
  const ElectronicsProgressChange(this.electronics);

  final int electronics;

  @override
  List<Object?> get props => [electronics];
}

class GlassProgressChange extends ProgressStatesEvent {
  const GlassProgressChange(this.glass);

  final int glass;

  @override
  List<Object?> get props => [glass];
}

class FoodProgressChange extends ProgressStatesEvent {
  const FoodProgressChange(this.food);

  final int food;

  @override
  List<Object?> get props => [food];
}

class ProgressState extends Equatable {
  final int plastic;
  final int paper;
  final int metal;
  final int electronics;
  final int glass;
  final int food;

  const ProgressState({
    required this.plastic,
    required this.paper,
    required this.metal,
    required this.electronics,
    required this.glass,
    required this.food,
  });

  const ProgressState.empty()
      : this(
          plastic: 0,
          paper: 0,
          metal: 0,
          electronics: 0,
          glass: 0,
          food: 0,
        );

  ProgressState copyWith({
    int? plastic,
    int? paper,
    int? metal,
    int? electronics,
    int? glass,
    int? food,
  }) {
    return ProgressState(
      plastic: plastic ?? this.plastic,
      paper: paper ?? this.paper,
      metal: metal ?? this.metal,
      electronics: electronics ?? this.electronics,
      glass: glass ?? this.glass,
      food: food ?? this.food,
    );
  }

  @override
  List<Object?> get props => [
        plastic,
        paper,
        metal,
        electronics,
        glass,
        food,
      ];
}
