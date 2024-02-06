import 'package:gomiland/constants/info_text.dart';

class InfoPopupObject {
  String name;
  String text;
  String? imgPath;

  InfoPopupObject({
    required this.name,
    required this.text,
    this.imgPath,
  });

  InfoPopupObject.empty()
      : this(
          name: '',
          text: '',
        );
}

class InfoPopData{
  static const String howToPlay = 'how_to_play';

  InfoPopData() {
    _data['how_to_play'] = InfoPopupObject(name: 'how_to_play', text: InfoText.howToPlay);
  }

  final Map<String, InfoPopupObject> _data = {};
  Map<String, InfoPopupObject> get data => _data;
}

InfoPopupObject getInfoPopupObject(String name) {
  InfoPopData infoPopData = InfoPopData();
  return infoPopData.data[name] ?? InfoPopupObject.empty();
}
