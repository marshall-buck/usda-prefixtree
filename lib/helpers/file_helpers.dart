import 'dart:convert';
import 'dart:io';

/// Reads a JSON file from a path.
///
/// Parameters:
/// [filePath]
///
/// Returns [map]
Future<Map> readJsonFile(final String filePath) async {
  var input = await File(filePath).readAsString();
  var map = jsonDecode(input);

  return map;
}

/// Write a json file form a Map
///
/// Parameters:
/// [filePath]
/// [contents] - type [Map]
Future<void> writeJsonFile(final String filePath, final Map contents) async {
  try {
    await File(filePath).writeAsString(jsonEncode(contents));
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}
