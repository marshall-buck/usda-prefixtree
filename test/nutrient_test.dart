import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';
import 'package:usda_db_creation/nutrient.dart';

import 'setup/mock_data.dart';

void main() {
  group('Nutrient class tests', () {
    group('toJson()', () {
      test('convertToJson works correctly', () {
        final nutrient =
            Nutrient(id: 1004, name: 'Protien', amount: 10, unit: 'g');

        final json = nutrient.toJson();

        final expectation = {
          'id': 1004,
          'info': 'Protien*10*g',
        };

        final d = DeepCollectionEquality();
        expect(d.equals(json, expectation), true);
      });
    });
    group('fromJson()', () {
      test('fromJson works correctly with double', () {
        final json = {
          'id': 1004,
          'info': 'Protien*0.1*g',
        };

        final res = Nutrient.fromJson(json);
        expect(res.id, 1004);
        expect(res.name, 'Protien');
        expect(res.amount, 0.1);
        expect(res.unit, 'g');
      });
      test('fromJson works correctly with int', () {
        final json = {
          'id': 1004,
          'info': 'Protien*10*g',
        };

        final res = Nutrient.fromJson(json);
        expect(res.id, 1004);
        expect(res.name, 'Protien');
        expect(res.amount, 10);
        expect(res.unit, 'g');
      });
    });
    group('switchNutrientName()', () {
      test('switched nutrient name works for 1004', () {
        final res = Nutrient.switchNutrientName(1004);
        expect(res, 'Total Fat');
      });

      test('switched nutrient name works for 1005', () {
        final res = Nutrient.switchNutrientName(1005);
        expect(res, 'Total Carbs');
      });

      test('switched nutrient name works for 1008', () {
        final res = Nutrient.switchNutrientName(1008);
        expect(res, 'Calories');
      });

      test('switched nutrient name works for 1003', () {
        final res = Nutrient.switchNutrientName(1003);
        expect(res, 'Protein');
      });

      test('switched nutrient name works for 1258', () {
        final res = Nutrient.switchNutrientName(1258);
        expect(res, 'Saturated Fat');
      });

      test('switched nutrient name works for 1079', () {
        final res = Nutrient.switchNutrientName(1079);
        expect(res, 'Dietary Fiber');
      });

      test('switched nutrient name works for 2000', () {
        final res = Nutrient.switchNutrientName(2000);
        expect(res, 'Total Sugars');
      });

      test('switched nutrient name works for unknown id', () {
        final res = Nutrient.switchNutrientName(9999);
        expect(res, 'Unknown');
      });
    });
    // FIXME: This test is failing.
    group('createNutrientInfoMap()', () {
      test('createNutrientInfoMap', () {
        final expected = {
          "1002": {"name": "Nitrogen", "unit": "g"},
          "1003": {"name": "Protein", "unit": "g"}
        };

        final res = Nutrient.createNutrientInfoMap(csvLines: mockCsvLines);
        print('RES $res');
        final d = DeepCollectionEquality();
        expect(d.equals(res, expected), true);
        expect(res.entries.first.key.runtimeType, String);
      });
    });
  });
}
