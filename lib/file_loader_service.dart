import 'dart:convert';
import 'dart:developer';
import 'dart:io';

/// Class to handle reading and writing  files.

class FileLoaderService {
  /// Synchronously opens a file from [path]. and returns the contents as a
  /// [String].
  String loadData(final String path) => File(path).readAsStringSync();

  /// Writes a json file from a [Map].
  Future<void> writeJsonFile(final String filePath, final Map contents) async {
    try {
      await File(filePath).writeAsString(jsonEncode(contents));
    } catch (e, st) {
      log(e.toString(), stackTrace: st, name: 'writeJsonFile');
    }
  }

  /// Takes a [List], and writes a file to given [path], creating a new
  ///  line for each list item.
  Future<void> writeListToTxtFile(
      {required final List<dynamic> list, required final String path}) async {
    final File file = File(path);

    final IOSink sink = file.openWrite();

    for (final line in list) {
      sink.writeln(line);
    }

    await sink.flush();
    await sink.close();
  }
}
