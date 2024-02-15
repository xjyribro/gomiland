enum DayOfWeek {monday, tuesday, wednesday, thursday, friday, saturday, sunday}

class DayOfWeekStrings {
  static const String monday = 'Monday';
  static const String tuesday = 'Tuesday';
  static const String wednesday = 'Wednesday';
  static const String thursday = 'Thursday';
  static const String friday = 'Friday';
  static const String saturday = 'Saturday';
  static const String sunday = 'Sunday';
}

extension DayOfWeekExtension on DayOfWeek {
  String get string {
    switch (this) {
      case DayOfWeek.monday:
        return DayOfWeekStrings.monday;
      case DayOfWeek.tuesday:
        return DayOfWeekStrings.tuesday;
      case DayOfWeek.wednesday:
        return DayOfWeekStrings.wednesday;
      case DayOfWeek.thursday:
        return DayOfWeekStrings.thursday;
      case DayOfWeek.friday:
        return DayOfWeekStrings.friday;
      case DayOfWeek.saturday:
        return DayOfWeekStrings.saturday;
      case DayOfWeek.sunday:
        return DayOfWeekStrings.sunday;
      default:
        return DayOfWeekStrings.sunday;
    }
  }
}

extension GetDayOfWeek on String {
  DayOfWeek get dayOfWeek {
    switch (this) {
      case DayOfWeekStrings.monday:
        return DayOfWeek.monday;
      case DayOfWeekStrings.tuesday:
        return DayOfWeek.tuesday;
      case DayOfWeekStrings.wednesday:
        return DayOfWeek.wednesday;
      case DayOfWeekStrings.thursday:
        return DayOfWeek.thursday;
      case DayOfWeekStrings.friday:
        return DayOfWeek.friday;
      case DayOfWeekStrings.saturday:
        return DayOfWeek.saturday;
      case DayOfWeekStrings.sunday:
        return DayOfWeek.sunday;
      default:
        return DayOfWeek.sunday;
    }
  }
}