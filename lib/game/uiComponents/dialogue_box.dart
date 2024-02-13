import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomiland/assets.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/controllers/dialogue_controller.dart';
import 'package:gomiland/game/game.dart';
import 'package:jenny/jenny.dart';

class DialogueControllerComponent extends Component
    with DialogueView, HasGameReference<GomilandGame> {

  Completer<void> _forwardCompleter = Completer();
  // late DialogueBoxComponent dialogueBoxComponent;

  @override
  FutureOr<bool> onLineStart(DialogueLine line) async {
    _forwardCompleter = Completer();
    await _advance(line);
    return super.onLineStart(line);
  }

  @override
  Future<void> onLoad() async {
    // dialogueBoxComponent = DialogueBoxComponent(text: '');
    // game.cameraComponent.viewport.add(dialogueBoxComponent);
    ButtonComponent forwardButtonComponent = ButtonComponent(
      button: PositionComponent(position: Vector2.zero()),
      size: game.size,
      onPressed: () {
        if (!_forwardCompleter.isCompleted) {
          _forwardCompleter.complete();
        }
      },
    );
    addAll([
      forwardButtonComponent,
    ]);
  }

  Future<void> _advance(DialogueLine line) async {
    var characterName = line.character?.name ?? '';
    var dialogueLineText = '$characterName: ${line.text}';
    // dialogueBoxComponent.changeText(dialogueLineText);
    game.dialogueBloc.add(ChangeText(dialogueLineText));
    return _forwardCompleter.future;
  }
}

class DialogueBoxComponent extends HudMarginComponent {
  DialogueBoxComponent({
    required String text,
    super.margin = const EdgeInsets.only(
      left: 32,
      top: 320,
    ),
  }) : super() {
    _text = text;
  }

  late TextComponent _dialgoueTextComponent;
  late String _text;

  @override
  Future<void> onLoad() async {
    _dialgoueTextComponent = TextComponent(
      text: _text,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 20,
          fontFamily: Strings.minecraft,
        ),
      ),
      position: Vector2(32, 32),
    );
    final SpriteComponent box = SpriteComponent(
        sprite: await Sprite.load(Assets.assets_images_ui_dialogue_box_png),
        size: Vector2(512, 96)
    );
    box.add(_dialgoueTextComponent);
    add(box);
  }

  void changeText(String newText) {
    _dialgoueTextComponent.text = newText;
  }
}

class DialogueBox extends StatelessWidget {
  const DialogueBox({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTextStyle(
      style: const TextStyle(
        fontFamily: Strings.minecraft,
        fontSize: 32,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              Assets.assets_images_ui_dialogue_box_png,
              width: size.width,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(64),
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