import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:usda_db_creation/food_model.dart';

import 'setup/mock_data.dart';

void main() {
  group('Food Model class tests', () {
    group('toJson()', () {
      test('convertToJson works correctly', () {
        final json = mockFoodItem.toJson();
        // print(json);
        final expectation = {
          '111111': {
            'description':
                'Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough',
            'descriptionLength': 89,
            'nutrients': {
              '1004': {'displayName': 'Protien', 'amount': 10, 'unit': 'g'},
              '1003': {'displayName': 'Total Fat', 'amount': 5, 'unit': 'mg'},
              '1005': {'displayName': 'Total Carbs', 'amount': 10, 'unit': 'g'},
              '1008': {'displayName': 'Calories', 'amount': 80, 'unit': 'g'},
              '1258': {
                'displayName': 'Saturated Fat',
                'amount': 10,
                'unit': 'g'
              }
            },
          }
        };

        final d = DeepCollectionEquality();
        expect(d.equals(json, expectation), true);
      });
    });
    group('fromJson()', () {
      test('fromJson works correctly', () {
        final res = FoodModel.fromJson(mockFoodJson);
        expect(res.id, '111111');
        expect(res.description,
            'Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough');
        expect(res.descriptionLength, 89);
        // expect(res.nutrients.length, 5);
        // expect(res.nutrients[0].id, '1004');
        // expect(res.nutrients[0].displayName, 'Protien');
        // expect(res.nutrients[0].amount, 10);
        // expect(res.nutrients[0].unit, 'g');
      });
    });
  });
}
