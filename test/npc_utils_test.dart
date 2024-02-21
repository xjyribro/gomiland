import 'package:flutter_test/flutter_test.dart';
import 'package:gomiland/constants/constants.dart';
import 'package:gomiland/game/npcs/utils.dart';

void main() {
  test('test getTimeOfDay', () {
    const int midnight = nightStartMins;
    const int dawn = morningStartMins - 1;
    const int morning = morningStartMins;
    const int prenoon = afternoonStartMins - 1;
    const int afternoon = afternoonStartMins;
    const int dusk = eveningStartMins - 1;
    const int evening = eveningStartMins;

    expect(getTimeOfDay(midnight), 'evening');
    expect(getTimeOfDay(dawn), 'evening');
    expect(getTimeOfDay(morning), 'morning');
    expect(getTimeOfDay(prenoon), 'morning');
    expect(getTimeOfDay(afternoon), 'afternoon');
    expect(getTimeOfDay(dusk), 'afternoon');
    expect(getTimeOfDay(evening), 'evening');
  });
}
