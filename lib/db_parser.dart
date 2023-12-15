import 'dart:convert';

import 'package:usda_db_creation/file_loader_service.dart';

class DBParser {
  FileLoaderService fileLoader;
  Map<dynamic, dynamic>? _dbMap;

  /// [List] of foods from the database.
  List<dynamic> get foodsDBMap => _dbMap?['SRLegacyFoods'];

  DBParser({final FileLoaderService? fileLoader})
      : fileLoader = fileLoader ?? FileLoaderService();

  /// Populates the _dbMap
  void init(final String path) {
    final file = fileLoader.loadData(path);
    _dbMap = jsonDecode(file);
  }

  (Map<String, int>, int) getFoodCategories() {
    final Map<String, int> categories = {};
    int count = 0;
    for (final food in foodsDBMap) {
      final obj = food['foodCategory'];
      final cat = obj['description'];
      if (categories.containsKey(cat)) {
        categories[cat] = categories[cat]! + 1;
        count++;
      } else {
        categories[cat] = 1;
        count++;
      }
    }

    return (categories, count);
  }
}
