import 'dart:ui' as ui;

import 'package:bonfire/bonfire.dart';
import 'package:flutter/services.dart';

class Coins extends GameInterface {
  late Sprite key;

  @override
  Future<void> onLoad() async {

    Future<ui.Image> loadCoin(String asset) async {
      ByteData data = await rootBundle.load(asset);
      ui.Codec codec =
          await ui.instantiateImageCodec(data.buffer.asUint8List());
      ui.FrameInfo fi = await codec.getNextFrame();
      return fi.image;
    }

    final spriteSheet = SpriteSheet(
      image: await loadCoin('assets/images/spritesheets/coin_small.png'),
      srcSize: Vector2(32, 32),
    );

    final coinAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 6);

    final animatedCoin = SpriteAnimationComponent(
      animation: coinAnimation,
      position: Vector2(150, 100),
      size: Vector2(32, 32),
    );

    add(animatedCoin);

    return super.onLoad();
  }
}
