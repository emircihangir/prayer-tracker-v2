import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayertracker/entries_provider.dart';
import 'package:prayertracker/entry.dart';
import 'package:prayertracker/entry_widget.dart';

Map<String, Entry> generateDummyData(int n) {
  DateTime originDate = DateTime(2025, 11, 16);
  Map<String, Entry> result = {};
  for (var i = 0; i < n; i++) {
    final newDate = originDate.subtract(Duration(days: i));
    final String newDateString = Entry.dateFormat().format(newDate);
    result[newDateString] = Entry(date: newDate);
  }
  return result;
}

void main() {
  runApp(ProviderScope(child: const App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesMap = ref.watch(entriesProvider);
    final entryList = entriesMap.values.toList();

    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        body: SafeArea(
          child: ListView.builder(
            itemCount: entryList.length,
            itemBuilder: (context, index) {
              return EntryWidget(entry: entryList[index]);
            },
          ),
        ),
      ),
    );
  }
}
