import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/ui/info_popup/rubbish_info_popup.dart';

class BinInfoButton extends ButtonComponent with HasGameReference<GomilandGame>{
  BinInfoButton({
    required super.position,
    required super.size,
    required RubbishType binType,
  }) : super() {
    _binType = binType;
  }

  late RubbishType _binType;

  @override
  Future<void> onLoad() async {
    button = PositionComponent();
    onPressed = () {
      RubbishInfoPopup rubbishInfoPopup = RubbishInfoPopup(rubbishType: _binType);
      game.cameraComponent.viewport.add(rubbishInfoPopup);
    };
  }
}