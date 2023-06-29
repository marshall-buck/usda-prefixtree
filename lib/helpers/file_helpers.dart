import 'dart:convert';
import 'dart:io';

/// Reads a JSON file from [filePath], Returns a Map[map]
Future<Map> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();
  var map = jsonDecode(input);

  return map;
}

// Write a json file to disk
Future<void> writeJsonFile(String filePath, Object contents) async {
  try {
    await File(filePath).writeAsString(jsonEncode(contents));
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}
