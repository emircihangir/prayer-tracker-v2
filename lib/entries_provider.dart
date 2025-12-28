import 'package:prayertracker/entry.dart';
import 'package:prayertracker/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entries_provider.g.dart';

@riverpod
class Entries extends _$Entries {
  @override
  Map<String, Entry> build() {
    return generateDummyData(10);
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
