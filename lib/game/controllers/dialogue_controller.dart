import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_controller_component.dart';
import 'package:jenny/jenny.dart';

class DialogueBloc extends Bloc<DialogueEvent, DialogueState> {
  DialogueBloc() : super(DialogueState.empty()) {
    on<ChangeText>(
      (event, emit) => emit(
        state.copyWith(text: event.text),
      ),
    );

    on<SetIsCompleted>(
          (event, emit) => emit(
        state.copyWith(isCompleted: event.isCompleted),
      ),
    );

    on<ChangeDialogueController>(
      (event, emit) => emit(
        state.copyWith(dialogueController: event.dialogueController),
      ),
    );

    on<ChangeDialogueOptions>(
      (event, emit) => emit(
        state.copyWith(dialogueOptions: event.dialogueOptions),
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

class SetIsCompleted extends DialogueEvent {
  const SetIsCompleted(this.isCompleted);

  final bool isCompleted;

  @override
  List<Object?> get props => [isCompleted];
}

class ChangeDialogueController extends DialogueEvent {
  const ChangeDialogueController(this.dialogueController);

  final DialogueControllerComponent dialogueController;

  @override
  List<Object?> get props => [dialogueController];
}

class ChangeDialogueOptions extends DialogueEvent {
  const ChangeDialogueOptions(this.dialogueOptions);

  final List<DialogueOption> dialogueOptions;

  @override
  List<Object?> get props => [dialogueOptions];
}

class DialogueState extends Equatable {
  final String text;
  final bool isCompleted;
  final List<DialogueOption> dialogueOptions;
  final DialogueControllerComponent dialogueController;

  const DialogueState({
    required this.text,
    required this.isCompleted,
    required this.dialogueOptions,
    required this.dialogueController,
  });

  DialogueState.empty()
      : this(
          text: '',
          isCompleted: false,
          dialogueOptions: [],
          dialogueController: DialogueControllerComponent(),
        );

  DialogueState copyWith({
    String? text,
    bool? isCompleted,
    List<DialogueOption>? dialogueOptions,
    DialogueControllerComponent? dialogueController,
  }) {
    return DialogueState(
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
      dialogueOptions: dialogueOptions ?? this.dialogueOptions,
      dialogueController: dialogueController ?? this.dialogueController,
    );
  }

  @override
  List<Object?> get props => [text, isCompleted, dialogueOptions, dialogueController];
}
