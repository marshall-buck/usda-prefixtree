class FoodsDB {
  static const keepTheseNutrients = [1003, 1004, 1005, 1008, 1079, 1258, 2000];
  static const originalFile = 'lib/db/original_usda.json';
  static const internalDbName = 'db.json';

  void createDB() {
    print("createDB from FoodsDB");
  }

  /// Iterates through a food items nutrient list.
  ///
  /// Parameters:
  /// - [list] - a list of  all nutrients for a food item
  /// [{"type": "FoodNutrient",
  ///      "id": 1283674,
  ///      "nutrient": {
  ///        "id": 1003,
  ///        "number": "203",
  ///        "name": "Protein",
  ///        "rank": 600,
  ///        "unitName": "g"
  ///      },
  ///      "dataPoints": 1,
  ///      "foodNutrientDerivation": {...} },
  ///      "amount": 5.88 }, ...]
  ///
  ///  Returns [nutrients] - [{ name: Protein, amount: 5.88 },
  ///                         { name: Calories, amount: 100 } ...],
  ///  unitName is optional.
  ///
  ///
  List getFoodNutrients(List list) {
    final List nutrients = [];

    for (var i = 0; i < list.length; i++) {
      final originalNutrient = list[i];
      var name = originalNutrient['nutrient']['name'];
      final nutrientId = originalNutrient['nutrient']['id'];
      if (!findNutrient(nutrientId)) continue;
      name = switchNutrientName(nutrientId);
      final unitName = originalNutrient['nutrient']['unitName'];

      final amount = originalNutrient['amount'];
      final nutrient = {'name': name, 'unitName': unitName, 'amount': amount};
      if (unitName == 'g' || unitName == 'kcal') {
        nutrient.remove('unitName');
      }
      nutrients.add(nutrient);
    }
    return nutrients;
  }

  /// Checks if nutrient is in [keepTheseNutrients].
  ///
  /// Parameters:
  /// [nutrientId] - the id of the nutrient to be included.
  ///
  /// Returns [bool].
  bool findNutrient(int nutrientId) {
    return keepTheseNutrients.contains(nutrientId);
  }

  /// Switches nutrient name.
  ///
  /// Parameters [nutrientId]
  ///
  /// Returns [String] of user friendly name.
  String switchNutrientName(nutrientId) {
    switch (nutrientId) {
      case 1004:
        {
          return 'Total Fat';
        }

      case 1005:
        {
          return 'Total Carbs';
        }

      case 1008:
        {
          return 'Calories';
        }

      case 1003:
        {
          return 'Protein';
        }

      case 1258:
        {
          return 'Saturated Fat';
        }

      case 1079:
        {
          return 'Dietary Fiber';
        }

      case 2000:
        {
          return 'Total Sugars';
        }

      default:
        {
          return 'Unknown';
        }
    }
  }
}
