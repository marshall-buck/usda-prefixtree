// This file is where the methods live that will be used in the
// bin/usda_db_creation.dart  file.
// The bin/usda_db_creation.dart is called when the user runs the command
// 'dart run'. Not all methods in this file are used in the bin/usda_db_creation.dart
// at the same time.

import 'package:usda_db_creation/autocomplete.dart';
import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';
import 'package:usda_db_creation/file_loader_service.dart';

import 'package:usda_db_creation/global_const.dart';
import 'package:usda_db_creation/nutrient.dart';

///************************* File Writers for individual tasks *************************************

/// Creates a duplicate phrases file based on parameters and writes to [path].
/// This is not used in the database, but is useful for finding ways to shorten
/// the descriptions.
Future<void> writeDuplicatePhrasesToFile(
    {final int minPhraseLength = 20,
    final minNumberOfDuplicatesToShow = 25,
    required final FileLoaderService fileLoaderService,
    required final DBParser dbParser}) async {
  final descriptionRecords = DescriptionParser.createOriginalDescriptionRecords(
      originalFoodsList: dbParser.originalFoodsList);

  final repeats = DescriptionParser.createRepeatedPhraseFrequencyMap(
      listOfRecords: descriptionRecords,
      minPhraseLength: minPhraseLength,
      minNumberOfDuplicatesToShow: minNumberOfDuplicatesToShow);

  await fileLoaderService.writeJsonFile(
      filePath: '$pathToFiles/$fileNameDuplicatePhrases', contents: repeats);
}

/// Creates a final_descriptions.txt file and writes to [path]. This is useful
/// to easily inspect the final descriptions.  It is not needed for the database.
Future<void> writeFinalDescriptionsTxtFile(
    {required final FileLoaderService fileLoaderService,
    required final DBParser dbParser}) async {
  final descriptions = DescriptionParser.createOriginalDescriptionRecords(
      originalFoodsList: dbParser.originalFoodsList);
  assert(descriptions.length == 7006);
  final descriptionsFinal =
      DescriptionParser.removeUnwantedPhrasesFromDescriptions(
          descriptions: descriptions, unwantedPhrases: unwantedPhrases);
  await fileLoaderService.writeListToTxtFile(
      list: descriptionsFinal,
      filePath: '$pathToFiles/$fileNameFinalDescriptionsTxt');
}

/// Creates the autocomplete word index map and writes to [path].
Future<void> writeAutocompleteWordIndexToFile({
  required final FileLoaderService fileLoaderService,
}) async {
  final descriptionMap = DescriptionParser.createFinalDescriptionMapFromTxtFile(
      filePath: '$pathToFiles/$fileNameFinalDescriptionsTxt',
      fileLoaderService: fileLoaderService);

  final indexMap = Autocomplete.createAutocompleteWordIndexMap(
      finalDescriptionMap: descriptionMap);
  await fileLoaderService.writeJsonFile(
      filePath: '$pathToFiles/$fileNameAutocompleteWordIndex',
      contents: indexMap);
  final indexKeys = indexMap.keys.toList();
  await fileLoaderService.writeListToTxtFile(
      list: indexKeys,
      filePath: '$pathToFiles/$fileNameAutocompleteWordIndexKeys');
}

/// Creates the autocomplete hash table and writes to [path].
Future<void> writeAutocompleteHashToFile({
  required final FileLoaderService fileLoaderService,
}) async {
  // Create the description map from file.
  final descriptionMap = DescriptionParser.createFinalDescriptionMapFromTxtFile(
      filePath: '$pathToFiles/$fileNameFinalDescriptionsTxt',
      fileLoaderService: fileLoaderService);

  // Create the autocomplete index map from the description map.
  final autoCompleteWordIndex = Autocomplete.createAutocompleteWordIndexMap(
      finalDescriptionMap: descriptionMap);

  // Create the substrings from the autocomplete index map.
  final substrings =
      Autocomplete.createOriginalSubstringMap(wordIndex: autoCompleteWordIndex);

  // Create the hash table from the substrings.
  final hash = Autocomplete.createAutocompleteHashTable(
      originalSubStringMap: substrings);

  await fileLoaderService.writeJsonFile(
      filePath: '$pathToFiles/$fileNameAutocompleteHash', contents: hash);
}

