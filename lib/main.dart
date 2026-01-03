import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayertracker/entries_provider.dart';
import 'package:prayertracker/entry_widget.dart';
import 'package:prayertracker/io.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IO.initializeDataFiles();
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
