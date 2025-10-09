import 'package:flutter/material.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Date", style: TextStyle(color: Colors.transparent)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/morning-empty.png", width: 32),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/noon-empty.png", width: 32),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/afternoon-empty.png", width: 32),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/night-empty.png", width: 32),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/evening-empty.png", width: 32),
            ),
          ],
        ),
      ],
    );
  }
}
