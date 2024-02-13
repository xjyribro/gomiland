// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayStateBloc extends Bloc<DayStatesEvent, DayState> {
  DayStateBloc() : super(const DayState.empty()) {
    on<AddOnePlastic>(
          (event, emit) => emit(
        state.copyWith(plastic: state.plastic + 1),
      ),
    );

    on<AddOnePaper>(
          (event, emit) => emit(
        state.copyWith(paper: state.paper + 1),
      ),
    );

    on<AddOneMetal>(
          (event, emit) => emit(
        state.copyWith(metal: state.metal + 1),
      ),
    );

    on<AddOneElectronic>(
          (event, emit) => emit(
        state.copyWith(electronics: state.electronics + 1),
      ),
    );

    on<AddOneGlass>(
          (event, emit) => emit(
        state.copyWith(glass: state.glass + 1),
      ),
    );

    on<AddOneFood>(
          (event, emit) => emit(
        state.copyWith(food: state.food + 1),
      ),
    );

    on<AddOneMistake>(
          (event, emit) => emit(
        state.copyWith(mistakes: state.mistakes + 1),
      ),
    );

    on<AddCoinsToday>(
          (event, emit) => emit(
        state.copyWith(mistakes: state.mistakes + event.coins),
      ),
    );

    on<ResetDay>(
          (event, emit) => emit(
        state.copyWith(
          plastic: 0,
          paper: 0,
          metal: 0,
          electronics: 0,
          glass: 0,
          food: 0,
          coins: 0,
          mistakes: 0,
        ),
      ),
    );
  }
}

abstract class DayStatesEvent extends Equatable {
  const DayStatesEvent();
}

class AddOnePlastic extends DayStatesEvent {
  const AddOnePlastic();

  @override
  List<Object?> get props => [];
}

class AddOnePaper extends DayStatesEvent {
  const AddOnePaper();

  @override
  List<Object?> get props => [];
}

class AddOneMetal extends DayStatesEvent {
  const AddOneMetal();

  @override
  List<Object?> get props => [];
}

class AddOneElectronic extends DayStatesEvent {
  const AddOneElectronic();

  @override
  List<Object?> get props => [];
}

class AddOneGlass extends DayStatesEvent {
  const AddOneGlass();

  @override
  List<Object?> get props => [];
}

class AddOneFood extends DayStatesEvent {
  const AddOneFood();

  @override
  List<Object?> get props => [];
}

class AddOneMistake extends DayStatesEvent {
  const AddOneMistake();

  @override
  List<Object?> get props => [];
}

class AddCoinsToday extends DayStatesEvent {
  const AddCoinsToday(this.coins);

  final int coins;

  @override
  List<Object?> get props => [coins];
}

class ResetDay extends DayStatesEvent {
  const ResetDay();

  @override
  List<Object?> get props => [];
}

class DayState extends Equatable {
  final int plastic;
  final int paper;
  final int metal;
  final int electronics;
  final int glass;
  final int food;
  final int coins;
  final int mistakes;

  const DayState({
    required this.plastic,
    required this.paper,
    required this.metal,
    required this.electronics,
    required this.glass,
    required this.food,
    required this.coins,
    required this.mistakes,
  });

  const DayState.empty()
      : this(
    plastic: 0,
    paper: 0,
    metal: 0,
    electronics: 0,
    glass: 0,
    food: 0,
    coins: 0,
    mistakes: 0,
  );

  DayState copyWith({
    int? plastic,
    int? paper,
    int? metal,
    int? electronics,
    int? glass,
    int? food,
    int? coins,
    int? mistakes,
  }) {
    return DayState(
      plastic: plastic ?? this.plastic,
      paper: paper ?? this.paper,
      metal: metal ?? this.metal,
      electronics: electronics ?? this.electronics,
      glass: glass ?? this.glass,
      food: food ?? this.food,
      coins: coins ?? this.coins,
      mistakes: mistakes ?? this.mistakes,
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
    coins,
    mistakes,
  ];
}
