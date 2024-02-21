import 'package:flame/components.dart';
import 'package:gomiland/controllers/progress/progress_state_bloc.dart';
import 'package:gomiland/game/data/rubbish/rubbish_type.dart';
import 'package:gomiland/game/objects/obsticle.dart';

class NpcNameStrings {
  static const String boy = 'boy';
  static const String girl = 'girl';
  static const String man = 'man';
  static const String woman = 'woman';
  static const String unknown = 'unknown';
}

enum NpcName { boy, girl, man, woman, unknown }

extension NpcNameExtension on NpcName {
  String get string {
    switch (this) {
      case NpcName.boy:
        return NpcNameStrings.boy;
      case NpcName.girl:
        return NpcNameStrings.girl;
      case NpcName.man:
        return NpcNameStrings.man;
      case NpcName.woman:
        return NpcNameStrings.woman;
      default:
        return NpcNameStrings.unknown;
    }
  }
}

extension GetNpcName on String {
  NpcName get npcName {
    switch (this) {
      case NpcNameStrings.boy:
        return NpcName.boy;
      case NpcNameStrings.girl:
        return NpcName.girl;
      case NpcNameStrings.man:
        return NpcName.man;
      case NpcNameStrings.woman:
        return NpcName.woman;
      default:
        return NpcName.unknown;
    }
  }
}

int getCharProgress(RubbishType rubbishType, ProgressState state) {
  switch (rubbishType) {
    case RubbishType.plastic:
      return state.risa;
    case RubbishType.paper:
      return state.qianBi;
    case RubbishType.electronics:
      return state.asimov;
    case RubbishType.glass:
      return state.manuka;
    case RubbishType.metal:
      return state.stark;
    case RubbishType.food:
      return state.moon;
    default:
      return 0;
  }
}

Obstacle npcObstacle(Vector2 position) => Obstacle(
      position: Vector2(position.x + 6, position.y),
      size: Vector2(20, 32),
    );
