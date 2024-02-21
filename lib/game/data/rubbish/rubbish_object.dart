import 'package:flame/components.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';

class RubbishObject {
  String name;
  String assetPath;
  RubbishType rubbishType;
  int spriteCount;
  Vector2 size;
  Vector2 hitboxSize;

  RubbishObject({
    required this.name,
    required this.assetPath,
    required this.rubbishType,
    required this.spriteCount,
    required this.size,
    required this.hitboxSize,
  });
}