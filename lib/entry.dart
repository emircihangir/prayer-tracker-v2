import 'package:intl/intl.dart';

enum PrayerValue {
  empty(0),
  half(1),
  full(2);

  final int value;
  const PrayerValue(this.value);
}

enum PrayerKind { morning, noon, afternoon, night, evening }

/// CSV format: date,morning,noon,afternoon,night,evening
///
/// Example: 2025-10-09,0,1,2,0,1
class Entry {
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final DateTime date;
  final PrayerValue morningValue;
  final PrayerValue noonValue;
  final PrayerValue afternoonValue;
  final PrayerValue nightValue;
  final PrayerValue eveningValue;

  static DateFormat dateFormat() => _dateFormat;

  Entry({
    required this.date,
    this.morningValue = PrayerValue.empty,
    this.noonValue = PrayerValue.empty,
    this.afternoonValue = PrayerValue.empty,
    this.nightValue = PrayerValue.empty,
    this.eveningValue = PrayerValue.empty,
  });

  Entry copyWith({
    PrayerValue? newMorningValue,
    PrayerValue? newNoonValue,
    PrayerValue? newAfternoonValue,
    PrayerValue? newNightValue,
    PrayerValue? newEveningValue,
  }) => Entry(
    date: date,
    morningValue: newMorningValue ?? morningValue,
    noonValue: newNoonValue ?? noonValue,
    afternoonValue: newAfternoonValue ?? afternoonValue,
    nightValue: newNightValue ?? nightValue,
    eveningValue: newEveningValue ?? eveningValue,
  );

  Entry toggleValue(PrayerKind prayerKind) {
    final currentValue = getPrayerValue(prayerKind).value;
    final newValue = PrayerValue.values[(currentValue + 1) % 3];
    return setPrayerValue(prayerKind, newValue);
  }

  PrayerValue getPrayerValue(PrayerKind prayerKind) {
    switch (prayerKind) {
      case PrayerKind.morning:
        return morningValue;

      case PrayerKind.noon:
        return noonValue;

      case PrayerKind.afternoon:
        return afternoonValue;

      case PrayerKind.night:
        return nightValue;

      case PrayerKind.evening:
        return eveningValue;
    }
  }

  Entry setPrayerValue(PrayerKind prayerKind, PrayerValue value) {
    switch (prayerKind) {
      case PrayerKind.morning:
        return copyWith(newMorningValue: value);

      case PrayerKind.noon:
        return copyWith(newNoonValue: value);

      case PrayerKind.afternoon:
        return copyWith(newAfternoonValue: value);

      case PrayerKind.night:
        return copyWith(newNightValue: value);

      case PrayerKind.evening:
        return copyWith(newEveningValue: value);
    }
  }

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
      morningValue: parsedMorning,
      noonValue: parsedNoon,
      afternoonValue: parsedAfternoon,
      nightValue: parsedNight,
      eveningValue: parsedEvening,
    );
  }

  @override
  String toString() {
    return "${_dateFormat.format(date)},${morningValue.value},${noonValue.value},${afternoonValue.value},${nightValue.value},${eveningValue.value}";
  }
}
