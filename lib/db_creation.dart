// This file is where the methods live that will be used in the
// bin/usda_db_creation.dart  file.
// The bin/usda_db_creation.dart is called when the user runs the command
// 'dart run'. Not all methods in this file are used in the bin/usda_db_creation.dart
// at the same time.

import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';
import 'package:usda_db_creation/file_loader_service.dart';
import 'package:usda_db_creation/helpers/stop_words.dart';

import 'dart:developer' as dev;

import 'package:usda_db_creation/paths.dart';

/// Creates the duplicate phrases file and writes to [path].
Future<void> writeDuplicatePhrasesToFile(
    {final int minPhraseLength = 20,
    final minNumberOfDuplicatesToShow = 25,
    required final FileLoaderService fileLoader,
    required final DBParser dbParser}) async {
  final descriptionRecords = DescriptionParser.createOriginalDescriptionRecords(
      originalFoodsList: dbParser.originalFoodsList);

  final repeats = DescriptionParser.createRepeatedPhraseFrequencyMap(
      listOfRecords: descriptionRecords,
      minPhraseLength: minPhraseLength,
      minNumberOfDuplicatesToShow: minNumberOfDuplicatesToShow);

  await fileLoader.writeJsonFile(relativeRepeatFile, repeats);
  print('Complete: ${repeats.length}');
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
