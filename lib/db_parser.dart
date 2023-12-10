import 'dart:convert';

import 'package:usda_db_creation/file_loader_service.dart';

class DBParser {
  FileLoaderService fileLoader;
  Map<dynamic, dynamic>? _dbMap;

  /// [List] of foods from the database.
  List<dynamic> get foodsDBMap => _dbMap?['SRLegacyFoods'];

  DBParser({final FileLoaderService? fileLoader})
      : fileLoader = fileLoader ?? FileLoaderService();

  /// Populates the the
  void init(final String path) {
    final file = fileLoader.loadData(path);
    _dbMap = jsonDecode(file);
  }
}
