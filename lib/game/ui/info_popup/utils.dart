import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gomiland/game/data/rubbish/rubbish_object.dart';

double getSpriteYPosit(double height) {
  const topMargin = 96;
  const maxHeight = 96;
  return topMargin + ((maxHeight - height) / 2);
}

Future<Sprite> getSprite(RubbishObject rubbishObject) async {
  final image = await Flame.images.load(rubbishObject.assetPath);
  final spriteSheet = SpriteSheet(
    image: image,
    srcSize: rubbishObject.size,
  );
  return spriteSheet.getSprite(0, 0);
}