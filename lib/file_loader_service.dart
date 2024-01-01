import 'dart:convert';
import 'dart:developer';
import 'dart:io';

/// Class to handle reading and writing  files.

class FileLoaderService {
  /// Synchronously opens a file from [filePath]. and returns the contents as a
  /// [String].
  String loadData({required final String filePath}) =>
      File(filePath).readAsStringSync();

  /// Writes a json file from a [Map].
  Future<void> writeJsonFile(
      {required final String filePath, required final Map contents}) async {
    try {
      await File(filePath).writeAsString(jsonEncode(contents));
    } catch (e, st) {
      log(e.toString(), stackTrace: st, name: 'writeJsonFile');
    }
  }

  /// Takes a [List], and writes a file to given [filePath], creating a new
  ///  line for each list item.
  Future<void> writeListToTxtFile(
      {required final List<dynamic> list,
      required final String filePath}) async {
    final File file = File(filePath);

    final IOSink sink = file.openWrite();

    for (final line in list) {
      sink.writeln(line);
    }

    await sink.flush();
    await sink.close();
  }

  ///Takes a file string from [loadData] and parses it into a List<List<String>>
  List<List<String>> parseLines(String input) {
    final List<String> lines = input.split('\n');
    final List<List<String>> result = [];
    for (final String line in lines) {
      result.add(line.split(','));
    }

    return result;
  }

  Future<List<List<String>>> readCsvFile(String filePath) async {
    final file = File(filePath);
    final List<List<String>> csvData = [];

    try {
      final List<String> lines = await file.readAsLines();
      for (final line in lines) {
        csvData.add(_parseCsvLine(line));
      }
    } catch (e) {
      print('Error reading file: $e');
    }

    return csvData;
  }

  List<String> _parseCsvLine(String line) {
    final List<String> fields = [];
    bool inQuotes = false;
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < line.length; i++) {
      if (line[i] == '"') {
        inQuotes = !inQuotes; // Toggle the inQuotes state
        continue;
      }

      if (line[i] == ',' && !inQuotes) {
        fields.add(buffer.toString());
        buffer.clear();
        continue;
      }

      buffer.write(line[i]);
    }

    // Add the last field
    fields.add(buffer.toString());

    return fields;
  }
}
