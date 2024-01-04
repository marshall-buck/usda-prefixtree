// ignore_for_file: unused_import

import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';

import 'package:usda_db_creation/file_loader_service.dart';
import 'package:usda_db_creation/global_const.dart';
import 'package:usda_db_creation/usda_db.dart' as db;

void main() async {
  // Initialize the file loader service. The filename hash is created in the FileLoaderService class.
  final fileLoaderService = FileLoaderService();

  final dbParser = DBParser.init(
      filePath: '$pathToFiles/$fileNameOriginalDBFile',
      fileLoaderService: fileLoaderService);

  final descriptions = DescriptionParser();

  await descriptions.createDescriptionMap(
      dbParser: dbParser,
      writeListToFile: true,
      writeMapToFile: true,
      returnMap: false);

  // await db.replenishFullDatabase(
  //     fileLoaderService: fileLoaderService, dbParser: dbParser);
}
