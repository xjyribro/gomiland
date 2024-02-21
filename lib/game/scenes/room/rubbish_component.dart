import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
import 'package:gomiland/game/game.dart';
import 'package:gomiland/game/scenes/room/bin.dart';

class RubbishComponent extends SpriteComponent
    with DragCallbacks, CollisionCallbacks, HasGameReference<GomilandGame> {
  RubbishComponent({
    required Sprite sprite,
    required String name,
    required RubbishType rubbishType,
    required Function binCheck,
    required Vector2 hitboxSize,
  }) : super(
          sprite: sprite,
          anchor: Anchor.center,
        ) {
    _name = name;
    _rubbishType = rubbishType;
    _binCheck = binCheck;
    _hitboxSize = hitboxSize;
  }

  late String _name;
  late RubbishType _rubbishType;
  late Function _binCheck;
  late Vector2 _hitboxSize;
  RubbishType? _binType;

  void _returnToStart() {
    position = Vector2.zero();
  }

  void _handleRubbishDrop(
    RubbishType binType,
    RubbishType rubbishType,
    String rubbishName,
  ) {
    _binCheck(binType, rubbishType, rubbishName);
    // TODO animate out
    removeFromParent();
  }

  @override
  Future<void> onLoad() async {
    // TODO animate in
    add(RectangleHitbox(
      position: Vector2(size.x / 2, size.y / 2),
      size: _hitboxSize,
      anchor: Anchor.center,
    ));
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (_binType != null) {
      _handleRubbishDrop(_binType!, _rubbishType, _name);
    } else {
      _returnToStart();
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
