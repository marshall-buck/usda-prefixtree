import 'dart:convert';
import 'dart:io';

/// Reads a JSON file from a path.
///
/// Parameters:
/// [filePath]
///
/// Returns [map]
Future<Map> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();
  var map = jsonDecode(input);

  return map;
}

/// Write a json file form a Ma
///
/// Parameters:
/// [filePath]
/// [contents] - type [Map]
Future<void> writeJsonFile(String filePath, Map contents) async {
  try {
    await File(filePath).writeAsString(jsonEncode(contents));
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}
