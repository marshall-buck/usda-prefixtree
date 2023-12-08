import 'dart:convert';
import 'dart:developer';
import 'dart:io';

/// Class to handle reading and writing json files.

class FileLoaderService {
  /// Using this method to open a file to a string
  /// will help with testing.
  String loadData(final String path) => File(path).readAsStringSync();

  /// Writes a json file from a [contents].
  Future<void> writeJsonFile(final String filePath, final Map contents) async {
    try {
      await File(filePath).writeAsString(jsonEncode(contents));
    } catch (e, st) {
      log(e.toString(), stackTrace: st, name: 'writeJsonFile');
    }
  }

  /// Takes a [List], and writes a file to given [path], creating a new
  ///  line for each list item
  Future<void> writeTextFile(final List<String> list, final String path) async {
    // Sort the list
    list.sort();

    // Create a new file, overwriting any existing file
    File file = File(path);

    // Open the file in write mode
    IOSink sink = file.openWrite();

    // Write each line to the file
    for (final line in list) {
      sink.writeln(line);
    }

    // Close the file
    await sink.flush();
    await sink.close();
  }
}
