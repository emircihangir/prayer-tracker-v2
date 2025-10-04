import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayertracker/prayer_button.dart';

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
  return CupertinoPageScaffold(child: Center(child: Text('Hi')));
}
