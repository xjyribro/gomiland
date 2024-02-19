import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'progress_state.dart';

part 'progress_state_event.dart';

class ProgressStateBloc extends Bloc<ProgressStateEvent, ProgressState> {
  ProgressStateBloc() : super(const ProgressState.empty()) {

    on<SetHasSave>(
      (event, emit) => emit(
        state.copyWith(hasSave: event.hasSave),
      ),
    );

    on<SetPlasticProgress>(
      (event, emit) => emit(
        state.copyWith(plastic: event.plastic),
      ),
    );

    on<SetPaperProgress>(
      (event, emit) => emit(
        state.copyWith(paper: event.paper),
      ),
    );

    on<SetMetalProgress>(
      (event, emit) => emit(
        state.copyWith(metal: event.metal),
      ),
    );

    on<SetElectronicsProgress>(
      (event, emit) => emit(
        state.copyWith(electronics: event.electronics),
      ),
    );

    on<SetGlassProgress>(
      (event, emit) => emit(
        state.copyWith(glass: event.glass),
      ),
    );

    on<SetFoodProgress>(
      (event, emit) => emit(
        state.copyWith(food: event.food),
      ),
    );

    on<SetQianBiProgress>(
      (event, emit) => emit(
        state.copyWith(qianBi: event.qianBi),
      ),
    );

    on<SetManukaProgress>(
      (event, emit) => emit(
        state.copyWith(manuka: event.manuka),
      ),
    );

    on<SetStarkProgress>(
      (event, emit) => emit(
        state.copyWith(stark: event.stark),
      ),
    );

    on<SetAsimovProgress>(
      (event, emit) => emit(
        state.copyWith(asimov: event.asimov),
      ),
    );

    on<SetRisaProgress>(
      (event, emit) => emit(
        state.copyWith(risa: event.risa),
      ),
    );

    on<SetMoonProgress>(
      (event, emit) => emit(
        state.copyWith(moon: event.moon),
      ),
    );

    on<SetWrongProgress>(
      (event, emit) => emit(
        state.copyWith(wrong: event.wrong),
      ),
    );

    on<SetNeighbourState>(
      (event, emit) => emit(
        state.copyWith(neighbour: event.neighbour),
      ),
    );

    on<SetProgressState>(
          (event, emit) => emit(
        state.copyWith(
          hasSave: event.hasSave,
          neighbour: event.neighbour,
          plastic: event.plastic,
          paper: event.paper,
          metal: event.metal,
          electronics: event.electronics,
          glass: event.glass,
          food: event.food,
          wrong: event.wrong,
          manuka: event.manuka,
          qianBi: event.qianBi,
          risa: event.risa,
          stark: event.stark,
          asimov: event.asimov,
          moon: event.moon,
        ),
      ),
    );

  }
}
