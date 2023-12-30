import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:usda_db_creation/food_model.dart';
import 'package:usda_db_creation/nutrient.dart';

import 'setup/mock_data.dart';

void main() {
  group('Food Model class tests', () {
    group('toJson()', () {
      test('toJson works correctly', () {
        final json = mockFoodItem.toJson();

        final expectation = {
          '111111': {
            'description':
                'Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough',
            'nutrients': [
              {'id': 1004, 'name': 'Protien', 'amount': 10, 'unit': 'g'},
              {'id': 1003, 'name': 'Total Fat', 'amount': 5, 'unit': 'mg'},
              {'id': 1005, 'name': 'Total Carbs', 'amount': 10, 'unit': 'g'},
              {'id': 1008, 'name': 'Calories', 'amount': 80, 'unit': 'g'},
              {'id': 1258, 'name': 'Saturated Fat', 'amount': 10, 'unit': 'g'}
            ]
          }
        };

        final d = DeepCollectionEquality();
        expect(d.equals(json, expectation), true);
      });
    });
    group('fromJson()', () {
      test('fromJson works correctly', () {
        final res = FoodModel.fromJson(mockFoodJson);

        expect(res.id, 111111);
        expect(res.description,
            'Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough');

        expect(res.nutrients.length, 5);
        expect(res.nutrients[0].id, 1004);
        expect(res.nutrients[0].name, 'Protien');
        expect(res.nutrients[0].amount, 10);
        expect(res.nutrients[0].unit, 'g');

        expect(res.nutrients[1].id, 1003);
        expect(res.nutrients[1].name, 'Total Fat');
        expect(res.nutrients[1].amount, 5);
        expect(res.nutrients[1].unit, 'mg');

        expect(res.nutrients[2].id, 1005);
        expect(res.nutrients[2].name, 'Total Carbs');
        expect(res.nutrients[2].amount, 10);
        expect(res.nutrients[2].unit, 'g');

        expect(res.nutrients[3].id, 1008);
        expect(res.nutrients[3].name, 'Calories');
        expect(res.nutrients[3].amount, 80);
        expect(res.nutrients[3].unit, 'g');

        expect(res.nutrients[4].id, 1258);
        expect(res.nutrients[4].name, 'Saturated Fat');
        expect(res.nutrients[4].amount, 10);
        expect(res.nutrients[4].unit, 'g');
      });

      test('fromJson creates nutrients list as <List<Nutrient>>', () {
        final res = FoodModel.fromJson(mockFoodJson);
        expect(res.nutrients, isA<List<Nutrient>>());
      });
    });
  });
}
