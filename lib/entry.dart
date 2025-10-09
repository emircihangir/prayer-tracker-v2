import 'package:intl/intl.dart';
import 'package:prayertracker/prayer_button.dart';

/// CSV format: date,morning,noon,afternoon,night,evening
///
/// Example: 2025-10-09,0,1,2,0,1
class Entry {
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final DateTime date;
  final PrayerValue morning;
  final PrayerValue noon;
  final PrayerValue afternoon;
  final PrayerValue night;
  final PrayerValue evening;

  const Entry({
    required this.date,
    this.morning = PrayerValue.empty,
    this.noon = PrayerValue.empty,
    this.afternoon = PrayerValue.empty,
    this.night = PrayerValue.empty,
    this.evening = PrayerValue.empty,
  });

  static PrayerValue _parsePrayerValue(String s) {
    int? valueIndex = int.tryParse(s);
    if (valueIndex == null || valueIndex < 0 || valueIndex >= PrayerValue.values.length) {
      throw FormatException('Invalid PrayerValue index: $s');
    }
    return PrayerValue.values[valueIndex];
  }

  factory Entry.fromString(String s) {
    List<String> sSplit = s.split(',');

    if (sSplit.length != 6) {
      throw FormatException(
        'Invalid string format. Expected 6 comma-separated values, but got ${sSplit.length}.',
      );
    }

    DateTime? parsedDate = _dateFormat.tryParse(sSplit[0]);
    if (parsedDate == null) {
      throw FormatException('Invalid date string: ${sSplit[0]}');
    }

    PrayerValue parsedMorning = _parsePrayerValue(sSplit[1]);
    PrayerValue parsedNoon = _parsePrayerValue(sSplit[2]);
    PrayerValue parsedAfternoon = _parsePrayerValue(sSplit[3]);
    PrayerValue parsedNight = _parsePrayerValue(sSplit[4]);
    PrayerValue parsedEvening = _parsePrayerValue(sSplit[5]);

    return Entry(
      date: parsedDate,
      morning: parsedMorning,
      noon: parsedNoon,
      afternoon: parsedAfternoon,
      night: parsedNight,
      evening: parsedEvening,
    );
  }

  @override
  String toString() {
    return "${_dateFormat.format(date)},${morning.value},${noon.value},${afternoon.value},${night.value},${evening.value}";
  }
}
