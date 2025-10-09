import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:prayertracker/date_row.dart';
import 'package:prayertracker/header_row.dart';

final buttonStates = StateProvider<Map<String, int>>((ref) => {});

void main() {
  runApp(ProviderScope(child: const IOSapp()));
}

class IOSapp extends StatelessWidget {
  const IOSapp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) {
          return homePage();
        },
      },
    );
  }
}

CupertinoPageScaffold homePage() {
  return CupertinoPageScaffold(
    child: SafeArea(
      child: Column(
        children: [
          HeaderRow(),
          Expanded(
            child: ListView.builder(
              itemCount: 60,
              itemBuilder: (context, index) {
                final date = DateTime(2025, 10, 4).subtract(Duration(days: index));
                return DateRow(date: date);
              },
            ),
          ),
        ],
      ),
    ),
  );
}
