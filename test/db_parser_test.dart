import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/nutrient.dart';

import 'setup/mock_data.dart';
import 'setup/mock_db.dart';
import 'setup/mock_food_nutrients.dart';
import 'setup/setup.dart';

void main() {
  setUpAll(() {
    set_up_all();
  });

  tearDown(() {
    tear_down();
  });
  group('DBParser class tests', () {
    group('init() - ', () {
      test('loads file correctly', () {
        when(() => mockFileLoaderService.loadData('fake'))
            .thenReturn(mockUsdaFile);
        final dbParser = DBParser.init(
            path: 'fake', fileLoaderService: mockFileLoaderService);
        // dbParser.init('fake');
        final res = dbParser.originalFoodsList;

        expect(res.length, 3);
      });
    });
    group('createNutrientsList() - ', () {
      test('creates nutrients list correctly', () {
        when(() => mockFileLoaderService.loadData('fake'))
            .thenReturn(mockUsdaFile);
        final dbParser = DBParser.init(
            path: 'fake', fileLoaderService: mockFileLoaderService);
        final List<Nutrient> result =
            dbParser.createNutrientsList(listOfNutrients: mockFoodNutrients);
        final d = DeepCollectionEquality();

        expect(d.equals(result, mockNutrientListResults), true);
      });
    });
    group('createFoodsMap() - ', () {
      test('createFoodsMap correctly', () {
        when(() => mockFileLoaderService.loadData('fake'))
            .thenReturn(mockUsdaFile);

        final dbParser = DBParser.init(
            path: 'fake', fileLoaderService: mockFileLoaderService);

        final originalFoodsList = dbParser.originalFoodsList;

        final Map<String, dynamic> res = dbParser.createFoodsMap(
            getFoodsList: originalFoodsList,
            finalDescriptionRecordsMap: mockDescriptionMap);
        final d = DeepCollectionEquality();

        expect(
            d.equals(res.entries.first.value,
                mockFoodsMapResult.entries.first.value),
            true);

        expect(
            d.equals(
                res.entries.last.value, mockFoodsMapResult.entries.last.value),
            true);
      });
    });
  });
}
// Existing code...



// Existing code...