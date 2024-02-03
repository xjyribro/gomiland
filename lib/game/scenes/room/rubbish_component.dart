import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/scenes/room/bin.dart';

class RubbishComponent extends SpriteComponent
    with DragCallbacks, CollisionCallbacks {
  RubbishComponent({
    required Sprite sprite,
    required Vector2 position,
    required String name,
    required RubbishType rubbishType,
    required Function onRubbishRemoved,
  }) : super(
          sprite: sprite,
          position: position,
        ) {
    _originalPosition = position;
    _name = name;
    _rubbishType = rubbishType;
    _onRubbishRemoved = onRubbishRemoved;
  }

  // game world vars
  late Vector2 _originalPosition;

  // custom object data
  late String _name;
  late RubbishType _rubbishType;

  late Function _onRubbishRemoved;

  RubbishType? _binType;

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox(position: Vector2.zero(), size: size));
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.canvasDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (_binType != null) {
      if (_rubbishType == _binType) {
        print('score');
      } else {
        print('$_name is not made of $_binType');
      }
    } else {
      position = _originalPosition;
    }
    super.onDragEnd(event);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Bin) {
      _binType = other.binType;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Bin && other.binType == _binType) {
      _binType = null;
    }
  }
}
