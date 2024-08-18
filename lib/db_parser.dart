import 'dart:convert';

import 'package:usda_db_creation/data_structure.dart';

import 'package:usda_db_creation/file_service.dart';
import 'package:usda_db_creation/food_model.dart';

import 'package:usda_db_creation/nutrient.dart';

/// Class to create the main database of food items and nutrient information.
/// The instance needs to be initialized with a map of
/// parsed descriptions [descriptionMap].
class DB implements DataStructure {
  final Map<int, String> descriptionMap;

  DB(this.descriptionMap);

  /// Creates the database data structure and writes it to a file,
  /// if [writeFile] is true.
  /// Returns the data structure if [returnData] is true.
  @override
  Future<Map<String, dynamic>?> createDataStructure(
      {required DBParser dbParser,
      bool returnData = false,
      bool writeFile = true}) async {
    final foodsList = dbParser.originalFoodsList;

    final Map<String, dynamic> data = dbParser.createFoodsMapDB(
        getFoodsList: foodsList, finalDescriptionRecordsMap: descriptionMap);

    if (writeFile) {
      await dbParser.fileService.writeFileByType<Null, Map<String, dynamic>>(
          fileName: FileService.fileNameFoodsDatabase,
          convertKeysToStrings: false,
          mapContents: data);
    }
    return returnData ? data : null;
  }
}

/// A class that represents a parser for the [original_usda.json].
/// It is used to extract information and perform various operations on the data.
/// The instance needs to be initialized with the [original_usda.json] file,
///  with [DBParser.init]
class DBParser {
  FileService fileService;
  Map<dynamic, dynamic>? _originalDBMap;

  /// Opens [original_usda.json]  and creates a map.
  DBParser.init({required this.fileService, required final String filePath}) {
    final file = fileService.loadData(filePath: filePath);
    _originalDBMap = jsonDecode(file);
  }

  /// [List] of foods from [_originalDBMap.json].
  List<dynamic> get originalFoodsList => _originalDBMap?['SRLegacyFoods'];

  /// Method to create the map that wil be used for the foods database.
  /// Returns:
  /// { id: { description,  nutrients }, ... }
  Map<String, dynamic> createFoodsMapDB(
      {required final List<dynamic> getFoodsList,
      required final Map<int, String> finalDescriptionRecordsMap}) {
    final Map<String, dynamic> foodsMap = {};

    for (final food in getFoodsList) {
      final int foodId = food['fdcId'];
      if (!finalDescriptionRecordsMap.containsKey(foodId)) {
        continue;
      }

      final String foodDescription = finalDescriptionRecordsMap[foodId]!;

      final foodNutrients = food['foodNutrients'];

      final nutrientsList = createNutrientsList(listOfNutrients: foodNutrients);

      final foodModel = FoodModel(
          id: foodId, description: foodDescription, nutrients: nutrientsList);

      final Map<String, dynamic> foodModelJson = foodModel.toJson();

      foodsMap.addAll(foodModelJson);
    }

    return foodsMap;
  }

  /// Method to create the nutrients list that will be used for the foods database.
  ///
  /// Parameters:
  /// [listOfNutrients] - the list of nutrients from a food item.
  ///
  /// Returns:
  /// [List] of [Nutrient] objects.
  List<Nutrient> createNutrientsList({
    required final List<dynamic> listOfNutrients,
  }) {
    final List<Nutrient> nutrients = [];

    for (int i = 0; i < listOfNutrients.length; i++) {
      final Map<String, dynamic> originalNutrient = listOfNutrients[i];

      final int nutrientId = originalNutrient['nutrient']['id'] ?? 9999;
      if (!_findNutrient(nutrientId)) continue;

      final num amount = originalNutrient['amount'] ?? 0.0;
      final nutrient = Nutrient(
        id: nutrientId,
        amount: amount,
      );

      if (nutrient.amount > 0 && nutrient.id != 9999) {
        nutrients.add(nutrient);
      }
    }

    return nutrients;
  }

  /// Checks if nutrient is in [Nutrient.keepTheseNutrients].
  ///
  /// Parameters:
  /// [nutrientId] - the id of the nutrient to be included.
  ///
  /// Returns [bool].
  bool _findNutrient(final int nutrientId) {
    return Nutrient.keepTheseNutrients.contains(nutrientId);
  }

  /// Creates a set of id's from the nutrients in hte original database.
  /// This is used to create the `nutrientIds] property
  /// in the 'global_const.dart' file.
  static Set<int> findAllNutrientIds(
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

  /******************************* Research Methods **************************/

  /// Retrieves the food categories from the database.
  /// Informational method
  /// Returns a [Map] containing the food categories as keys and their
  /// corresponding IDs as values. The second element of the
  /// returned record represents the total number of food categories.
  /// Returns:
  /// {"category1": 1, "category2": 2, ..., "total": 3}
  Map<String, int> getFoodCategories() {
    final Map<String, int> categories = {};
    int count = 0;
    for (final food in originalFoodsList) {
      final foodCategory = food['foodCategory'];
      final foodCategoryDescription = foodCategory['description'];
      if (categories.containsKey(foodCategoryDescription)) {
        categories[foodCategoryDescription] =
            categories[foodCategoryDescription]! + 1;
        count++;
      } else {
        categories[foodCategoryDescription] = 1;
        count++;
      }
    }
    categories['total'] = count;
    return categories;
  }
}
