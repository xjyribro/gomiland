import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gomiland/constants/enums.dart';

class Bin extends PositionComponent {
  Bin(
      {required Vector2 openingPosition,
        required Vector2 openingSize,
        required RubbishType binType})
      : super() {
    _openingPosition = openingPosition;
    _openingSize = openingSize;
    _binType = binType;
  }

  // game world vars
  late Vector2 _openingPosition;
  late Vector2 _openingSize;

  // custom object data
  late RubbishType _binType;
  RubbishType get binType => _binType;

  @override
  Future<void> onLoad() async {
    RectangleHitbox binOpening = RectangleHitbox(
      position: _openingPosition,
      size: _openingSize,
    );
    add(binOpening);
  }
}