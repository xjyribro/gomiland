import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/game/controllers/dialogue_controller.dart';
import 'package:gomiland/game/game.dart';
import 'package:jenny/jenny.dart';

class DialogueControllerComponent extends Component
    with DialogueView, HasGameReference<GomilandGame> {
  late SpriteButtonComponent buttonComponent;
  late GomilandGame ref;

  Completer<void> _forwardCompleter = Completer();

  @override
  FutureOr<bool> onLineStart(DialogueLine line) async {
    _forwardCompleter = Completer();
    await _advance(line);
    return super.onLineStart(line);
  }

  @override
  Future<void> onLoad() async {
    ButtonComponent forwardButtonComponent = ButtonComponent(
        button: PositionComponent(),
        size: game.size,
        onPressed: () {
          if (!_forwardCompleter.isCompleted) {
            _forwardCompleter.complete();
          }
        });

    ref = game;
    addAll([
      forwardButtonComponent,
    ]);
  }

  Future<void> _advance(DialogueLine line) async {
    var characterName = line.character?.name ?? '';
    var dialogueLineText = '$characterName: ${line.text}';
    ref.dialogueBloc.add(ChangeText(dialogueLineText));
    return _forwardCompleter.future;
  }
}

class DialogueBox extends StatelessWidget {
  const DialogueBox({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTextStyle(
      style: const TextStyle(
        fontFamily: 'minecraft',
        fontSize: 32,
      ),
      child: Stack(
        children: [
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Image.asset(
              Assets.assets_images_ui_dialogue_box_png,
              width: size.width,
            ),
          ),
          Positioned(
            bottom: 100,
            left: 150,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: BlocBuilder<DialogueBloc, DialogueState>(
                builder: (context, state) => AnimatedTextKit(
                  key: Key(state.text),
                  animatedTexts: [
                    TyperAnimatedText(
                      state.text,
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  isRepeatingAnimation: false,
                  onFinished: () {
                    print('fin');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
