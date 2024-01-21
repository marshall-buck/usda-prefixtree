import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/extensions/map_ext.dart';
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
      test(
          'loads USDA json file correctly, by populating _originalDBMap correctly',
          () {
        when(() => mockFileLoaderService.loadData(filePath: 'fake'))
            .thenReturn(mockUsdaFile);
        final dbParser =
            DBParser.init(filePath: 'fake', fileService: mockFileLoaderService);

        final res = dbParser.originalFoodsList;

        expect(res.length, 3);
      });
    });
    group('createNutrientsList() - ', () {
      test('creates nutrients list correctly', () {
        when(() => mockFileLoaderService.loadData(filePath: 'fake'))
            .thenReturn(mockUsdaFile);
        final dbParser =
            DBParser.init(filePath: 'fake', fileService: mockFileLoaderService);
        final List<Nutrient> result =
            dbParser.createNutrientsList(listOfNutrients: mockFoodNutrients);
        final d = DeepCollectionEquality();

        expect(d.equals(result, mockNutrientListResults), true);
      });
    });
    group('createFoodsMap() - ', () {
      test('createFoodsMap correctly', () {
        when(() => mockFileLoaderService.loadData(filePath: 'fake'))
            .thenReturn(mockUsdaFile);

        final dbParser =
            DBParser.init(filePath: 'fake', fileService: mockFileLoaderService);

        final originalFoodsList = dbParser.originalFoodsList;

        final Map<String, dynamic> res = dbParser.createFoodsMapDB(
            getFoodsList: originalFoodsList,
            finalDescriptionRecordsMap: mockDescriptionMap);

        final converted = res.deepConvertMapKeyToInt();

        final d = DeepCollectionEquality();

        expect(
            d.equals(res.entries.first.value,
                mockFoodsMapResult.entries.first.value),
            true);

        expect(
            d.equals(
                res.entries.last.value, mockFoodsMapResult.entries.last.value),
            true);

        expect(converted.entries.first.key, isA<int>());
      });
    });

    group('getFoodCategories()', () {
      test('should return a map of food categories and their counts', () {
        when(() => mockFileLoaderService.loadData(filePath: 'fake'))
            .thenReturn(mockUsdaFile);
        final expected = {'Baked Products': 2, 'Beverages': 1, 'total': 3};

        final dbParser =
            DBParser.init(filePath: 'fake', fileService: mockFileLoaderService);
        final d = DeepCollectionEquality();
        final res = dbParser.getFoodCategories();
        expect(d.equals(res, expected), true);
      });
    });
  });
}
