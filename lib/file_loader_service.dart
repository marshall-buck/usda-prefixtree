import 'dart:convert';
import 'dart:developer';
import 'dart:io';

/// Class to handle reading and writing json files.
/// May add some type of init method later
class FileLoaderService {
  String loadData(String path) => File(path).readAsStringSync();

  Future<void> writeJsonFile(String filePath, Map contents) async {
    try {
      await File(filePath).writeAsString(jsonEncode(contents));
    } catch (e, st) {
      log(e.toString(), stackTrace: st, name: 'writeJsonFile');
    }
  }

  Future<void> writeTextFile(List<String> list, String path) async {
    // Sort the list
    list.sort();

    // Create a new file, overwriting any existing file
    var file = File(path);

    // Open the file in write mode
    var sink = file.openWrite();

    // Write each line to the file
    for (var line in list) {
      sink.writeln(line);
    }

    // Close the file
    await sink.flush();
    await sink.close();
  }
}
