import 'package:prayertracker/constants.dart';
import 'package:prayertracker/entry.dart';
import 'package:prayertracker/io.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entries_provider.g.dart';

@riverpod
class Entries extends _$Entries {
  @override
  Map<String, Entry> build() {
    final String originDateString = IO.cookiesFileInitialData[CookiesData.originDate.keyName];
    // TODO: Add the final modifier.
    DateTime originDate = Entry.dateFormat().parse(originDateString);

    // TODO: Test value. Delete it before production.
    originDate = originDate.add(Duration(days: -30));

    Map<String, Entry> result = {};
    DateTime currentDate = DateTime.now();

    while (currentDate.isOneDayBefore(originDate) == false) {
      String currentDateString = Entry.dateFormat().format(currentDate);
      bool dateExists = IO.dataFileInitialData.containsKey(currentDateString);

      if (dateExists) {
        result[currentDateString] = IO.dataFileInitialData[currentDateString]!;
      } else {
        result[currentDateString] = Entry(date: currentDate);
      }

      currentDate = currentDate.add(Duration(days: -1));
    }

    return result;
  }

  void update(String entryID, PrayerKind prayerKind) {
    Entry? entry = state[entryID];
    if (entry == null) {
      throw ArgumentError('Invalid entry ID: $entryID');
    }

    Entry newEntry = entry.toggleValue(prayerKind);
    state = {...state, entryID: newEntry};
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isOneDayBefore(DateTime other) => isSameDay(other.add(Duration(days: -1)));
}
