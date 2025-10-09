import 'package:flutter/material.dart';
import 'package:prayertracker/prayer_button.dart';

class DateRow extends StatelessWidget {
  final DateTime date;
  const DateRow({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    String dateToString(DateTime d) {
      return '${d.year}-${d.month}-${d.day}';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Date"),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PrayerButton(buttonID: "${dateToString(date)}-morning", buttonType: ButtonType.morning),
            PrayerButton(buttonID: "${dateToString(date)}-noon", buttonType: ButtonType.noon),
            PrayerButton(
              buttonID: "${dateToString(date)}-afternoon",
              buttonType: ButtonType.afternoon,
            ),
            PrayerButton(buttonID: "${dateToString(date)}-night", buttonType: ButtonType.night),
            PrayerButton(buttonID: "${dateToString(date)}-evening", buttonType: ButtonType.evening),
          ],
        ),
      ],
    );
  }
}
