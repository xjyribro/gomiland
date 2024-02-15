import 'package:gomiland/constants/info_text.dart';

class InfoPopupObject {
  String text;
  String? imgPath;

  InfoPopupObject({
    required this.text,
    this.imgPath,
  });

  InfoPopupObject.empty() : this(text: '');
}

class InfoPopData {
  InfoPopData() {
    // Hood
    _data['how_to_play'] = InfoPopupObject(text: InfoText.how_to_play);
    _data['construction_site'] =
        InfoPopupObject(text: InfoText.construction_site);
    _data['soup_kitchen'] = InfoPopupObject(text: InfoText.soup_kitchen);
    _data['charging_kisok'] = InfoPopupObject(text: InfoText.charging_kisok);
    _data['garden'] = InfoPopupObject(text: InfoText.garden);
    _data['cafe'] = InfoPopupObject(text: InfoText.cafe);
    _data['friendship_square'] =
        InfoPopupObject(text: InfoText.friendship_square);
    _data['park_sign'] = InfoPopupObject(text: InfoText.park_sign);
    // Park
    _data['zen_garden'] = InfoPopupObject(text: InfoText.zen_garden);
    _data['shrine_complex'] = InfoPopupObject(text: InfoText.shrine_complex);
    _data['bamboo_forest'] = InfoPopupObject(text: InfoText.bamboo_forest);
    _data['hood_sign'] = InfoPopupObject(text: InfoText.hood_sign);
    _data['park_centre'] = InfoPopupObject(text: InfoText.park_centre);
    _data['castle'] = InfoPopupObject(text: InfoText.castle);
    _data['sakuras'] = InfoPopupObject(text: InfoText.sakuras);
    _data['bee_colony'] = InfoPopupObject(text: InfoText.bee_colony);
    _data['world_forest'] = InfoPopupObject(text: InfoText.world_forest);
    // Room
    _data['how_to_sort'] = InfoPopupObject(text: InfoText.how_to_sort);
  }

  final Map<String, InfoPopupObject> _data = {};

  Map<String, InfoPopupObject> get data => _data;
}

InfoPopupObject getInfoPopupObject(String name) {
  InfoPopData infoPopData = InfoPopData();
  return infoPopData.data[name] ?? InfoPopupObject.empty();
}
