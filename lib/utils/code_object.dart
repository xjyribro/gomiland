import 'package:gomiland/constants/constants.dart';

class CodeObject {
  String object;
  String code;
  int count;

  CodeObject({
    required this.object,
    required this.code,
    required this.count,
  });

  static CodeObject fromJson(Map<String, dynamic> json) {
    return CodeObject(
      object: json[Strings.object] ?? '',
      code: json[Strings.code] ?? '',
      count: json[Strings.count] ?? 0,
    );
  }
}
