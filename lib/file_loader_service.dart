import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:usda_db_creation/global_const.dart';

/// Class to handle reading and writing  files.
// TODO: Add date now for hash for each save method
class FileLoaderService {
  final DateTime _fileHash = DateTime.now();

  String get fileHash => convertTimestampToDateString();

  String convertTimestampToDateString() {
    final now = '$_fileHash';
    return now.replaceAll(" ", "_");
  }

// ************************** File Writers **************************

  /// Writes the contents to a file based on its type.
  /// Appends a _fileHash folder to the path.
  Future<void> writeFileByType<T>({
    required final String fileName,
    required final T contents,
    bool convertKeysToStrings = false,
  }) async {
    try {
      _checkAndCreateFolder();

      final String filePath = '$pathToFiles/$fileHash/$fileName';

      if (contents is List) {
        await writeListToTxtFile(filePath: filePath, contents: contents);
      } else if (contents is Map) {
        await writeJsonFile(
          filePath: filePath,
          contents: contents,
          convertKeysToStrings: convertKeysToStrings,
        );
      } else {
        throw ArgumentError('Unsupported type for contents: writeFileByType');
      }
    } catch (e, st) {
      log(e.toString(), stackTrace: st, name: 'writeFileByType');
    }
  }

  Future<void> writeJsonFile({
    required final String filePath,
    required final Map<dynamic, dynamic> contents,
    bool convertKeysToStrings = false,
  }) async {
    try {
      Map mapToWrite;
      if (convertKeysToStrings) {
        mapToWrite =
            contents.map((key, value) => MapEntry(key.toString(), value));
      } else {
        mapToWrite = contents;
      }
      await File(filePath).writeAsString(jsonEncode(mapToWrite));
    } catch (e, st) {
      log(e.toString(), stackTrace: st, name: 'writeJsonFile');
    }
  }

  /// Takes a [List], and writes a file to given [filePath], creating a new
  ///  line for each list item.
  Future<void> writeListToTxtFile({
    required final String filePath,
    required final List<dynamic> contents,
  }) async {
    try {
      final File file = File(filePath);

      final IOSink sink = file.openWrite();

      for (final line in contents) {
        sink.writeln(line);
      }

      await sink.flush();
      await sink.close();
    } catch (e, st) {
      log(e.toString(), stackTrace: st, name: 'writeListToTxtFile');
    }
  }

  /// Synchronously opens a file from [filePath]. and returns the contents as a
  /// [String].
  String loadData({required final String filePath}) =>
      File(filePath).readAsStringSync();

  /// Checks if the specified folder path exists and creates it if it doesn't.
  void _checkAndCreateFolder() {
    final directory = Directory('$pathToFiles/$fileHash');
    if (!directory.existsSync()) {
      try {
        directory.createSync(recursive: true);
      } catch (e, st) {
        throw Exception(
            'Failed to create folder: $pathToFiles/$fileHash\n$e\n$st');
      }
    }
  }

// ************************** File Readers **************************

  ///
  /// Reads a CSV file from the given [filePath] and returns its contents as a
  /// list of lists of strings.
  ///
  /// Each inner list represents a row in the CSV file, and each string represents a cell value.

  Future<List<List<String>>> readCsvFile(String filePath) async {
    final file = File(filePath);
    final List<List<String>> csvData = [];

    try {
      final List<String> lines = await file.readAsLines();
      for (final line in lines) {
        csvData.add(_parseCsvLine(line));
      }
    } catch (e, st) {
      log(e.toString(), stackTrace: st, name: 'readCsvFile');
    }

    return csvData;
  }

  /// Parses a CSV line and returns a list of fields.
  ///
  /// The [line] parameter represents a single line of a CSV file.
  /// This method iterates over each character in the line and extracts
  /// the fields separated by commas. If a field is enclosed in double quotes,
  /// it is treated as a single field even if it contains commas.
  ///
  /// Returns a list of strings representing the fields in the CSV line.

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
