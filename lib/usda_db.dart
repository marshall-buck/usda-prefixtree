// This file is where the methods live that will be used in the
// bin/usda_db_creation.dart  file.
// The bin/usda_db_creation.dart is called when the user runs the command
// 'dart run'. Not all methods in this file are used in the bin/usda_db_creation.dart
// at the same time.

import 'package:usda_db_creation/autocompete.dart';
import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';
import 'package:usda_db_creation/file_loader_service.dart';

// import 'dart:developer' as dev;

import 'package:usda_db_creation/global_const.dart';
import 'package:usda_db_creation/nutrient.dart';

/// Creates the duplicate phrases file and writes to [path].
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

Future<void> writeDescriptionsToFile(
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
      filePath: '$pathToFiles/$fileNameFinalDescriptions');
}

Future<void> writeAutocompleteWordIndexToFile({
  required final FileLoaderService fileLoaderService,
}) async {
  final descriptionMap = DescriptionParser.createFinalDescriptionMapFromFile(
      path: '$pathToFiles/$fileNameFinalDescriptions',
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
  final descriptionMap = DescriptionParser.createFinalDescriptionMapFromFile(
      path: '$pathToFiles/$fileNameFinalDescriptions',
      fileLoaderService: fileLoaderService);

  // Create the autocomplete index map from the description map.
  final autoCompleteWordIndex = Autocomplete.createAutocompleteWordIndexMap(
      finalDescriptionMap: descriptionMap);

  // Create the substrings from the autocomplete index map.
  final substrings = Autocomplete.createOriginalSubstringMap(
      autoCompleteMap: autoCompleteWordIndex);

  // Create the hash table from the substrings.
  final hash = Autocomplete.createAutocompleteHashTable(
      originalSubStringMap: substrings);

  await fileLoaderService.writeJsonFile(
      filePath: '$pathToFiles/$fileNameAutocompleteHash', contents: hash);
}

/// Method to create the foods database.
Future<void> createFoodsDatabase({
  required final FileLoaderService fileLoaderService,
  required final DBParser dbParser,
}) async {
  final descriptionMap = DescriptionParser.createFinalDescriptionMapFromFile(
      path: '$pathToFiles/$fileNameFinalDescriptions',
      fileLoaderService: fileLoaderService);

  final foodsMap = dbParser.createFoodsMap(
      getFoodsList: dbParser.originalFoodsList,
      finalDescriptionRecordsMap: descriptionMap);

  await fileLoaderService.writeJsonFile(
      filePath: '$pathToFiles/$fileNameFoodsDatabase', contents: foodsMap);
}

createNutrientMap({required FileLoaderService fileLoaderService}) async {
  final csvLines =
      await fileLoaderService.readCsvFile('$pathToFiles/$fileNameNutrientsCsv');
  final Map<String, dynamic> map =
      Nutrient.createNutrientInfoMap(csvLines: csvLines);

  await fileLoaderService.writeJsonFile(
      filePath: '$pathToFiles/$fileNameNutrientsMap', contents: map);
}

/// Finds all the nutrient ids that will actually be used in the database.
Set<int> findAllNutrientIds(
    {required final Map<int, String> finalDescriptionRecordsMap,
    required final List<dynamic> originalFoodsList}) {
  final Set<int> nutrientIds = {};
  for (final food in originalFoodsList) {
    final int foodId = food['fdcId'];
    if (!finalDescriptionRecordsMap.containsKey(foodId)) {
      continue;
    }
    final foodNutrients = food['foodNutrients'];
    for (final nutrient in foodNutrients) {
      final int nutrientId = nutrient['nutrient']['id'];
      nutrientIds.add(nutrientId);
    }
  }
  return nutrientIds;
}
