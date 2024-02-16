import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/controllers/audio_controller.dart';
import 'package:gomiland/game/game.dart';

class DialogueButton extends SpriteButtonComponent
    with HasGameReference<GomilandGame> {
  DialogueButton({
    required Vector2 posit,
    required String assetPath,
    required String text,
    required Function onTap,
    super.anchor = Anchor.center,
  }) : super() {
    position = posit;
    _text = text;
    _assetPath = assetPath;
    _onTap = onTap;
  }

  late String _text;
  late String _assetPath;
  late Function _onTap;

  @override
  Future<void> onLoad() async {
    Sprite dButton = await Sprite.load(_assetPath);
    button = dButton;
    ButtonText buttonText = ButtonText(text: _text);
    add(buttonText);
    onPressed = () {
      bool isMute = game.gameStateBloc.state.isMute;
      if (!isMute) Sounds.next();
      _onTap();
    };
  }
}

class ButtonText extends TextComponent {
  ButtonText({
    required String text,
  }) : super(
          text: text,
          position: Vector2(48, 16),
          anchor: Anchor.center,
          size: Vector2(88, 28),
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: dialogueButtonFontSize,
              color: Colors.white70,
              fontFamily: Strings.minecraft,
            ),
          ),
        );
}
