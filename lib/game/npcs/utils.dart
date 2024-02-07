import 'dart:math';

import 'package:gomiland/constants/constants.dart';

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

String getRandomConversation(NpcName npcName) {
  int rand = Random().nextInt(npcDialogueCount-1) + 1;
  switch (npcName) {
    case NpcName.boy:
      return 'boy$rand';
    case NpcName.girl:
      return 'girl$rand';
    case NpcName.man:
      return 'man$rand';
    case NpcName.woman:
      return 'woman$rand';
    default:
      return 'boy$rand';
  }
}