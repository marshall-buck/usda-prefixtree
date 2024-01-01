import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';
import 'package:usda_db_creation/nutrient.dart';

import 'setup/mock_data.dart';

void main() {
  group('Nutrient class tests', () {
    group('toJson()', () {
      test('convertToJson works correctly', () {
        final nutrient = Nutrient(id: 1004, amount: 10);

        final json = nutrient.toJson();

        final expectation = {
          'id': 1004,
          'amount': 10,
        };

        final d = DeepCollectionEquality();
        expect(d.equals(json, expectation), true);
      });
    });
    group('fromJson()', () {
      test('fromJson works correctly with double', () {
        final json = {
          'id': 1004,
          'amount': 0.1,
        };

        final res = Nutrient.fromJson(json);
        expect(res.id, 1004);
        expect(res.name, 'Total Fat');
        expect(res.amount, 0.1);
        expect(res.unit, 'g');
      });
      test('fromJson works correctly with int', () {
        final json = {
          'id': 1004,
          'amount': 10,
        };

        final res = Nutrient.fromJson(json);
        expect(res.id, 1004);
        expect(res.name, 'Total Fat');
        expect(res.amount, 10);
        expect(res.unit, 'g');
      });
    });

    group('createNutrientInfoMap()', () {
      test('createNutrientInfoMap', () {
        final expected = {
          "1003": {"name": "Protein", "unit": "g"},
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
