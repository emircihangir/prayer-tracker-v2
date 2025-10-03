import 'package:flutter/cupertino.dart';

void main() {
  runApp(const IOSapp());
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
