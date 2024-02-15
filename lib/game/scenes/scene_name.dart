enum SceneName { menu, hood, park, room }

class SceneNameStrings {
  static const String menu = 'menu';
  static const String hood = 'hood';
  static const String park = 'park';
  static const String room = 'room';
}

extension SceneNameExtension on SceneName {
  String get string {
    switch (this) {
      case SceneName.menu:
        return SceneNameStrings.menu;
      case SceneName.hood:
        return SceneNameStrings.hood;
      case SceneName.park:
        return SceneNameStrings.park;
      case SceneName.room:
        return SceneNameStrings.room;
      default:
        return SceneNameStrings.menu;
    }
  }
}

extension GetSceneName on String {
  SceneName get sceneName {
    switch (this) {
      case SceneNameStrings.menu:
        return SceneName.menu;
      case SceneNameStrings.hood:
        return SceneName.hood;
      case SceneNameStrings.park:
        return SceneName.park;
      case SceneNameStrings.room:
        return SceneName.room;
      default:
        return SceneName.menu;
    }
  }
}