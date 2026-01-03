import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:prayertracker/constants.dart';
import 'package:prayertracker/entry.dart';

class IO {
  static late final Directory appDocumentsDir;
  static late final String cookiesFilePath;
  static late final File cookiesFile;
  static late final String dataFilePath;
  static late final File dataFile;
  static late final Map cookiesFileInitialData;
  static late final Map<String, Entry> dataFileInitialData;

  static Future<void> initializeDataFiles() async {
    appDocumentsDir = await getApplicationDocumentsDirectory();

    cookiesFilePath = path.join(appDocumentsDir.path, Constants.cookiesFileName);
    cookiesFile = File(cookiesFilePath);

    dataFilePath = path.join(appDocumentsDir.path, Constants.dataFileName);
    dataFile = File(dataFilePath);

    // * Check if the data files exist.
    final bool cookiesFileExists = await cookiesFile.exists();

    if (cookiesFileExists == false) {
      // * Create the cookies file.
      DateTime originDate = DateTime.now();
      String originDateString = Entry.dateFormat().format(originDate);
      final Map cookiesValue = {CookiesData.originDate.keyName: originDateString};
      final String cookiesValueJSONstring = jsonEncode(cookiesValue);
      await cookiesFile.writeAsString(cookiesValueJSONstring);
      log(name: "Logic", "Created ${Constants.cookiesFileName}");

      // * Create the data file.
      final Entry firstEntry = Entry(date: DateTime.now());
      await dataFile.writeAsString(firstEntry.toString());
      log(name: "Logic", "Created ${Constants.dataFileName}");
    }

    dataFileInitialData = await loadAppData();
    cookiesFileInitialData = await loadCookiesData();
  }

  static Future<Map> loadCookiesData() async {
    String cookiesFileContent = await cookiesFile.readAsString();
    return jsonDecode(cookiesFileContent);
  }

  static Future<Map<String, Entry>> loadAppData() async {
    List<String> appDataContent = await dataFile.readAsLines();
    List<Entry> appData = appDataContent.map((e) => Entry.fromString(e)).toList();
    Map<String, Entry> result = Map.fromEntries(
      appData.map((e) => MapEntry(Entry.dateFormat().format(e.date), e)),
    );
    return result;
  }
}