/// Method to create the foods database file
/// Format:
///   {"167512": {
///       "description":
///           "lorem ipsum dolor sit",
///       "nutrients": [
///         {"id": 1003, "amount": 5.88},
///         {"id": 1079, "amount": 1.2},
///         {"id": 1258, "amount": 2.94},
///         {"id": 1004, "amount": 13.2},
///         {"id": 1005, "amount": 41.2},
///         {"id": 1008, "amount": 307},
///         {"id": 2000, "amount": 5.88}, ...
///       ]
///     }, ...
///  }
Future<void> writeFoodDatabaseJsonFile({
  required final FileLoaderService fileLoaderService,
  required final DBParser dbParser,
}) async {
  final descriptionMap = DescriptionParser.createFinalDescriptionMapFromTxtFile(
      filePath: '$pathToFiles/$fileNameFinalDescriptionsTxt',
      fileLoaderService: fileLoaderService);

  final foodsMap = dbParser.createFoodsMapDB(
      getFoodsList: dbParser.originalFoodsList,
      finalDescriptionRecordsMap: descriptionMap);

  await fileLoaderService.writeJsonFile(
      filePath: '$pathToFiles/$fileNameFoodsDatabase', contents: foodsMap);
}

///Writes the nutrient map to json file
///Format {"1003": {"name": "Protein","unit": "g"},
///         "1004": {"name": "Total lipid (fat)","unit": "g"}, ... }
Future<void> writeNutrientMapJsonFile(
    {required FileLoaderService fileLoaderService}) async {
  final csvLines =
      await fileLoaderService.readCsvFile('$pathToFiles/$fileNameNutrientsCsv');
  final Map<String, dynamic> map =
      Nutrient.createNutrientInfoMap(csvLines: csvLines);

  await fileLoaderService.writeJsonFile(
      filePath: '$pathToFiles/$fileNameNutrientsMap', contents: map);
}

/// *****************  File Writer for replenishing the database **************

/// Recreates all files from scratch.
/// 1.  Create the Description Map to use for word index
// Future<void> replenishFullDatabase(
//     {required final FileLoaderService fileLoaderService,
//     required final DBParser dbParser}) async {
//   // 1. Creates the final description map.
//   final descriptionMap =
//       DescriptionParser.createDescriptionMap(dbParser: dbParser);

//   // 2. Creates the autocomplete wordIndex
//   final wordIndex = Autocomplete.createAutocompleteWordIndexMap(
//       finalDescriptionMap: descriptionMap);

//   // 3. Creates the original substring map
//   final originalSubstring =
//       Autocomplete.createOriginalSubstringMap(wordIndex: wordIndex);

//   // 4. Creates the autocomplete hash table
//   final autocompleteHashTable = Autocomplete.createAutocompleteHashTable(
//       originalSubStringMap: originalSubstring);

//   // 5. Writes the autocomplete hash table to file
//   await fileLoaderService.writeJsonFile(
//       filePath: '$pathToFiles/$fileNameAutocompleteHash',
//       contents: autocompleteHashTable);

//   // 6. Creates the food database.
//   final foodsMap = dbParser.createFoodsMapDB(
//       getFoodsList: dbParser.originalFoodsList,
//       finalDescriptionRecordsMap: descriptionMap);

//   // 7. Writes the food database to file.
//   await fileLoaderService.writeJsonFile(
//       filePath: '$pathToFiles/$fileNameFoodsDatabase', contents: foodsMap);
// }

// The answer is 134 for the original descriptions.
int getLongestDescriptionLength(final DBParser dbParser) {
  final descriptions = DescriptionParser.createOriginalDescriptionRecords(
      originalFoodsList: dbParser.originalFoodsList);
  return DescriptionParser.getLongestDescription(descriptions: descriptions);
}

/// Retrieves the food categories from the specified [db]
(Map<String, int>, int) getFoodCategories({required final DBParser db}) {
  return db.getFoodCategories();
}
