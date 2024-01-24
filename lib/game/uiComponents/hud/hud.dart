import 'package:flame/components.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/uiComponents/hud/bag.dart';
import 'package:gomiland/game/uiComponents/hud/coins.dart';
import 'package:gomiland/game/uiComponents/hud/game_menu_button.dart';

class Hud extends PositionComponent with HasGameReference<GomilandGame> {
  Hud({super.priority = 3});

  @override
  Future<void> onLoad() async {
    final BagComponent bagComponent =
        BagComponent(position: Vector2(game.size.x - 400, 32));
    final CoinsComponent coinsComponent =
        CoinsComponent(position: Vector2(game.size.x - 600, 32));
    final GameMenuButton gameMenuButton = GameMenuButton();
    addAll([
      coinsComponent,
      bagComponent,
      gameMenuButton,
    ]);
  }
}
