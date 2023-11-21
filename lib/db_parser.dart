import 'dart:convert';

import 'package:usda_db_creation/file_loader_service.dart';

class DBParser {
  FileLoaderService fileLoader;
  Map<dynamic, dynamic>? _dbMap;

  List<dynamic> get dbMap => _dbMap?['SRLegacyFoods'];

  DBParser({FileLoaderService? fileLoader})
      : fileLoader = fileLoader ?? FileLoaderService();

  void init(String path) {
    final file = fileLoader.loadData(path);
    _dbMap = jsonDecode(file);
  }
}
