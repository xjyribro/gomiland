import 'dart:async';

import 'package:flame/components.dart' hide Timer;
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/ui/dialogue/dialogue_box.dart';
import 'package:jenny/jenny.dart';

class DialogueControllerComponent extends Component
    with DialogueView, HasGameReference<GomilandGame> {

  Completer<void> _forwardCompleter = Completer();
  Completer<int> _choiceCompleter = Completer<int>();
  Completer<void> _closeCompleter = Completer();
  bool _isFirstLine = true;
  late final DialogueBoxComponent _dialogueBoxComponent =
      DialogueBoxComponent();

  Future<void> _advance() async {
    return _forwardCompleter.future;
  }

  void _goNextLine() {
    if (!_forwardCompleter.isCompleted) {
      _forwardCompleter.complete();
    }
  }

  void _onChoice(int optionNum) {
    if (!_forwardCompleter.isCompleted) {
      _forwardCompleter.complete();
    }
    if (!_choiceCompleter.isCompleted) {
      _choiceCompleter.complete(optionNum);
    }
  }

  @override
  Future<void> onNodeStart(Node node) async {
    _isFirstLine = true;
    _closeCompleter = Completer();
    _addDialogueBox();
  }

  @override
  Future<void> onNodeFinish(Node node) async {
    _dialogueBoxComponent.showCloseButton(_onClose);
    await _returnClosed();
  }

  @override
  FutureOr<bool> onLineStart(DialogueLine line) async {
    _forwardCompleter = Completer();
    _changeTextAndShowNextButton(line, _isFirstLine);
    await _advance();
    _isFirstLine = false;
    return super.onLineStart(line);
  }

  void _changeTextAndShowNextButton(DialogueLine line, bool isFirstLine) {
    _dialogueBoxComponent.showNextButton(_goNextLine);
    String characterName = line.character?.name ?? '';
    String dialogueLineText = '$characterName: ${line.text}';
    _dialogueBoxComponent.changeText(dialogueLineText, isFirstLine);
  }

  Future<void> _returnClosed() async {
    return _closeCompleter.future;
  }

  Future<void> _completeClose() async {
    if (!_closeCompleter.isCompleted) {
      _closeCompleter.complete();
    }
  }

  @override
  FutureOr<int?> onChoiceStart(DialogueChoice choice) async {
    _forwardCompleter = Completer();
    _choiceCompleter = Completer<int>();
    _dialogueBoxComponent.showOptions(
      onChoice: _onChoice,
      option1: choice.options[0],
      option2: choice.options[1],
    );
    await _advance();
    return _choiceCompleter.future;
  }

  void _addDialogueBox() {
    List<DialogueBoxComponent> list =
        game.cameraComponent.viewport.children.query<DialogueBoxComponent>();
    if (list.isEmpty) {
      game.cameraComponent.viewport.add(_dialogueBoxComponent);
    }
  }

  void _onClose() {
    List<DialogueBoxComponent> list =
        game.cameraComponent.viewport.children.query<DialogueBoxComponent>();
    if (list.isNotEmpty) {
      game.cameraComponent.viewport.removeAll(list);
    }
    _completeClose();
  }
}
