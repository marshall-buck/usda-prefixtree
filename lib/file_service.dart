import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:usda_db_creation/extensions/map_ext.dart';
import 'package:path/path.dart' as p;

/// Class to handle reading and writing  files.

class FileService {
  final pathToFiles = p.join('lib', 'db');

  late final fileNameOriginalDBFile =
      p.join(pathToFiles, 'do_not_delete', 'original_usda.json');
  late final fileNameNutrientsCsv =
      p.join(pathToFiles, 'do_not_delete', 'nutrient.csv');
  late final fileNameNutrientsMap =
      p.join(pathToFiles, 'do_not_delete', 'original_nutrient_csv.json');

  static const fileNameDuplicatePhrases = 'duplicate_phrases';
  static const fileNameOriginalDescriptions = 'original_descriptions.txt';
  static const fileNameFinalDescriptions = 'descriptions';
  static final fileNameSubstrings = 'substrings';

  static const fileNameAutocompleteWordIndex = 'autocomplete_word_index';
  static const fileNameAutocompleteWordIndexKeys =
      'autocomplete_word_index_keys';
  static const fileNameAutocompleteHash = 'autocomplete_hash';
  static const fileNameFoodsDatabase = 'foods_db';

  /// Loads a DateTime sting at initialization so all
  /// Prefixes wil be the same.
  String folderHash =
      '${DateTime.now()}'.replaceAll(RegExp(r'[\\/:*?"<>|\s]'), '_');

  String get fileHash => folderHash.substring(folderHash.indexOf('.') + 1);

// ************************** File Writers **************************

  /// Writes the contents to files based on their types.
  /// Appends a [folderHash] folder to the path.
  Future<void> writeFileByType<T, U>({
    required final String fileName,
    required final bool convertKeysToStrings,
    T? listContents,
    U? mapContents,
  }) async {
    if (listContents == null && mapContents == null) {
      throw ArgumentError('No contents provided: writeFileByType');
    }

    try {
      checkAndCreateFolder();

      if (listContents != null && listContents is List) {
        final String listFilePath = p.join(pathToFiles, folderHash,
            '${fileHash}_$fileName.txt'); // '$pathToFiles/$fileHash/$fileName.txt';
        await _writeListToTxtFile(
            filePath: listFilePath, contents: listContents);
      }

      if (mapContents != null && mapContents is Map) {
        final String mapFilePath = p.join(pathToFiles, folderHash,
            '${fileHash}_$fileName.json'); //'$pathToFiles/$fileHash/$fileName.json';
        final Map convertedMap = convertKeysToStrings
            ? mapContents.deepConvertMapKeyToString()
            : mapContents;
        await _writeJsonFile(filePath: mapFilePath, contents: convertedMap);
      }
    } catch (e, st) {
      log(e.toString(), stackTrace: st, name: 'writeFileByType');
    }
  }

  Future<void> _writeJsonFile({
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
  Future<void> _writeListToTxtFile({
    required final String filePath,
    required final List<dynamic> contents,
  }) async {
    try {
      final File file = File(filePath);

      final IOSink sink = file.openWrite();

      // Write the lines, if line is the last line, don't add \n
      for (int i = 0; i < contents.length; i++) {
        final line = contents[i];
        if (i == contents.length - 1) {
          sink.write(line);
        } else {
          sink.writeln(line);
        }
      }

      await sink.flush();
      await sink.close();
    } catch (e, st) {
      log(e.toString(), stackTrace: st, name: 'writeListToTxtFile');
    }
  }

  /// Checks if the specified folder path exists and creates it if it doesn't.
  void checkAndCreateFolder() {
    final path = p.join(pathToFiles, folderHash);
    final directory = Directory(path);
    if (!directory.existsSync()) {
      try {
        directory.createSync(recursive: true);
      } catch (e, st) {
        throw Exception(
            'Failed to create folder in _checkAndCreateFolder: $path.  Error: $e, StackTrace: $st');
      }
    }
  }

// ************************** File Readers **************************

  /// Synchronously opens a file from [filePath].  Returns the contents as a [String].
  String loadData({required final String filePath}) {
    final file = File(filePath);
    final String contents = file.readAsStringSync();
    if (!file.existsSync()) {
      throw FileSystemException('File not found', filePath);
    }
    return contents;
  }

  /// Reads a CSV file from the given [filePath] and returns its contents as a
  /// list of lists of strings.
  ///
  /// Each inner list represents a row in the CSV file,
  /// and each string represents a cell value.
  /// [[cell1, cell2, cell3], [cell1, cell2, cell3]]
  Future<List<List<String>>> readCsvFile(
      {required final String filePath}) async {
    final file = File(filePath);
    final List<List<String>> csvData = [];

    if (!file.existsSync()) {
      throw FileSystemException('File not found', filePath);
    }
    final List<String> lines = await file.readAsLines();
    for (final line in lines) {
      csvData.add(_parseCsvLine(line));
    }

    return csvData;
  }

  /// Parses a CSV line and returns a list of fields.
  ///
  /// This is used for csv files
  ///
  /// The [line] parameter represents a single line of a CSV file.
  /// This method iterates over each character in the line and extracts
  /// the fields separated by commas.
  ///
  /// If a field is enclosed in double quotes,
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
