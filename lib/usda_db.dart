// This file is where the methods live that will be used in the
// bin/usda_db_creation.dart  file.
// The bin/usda_db_creation.dart is called when the user runs the command
// 'dart run'. Not all methods in this file are used in the bin/usda_db_creation.dart
// at the same time.

import 'package:usda_db_creation/autocomplete.dart';
import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';
import 'package:usda_db_creation/file_loader_service.dart';

import 'package:usda_db_creation/substrings.dart';
import 'package:usda_db_creation/word_index.dart';

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

Future<void> createDBFiles(
    {required DBParser dbParser,
    required FileService fileService,
    bool extras = false}) async {
  if (extras) {
    final descriptions = DescriptionParser();

    final desMap = await descriptions.createDataStructure(
        dbParser: dbParser, writeFile: true, returnData: true);
    final wordIndex = WordIndexMap(desMap!);
    final wordIndexMap = await wordIndex.createDataStructure(
        dbParser: dbParser, writeFile: true);
    final substring = Substrings(wordIndexMap!);
    final substringMap = await substring.createDataStructure(
        dbParser: dbParser, writeFile: false);
    final hashTable = AutoCompleteHashTable(substringMap!);
    await hashTable.createDataStructure(dbParser: dbParser, writeFile: true);

    final db = DB(desMap);
    db.createDataStructure(dbParser: dbParser, writeFile: true);
  } else {
    final descriptions = DescriptionParser();

    final desMap = await descriptions.createDataStructure(
        dbParser: dbParser, writeFile: false, returnData: true);
    final wordIndex = WordIndexMap(desMap!);
    final wordIndexMap = await wordIndex.createDataStructure(
        dbParser: dbParser, writeFile: false);
    final substring = Substrings(wordIndexMap!);
    final substringMap = await substring.createDataStructure(
        dbParser: dbParser, writeFile: false);
    final hashTable = AutoCompleteHashTable(substringMap!);
    await hashTable.createDataStructure(dbParser: dbParser, writeFile: true);

    final db = DB(desMap);
    await db.createDataStructure(dbParser: dbParser);
  }
}
