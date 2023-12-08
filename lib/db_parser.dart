import 'dart:convert';

import 'package:usda_db_creation/file_loader_service.dart';

class DBParser {
  FileLoaderService fileLoader;
  Map<dynamic, dynamic>? _dbMap;

// This is a list of food items from the database.
  List<dynamic> get foodsDBMap => _dbMap?['SRLegacyFoods'];

  DBParser({final FileLoaderService? fileLoader})
      : fileLoader = fileLoader ?? FileLoaderService();
// Opens the main usda database json file, and creates the map to
// use when parsing the database.
  void init(final String path) {
    final file = fileLoader.loadData(path);
    _dbMap = jsonDecode(file);
  }
}
