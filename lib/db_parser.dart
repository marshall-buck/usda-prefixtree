import 'dart:convert';

import 'package:usda_db_creation/description_parser.dart';
import 'package:usda_db_creation/file_loader_service.dart';
import 'package:usda_db_creation/food_model.dart';
import 'package:usda_db_creation/global_const.dart';
import 'package:usda_db_creation/nutrient.dart';

class DBParser {
  FileLoaderService? fileLoaderService;
  Map<dynamic, dynamic>? _originalDBMap;

  /// [List] of foods from the database.
  List<dynamic> get originalFoodsList => _originalDBMap?['SRLegacyFoods'];

  // DBParser({final FileLoaderService? fileLoaderService})
  //     : fileLoaderService = fileLoaderService ?? FileLoaderService();

  /// Populates the _dbMap
  DBParser.init(
      {required FileLoaderService this.fileLoaderService,
      required final String path}) {
    final file = fileLoaderService?.loadData(path);
    _originalDBMap = jsonDecode(file!);
  }

  List<DescriptionRecord> get finalDescriptionRecords =>
      DescriptionParser.removeUnwantedPhrasesFromDescriptions(
          descriptions: DescriptionParser.createOriginalDescriptionRecords(
              originalFoodsList: originalFoodsList),
          unwantedPhrases: unwantedPhrases);

  (Map<String, int>, int) getFoodCategories() {
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

    return (categories, count);
  }

  /// Method to creawte the map that wil be used fior the foods database.
  /// The map will be of the form:
  /// { id: { description, descritionLength,  nutrients }, ... }
  ///
  Map<String, dynamic> createFoodsMap(
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
          id: foodId.toString(),
          description: foodDescription,
          descriptionLength: foodDescription.length,
          nutrients: nutrientsList);

      final foodModelJson = foodModel.toJson();
      // print(foodModelJson);
      foodsMap.addAll(foodModelJson);
    }

    return foodsMap;
  }

  /// Method to create the nutrients list that will be used for the foods database.
  List<Nutrient> createNutrientsList({
    required final List<dynamic> listOfNutrients,
  }) {
    final List<Nutrient> nutrients = [];

    for (int i = 0; i < listOfNutrients.length; i++) {
      final Map<String, dynamic> originalNutrient = listOfNutrients[i];
      String name = originalNutrient['nutrient']['name'] ?? 'unknown';
      // print('Name: $name');
      final int nutrientId = originalNutrient['nutrient']['id'] ?? 9999;
      if (!findNutrient(nutrientId)) continue;
      name = Nutrient.switchNutrientName(nutrientId.toString());
      // print('Name: $name');
      final unitName = originalNutrient['nutrient']['unitName'] ?? 'unknown';

      final num amount = originalNutrient['amount'] ?? 0.0;
      final nutrient = Nutrient(
        id: nutrientId.toString(),
        displayName: name,
        amount: amount,
        unit: unitName,
      );
      // print(nutrient);
      nutrients.add(nutrient);
    }
    // print('Creaetd nutrients list: $nutrients');
    return nutrients;
  }

  /// Checks if nutrient is in [keepTheseNutrients].
  ///
  /// Parameters:
  /// [nutrientId] - the id of the nutrient to be included.
  ///
  /// Returns [bool].
  bool findNutrient(final int nutrientId) {
    return keepTheseNutrients.contains(nutrientId);
  }
}
