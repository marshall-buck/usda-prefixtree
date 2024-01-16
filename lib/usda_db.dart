// This file is where the methods live that will be used in the
// bin/usda_db_creation.dart  file.
// The bin/usda_db_creation.dart is called when the user runs the command
// 'dart run'. Not all methods in this file are used in the bin/usda_db_creation.dart
// at the same time.

import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';

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
