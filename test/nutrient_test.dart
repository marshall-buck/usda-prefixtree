import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';
import 'package:usda_db_creation/nutrient.dart';

void main() {
  group('Nutrient class tests', () {
    group('toJson()', () {
      test('convertToJson works correctly', () {
        final nutrient =
            Nutrient(id: '1004', displayName: 'bob', amount: 10, unit: 'g');

        final json = nutrient.toJson();
        print(json);
        final expectation = {
          '1004': {'displayName': 'bob', 'amount': 10, 'unit': 'g'}
        };
        final d = DeepCollectionEquality();
        expect(d.equals(json, expectation), true);
      });
    });
    // group('fromJson()', () {
    //   test('fromJson works correctly', () {
    //     final expectation = {
    //       '1004': {'displayName': 'bob', 'amount': 10, 'unit': 'g'}
    //     };

    //     final nutrient =
    //         Nutrient(id: '1004', displayName: 'bob', amount: 10, unit: 'g');
    //     final res = nutrient.();
    //     final d = DeepCollectionEquality();
    //     expect(d.equals(res, expectation), true);
    //   });
    // });
    // group('switchNutrientName()', () {
    //   test('switched nutrient name works for 1004', () {
    //     final nutrient =
    //         Nutrient(id: '1004', displayName: 'bob', amount: 10, unit: 'g');
    //     final newNu = nutrient.copyWith(
    //         displayName: Nutrient.switchNutrientName(nutrient.id));
    //     expect(newNu.displayName, 'Total Fat');
    //   });
    // });
  });
}
