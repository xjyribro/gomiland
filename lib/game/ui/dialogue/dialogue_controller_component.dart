import 'dart:async';

import 'package:flame/components.dart' hide Timer;
import 'package:gomiland/game/controllers/dialogue_controller.dart';
import 'package:gomiland/game/game.dart';
import 'package:jenny/jenny.dart';

class DialogueControllerComponent extends Component
    with DialogueView, HasGameReference<GomilandGame> {
  Completer<void> _forwardCompleter = Completer();
  Completer<int> _choiceCompleter = Completer<int>();

  void nextLine() {
    if (!_forwardCompleter.isCompleted) {
      _forwardCompleter.complete();
    }
  }

  void chooseOption(int optionNum) {
    if (!_forwardCompleter.isCompleted) {
      _forwardCompleter.complete();
    }
    if (!_choiceCompleter.isCompleted) {
      _choiceCompleter.complete(optionNum);
    }
  }

  @override
  FutureOr<bool> onLineStart(DialogueLine line) async {
    _forwardCompleter = Completer();
    await _advance(line);
    return super.onLineStart(line);
  }

  Future<void> _advance(DialogueLine line) async {
    var characterName = line.character?.name ?? '';
    var dialogueLineText = '$characterName: ${line.text}';
    game.dialogueBloc.add(ChangeText(dialogueLineText));
    return _forwardCompleter.future;
  }

  @override
  FutureOr<int?> onChoiceStart(DialogueChoice choice) async {
    _choiceCompleter = Completer<int>();

    game.dialogueBloc.add(ChangeDialogueOptions(choice.options));
    for (var option in choice.options) {
      print(option.text);
    }
    await _awaitChoice();
    return _choiceCompleter.future;
  }

  @override
  FutureOr<void> onChoiceFinish(DialogueOption option) {
    print(option.text);
  }

  Future<void> _awaitChoice() async {
    return _forwardCompleter.future;
  }

  @override
  Future<void> onNodeFinish(Node node) async {
    print('end');
  }
}
