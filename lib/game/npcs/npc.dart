import 'package:flame/components.dart';

abstract class Npc extends SpriteAnimationComponent{
  Npc({required Vector2 position})
      : super(
    position: position,
    size: Vector2.all(32),
    anchor: Anchor.center,
  );

  Future<void> startConversation(Vector2 playerPosition);
}