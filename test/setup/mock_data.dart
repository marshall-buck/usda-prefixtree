import 'package:usda_db_creation/food_model.dart';
import 'package:usda_db_creation/nutrient.dart';

const mockDescriptionFile = '''
(167512, Pillsbury Golden Layer Buttermilk Biscuits, (Artificial Flavor,) refrigerated dough)
(167513, Pillsbury, Cinnamon Rolls with Icing, 100% refrigerated dough)
(167514, Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry, 2% milk)
''';

const mockDescriptionMap = {
  167512:
      'Pillsbury Golden Layer Buttermilk Biscuits, (Artificial Flavor,) refrigerated dough',
  167513: 'Pillsbury, Cinnamon Rolls with Icing, 100% refrigerated dough',
  167514:
      'Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry, 2% milk',
};

const Map<String, List<String>> mockAutocompleteIndex = {
  "apple": ['1', '2'],
  "crabapple": ['3', '4']
};

const mockProtien = Nutrient(id: 1004, name: 'Protien', amount: 10, unit: 'g');

const mockTotalFat =
    Nutrient(id: 1003, name: 'Total Fat', amount: 5, unit: 'mg');

const mockTotalCarbs =
    Nutrient(id: 1005, name: 'Total Carbs', amount: 10, unit: 'g');

const mockCalories =
    Nutrient(id: 1008, name: 'Calories', amount: 80, unit: 'g');

const mockSaturatedFat =
    Nutrient(id: 1258, name: 'Saturated Fat', amount: 10, unit: 'g');

const mockFoodItem = FoodModel(
    id: 111111,
    description:
        'Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough',
    nutrients: [
      mockProtien,
      mockTotalFat,
      mockTotalCarbs,
      mockCalories,
      mockSaturatedFat
    ]);
const Map<int, dynamic> mockFoodJson = {
  111111: {
    'description':
        'Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough',
    'nutrients': [
      {'id': 1004, 'name': 'Protien', 'amount': 10, 'unit': 'g'},
      {'id': 1003, 'name': 'Total Fat', 'amount': 5, 'unit': 'mg'},
      {'id': 1005, 'name': 'Total Carbs', 'amount': 10, 'unit': 'g'},
      {'id': 1008, 'name': 'Calories', 'amount': 80, 'unit': 'g'},
      {'id': 1258, 'name': 'Saturated Fat', 'amount': 10, 'unit': 'g'},
    ]
  }
};

const mockNutrientCSVFile = '''
"id","name","unit_name","nutrient_nbr","rank"
"1002","Nitrogen","G","202","500"
''';

const mockCsvLines = [
  ['id', 'name', 'unit_name', 'nutrient_nbr', 'rank'],
  ['1002', 'Nitrogen', 'G', '202', '500'],
  ["1003", "Protein", "G", "203", "600"]
];
