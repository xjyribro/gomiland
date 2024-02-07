import 'dart:math';

import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/constants/enums.dart';
import 'package:gomiland/game/controllers/progress_state.dart';

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

int getProgressLevel(RubbishType rubbishType, ProgressState state) {
  switch (rubbishType) {
    case RubbishType.plastic:
      return state.plastic;
    case RubbishType.paper:
      return state.paper;
    case RubbishType.electronics:
      return state.electronics;
    case RubbishType.glass:
      return state.glass;
    case RubbishType.metal:
      return state.metal;
    case RubbishType.food:
      return state.food;
    default:
      return 0;
  }
}
