import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayertracker/entry.dart';

enum CookiesData {
  originDate('originDate');

  final String keyName;
  const CookiesData(this.keyName);
}

class Constants {
  static const cookiesFileName = "cookies.json";
  static const dataFileName = "data.csv";
  static final DateFormat uiDateFormat = DateFormat('MMMM d');

  static const Map<PrayerValue?, Color> prayerValueToColor = {
    null: Colors.yellow,
    PrayerValue.empty: Colors.transparent,
    PrayerValue.half: Colors.grey,
    PrayerValue.full: Colors.black,
  };
}
