import 'dart:convert';
import 'dart:io';

/// Reads a JSON file from a [filePath].
///
/// Returns a [Map]
Future<Map> readJsonFile(final String filePath) async {
  final input = await File(filePath).readAsString();
  final map = jsonDecode(input);

  return map;
}

/// Write a json file from a [Map].

Future<void> writeJsonFile(final String filePath, final Map contents) async {
  try {
    await File(filePath).writeAsString(jsonEncode(contents));
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}
