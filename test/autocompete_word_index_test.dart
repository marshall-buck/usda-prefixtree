import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:usda_db_creation/autocompete_word_index.dart';

import 'setup/mock_data.dart';
import 'setup/setup.dart';

void main() {
  setUpAll(() {
    set_up_all();
  });

  tearDown(() {
    tear_down();
  });

  group('AutocompleteWordIndex', () {
    group('populateIndexMap()', () {
      test('populateIndexMap should return the correct index map', () {
        const expectation = {
          '100%': ['167513'],
          '2%': ['167514'],
          'artificial': ['167512'],
          'bake': ['167514'],
          'biscuits': ['167512'],
          'buttermilk': ['167512'],
          'cinnamon': ['167513'],
          'coating': ['167514'],
          'dough': ['167512', '167513'],
          'dry': ['167514'],
          'flavor': ['167512'],
          'foods': ['167514'],
          'golden': ['167512'],
          'icing': ['167513'],
          'kraft': ['167514'],
          'layer': ['167512'],
          'milk': ['167514'],
          'original': ['167514'],
          'pillsbury': ['167512', '167513'],
          'pork': ['167514'],
          'recipe': ['167514'],
          'refrigerated': ['167512', '167513'],
          'rolls': ['167513'],
          'shake': ['167514']
        };

        final indexMap = AutocompleteWordIndex.createAutocompleteIndexMap(
            descriptionMap: mockDescriptionMap);

        // print(indexMap);
        final deepEquals = const DeepCollectionEquality();
        expect(deepEquals.equals(expectation, indexMap), true);
      });
    });

    test('populateIndexMap should handle empty description map', () {
      final Map<int, String> descriptionMap = {};

      final indexMap = AutocompleteWordIndex.createAutocompleteIndexMap(
        descriptionMap: descriptionMap,
      );

      expect(indexMap, isA<SplayTreeMap<String, List<String>>>());
      expect(indexMap.isEmpty, true);
    });

    test('populateIndexMap should handle description map with stop words', () {
      final descriptionMap = {
        167782: 'apple is a fruit',
        173175: 'apples are delicious',
        171686: 'orange being is a citrus fruit',
      };

      final indexMap = AutocompleteWordIndex.createAutocompleteIndexMap(
        descriptionMap: descriptionMap,
      );
      // print(indexMap);
      expect(indexMap, isA<SplayTreeMap<String, List<String>>>());
      expect(indexMap.length, 6);
      expect(indexMap['apple'], containsAll(['167782']));
      expect(indexMap['apples'], containsAll(['173175']));
      expect(indexMap['orange'], containsAll(['171686']));
      expect(indexMap['are'], isNull);
      expect(indexMap['being'], isNull);
    });
    test(
        'populateIndexMap should strip remaining parenthese and numbers and /es',
        () {
      final descriptionMap = {
        167782: 'apple 18fat is a (fruit 1/8',
        173175: 'apples are delicious) 200 aa 11g',
        171686: 'orange being is a citrus/fruit 100%',
      };

      final indexMap = AutocompleteWordIndex.createAutocompleteIndexMap(
        descriptionMap: descriptionMap,
      );
      print(indexMap);
      expect(indexMap, isA<SplayTreeMap<String, List<String>>>());
      expect(indexMap.length, 7);
      expect(indexMap['apple'], containsAll(['167782']));
      expect(indexMap['apples'], containsAll(['173175']));
      expect(indexMap['orange'], containsAll(['171686']));
      expect(indexMap['100%'], containsAll(['171686']));
      expect(indexMap['200'], isNull);
      expect(indexMap['(fruit'], isNull);
      expect(indexMap['delicious)'], isNull);
    });
  });
}
