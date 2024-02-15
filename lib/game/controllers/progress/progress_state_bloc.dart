import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'progress_state_event.dart';
part 'progress_state.dart';

class ProgressStateBloc extends Bloc<ProgressStateEvent, ProgressState> {
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

    on<QianBiProgressChange>(
          (event, emit) => emit(
        state.copyWith(qianBi: event.qianBi),
      ),
    );

    on<ManukaProgressChange>(
          (event, emit) => emit(
        state.copyWith(manuka: event.manuka),
      ),
    );

    on<StarkProgressChange>(
          (event, emit) => emit(
        state.copyWith(stark: event.stark),
      ),
    );

    on<AsimovProgressChange>(
          (event, emit) => emit(
        state.copyWith(asimov: event.asimov),
      ),
    );

    on<RisaProgressChange>(
          (event, emit) => emit(
        state.copyWith(risa: event.risa),
      ),
    );

    on<MoonProgressChange>(
          (event, emit) => emit(
        state.copyWith(moon: event.moon),
      ),
    );

    on<WrongProgressChange>(
          (event, emit) => emit(
        state.copyWith(wrong: event.wrong),
      ),
    );

    on<NeighbourStateChange>(
          (event, emit) => emit(
        state.copyWith(neighbour: event.neighbour),
      ),
    );
  }
}
