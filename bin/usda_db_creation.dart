// ignore_for_file: unused_import

import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';

import 'package:usda_db_creation/file_loader_service.dart';
import 'package:usda_db_creation/global_const.dart';
import 'package:usda_db_creation/usda_db.dart' as db;

// import '../test/create_word_index_test.dart';

const relativeOriginalDBPath = 'lib/db/original_usda.json';
const relativeRepeatFile = 'lib/db/repeats.txt';

void main() async {
  final fileLoaderService = FileLoaderService();
  // ignore: unused_local_variable
  final dbParser = DBParser.init(
      path: relativeOriginalDBPath, fileLoaderService: fileLoaderService);

  await db.replenishFullDatabase(
      fileLoaderService: fileLoaderService, dbParser: dbParser);

  // await db.writeFoodDatabaseJsonFile(
  //     fileLoaderService: fileLoaderService, dbParser: dbParser);

  // final finalDescriptionRecords =
  //     DescriptionParser.createFinalDescriptionMapFromFile(
  //         path: '$pathToFiles/$fileNameFinalDescriptions',
  //         fileLoaderService: fileLoaderService);

  // final nutrientIds = db.findAllNutrientIds(
  //     finalDescriptionRecordsMap: finalDescriptionRecords,
  //     originalFoodsList: dbParser.originalFoodsList);

  // await db.writeNutrientMapJsonFile(fileLoaderService: fileLoaderService);
  // await db.createNutrientMap(fileLoaderService: fileLoaderService);

  // final x = fileLoaderService.loadData(filePath: '$pathToFiles/test.csv');

  //     fileLoaderService: fileLoaderService, dbParser: dbParser);

  // await db.writeAutocompleteHashToFile(fileLoaderService: fileLoaderService);

  // await db.writeDescriptionsToFile(
  //     fileLoaderService: fileLoaderService, dbParser: dbParser);
  // await db.writeAutocompleteWordIndexToFile(
  //     fileLoaderService: fileLoaderService);
}
