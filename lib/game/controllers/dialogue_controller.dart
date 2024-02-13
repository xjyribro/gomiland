// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogueBloc extends Bloc<DialogueEvent, DialogueState> {
  DialogueBloc() : super(const DialogueState.empty()) {
    on<ChangeText>(
      (event, emit) => emit(
        state.copyWith(text: event.text),
      ),
    );
  }
}

abstract class DialogueEvent extends Equatable {
  const DialogueEvent();
}

class ChangeText extends DialogueEvent {
  const ChangeText(this.text);

  final String text;

  @override
  List<Object?> get props => [text];
}

class DialogueState extends Equatable {
  final String text;

  const DialogueState({
    required this.text,
  });

  const DialogueState.empty()
      : this(
          text: '',
        );

  DialogueState copyWith({
    String? text,
  }) {
    return DialogueState(
      text: text ?? this.text,
    );
  }

  @override
  List<Object?> get props => [text];
}
