enum SceneName { menu, hood, park, room }

class RubbishTypeStrings {
  static const String paper = 'paper';
  static const String plastic = 'plastic';
  static const String metal = 'metal';
  static const String electronic = 'electronic';
  static const String food = 'food';
  static const String glass = 'glass';
  static const String unknown = 'unknown';
}

enum RubbishType { paper, plastic, metal, electronic, food, glass, unknown }

extension RubbishTypeExtension on RubbishType {
  String get string {
    switch (this) {
      case RubbishType.paper:
        return RubbishTypeStrings.paper;
      case RubbishType.plastic:
        return RubbishTypeStrings.plastic;
      case RubbishType.metal:
        return RubbishTypeStrings.metal;
      case RubbishType.electronic:
        return RubbishTypeStrings.electronic;
      case RubbishType.food:
        return RubbishTypeStrings.food;
      case RubbishType.glass:
        return RubbishTypeStrings.glass;
      default:
        return RubbishTypeStrings.unknown;
    }
  }
}

extension GetRubbishType on String {
  RubbishType get rubbishType {
    switch (this) {
      case RubbishTypeStrings.paper:
        return RubbishType.paper;
      case RubbishTypeStrings.plastic:
        return RubbishType.plastic;
      case RubbishTypeStrings.metal:
        return RubbishType.metal;
      case RubbishTypeStrings.electronic:
        return RubbishType.electronic;
      case RubbishTypeStrings.food:
        return RubbishType.food;
      case RubbishTypeStrings.glass:
        return RubbishType.glass;
      default:
        return RubbishType.unknown;
    }
  }
}