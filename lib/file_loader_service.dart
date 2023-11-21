import 'dart:convert';
import 'dart:developer';
import 'dart:io';

/// Class to load json file.  It only has one method,
/// but I did this to make testing easier.
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
}
