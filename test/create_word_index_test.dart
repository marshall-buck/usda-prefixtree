import 'package:test/test.dart';
import 'package:usda_db_creation/create_word_index.dart';

const db = {
  "167512": {
    "description": "Pillsbury Golden to (with) refrigerated, 99#",
    "descriptionLength": 81,
    "Protein": 5.88,
    "Dietary Fiber": 1.2,
    "Saturated Fat": 2.94,
    "Total Fat": 13.2,
    "Total Carbs": 41.2,
    "Calories": 307,
    "Total Sugars": 5.88
  },
  "167513": {
    "description": "Pillsbury, Cinnamon, refrigerated-to a",
    "descriptionLength": 56,
    "Protein": 4.34,
    "Dietary Fiber": 1.4,
    "Saturated Fat": 3.25,
    "Total Fat": 11.3,
    "Total Carbs": 53.4,
    "Calories": 330,
    "Total Sugars": 21.3
  },
  "167515": {
    "description": "",
    "descriptionLength": 81,
    "Protein": 4.34,
    "Dietary Fiber": 1.4,
    "Saturated Fat": 3.25,
    "Total Fat": 11.3,
    "Total Carbs": 53.4,
    "Calories": 330,
    "Total Sugars": 21.3
  },
};

void main() {
  group('populateIndexMap', () {
    test('should return a sorted map of words to a list of indexes', () {
      final expectedOrderOfKeys = [
        'cinnamon',
        'golden',
        'pillsbury',
        'refrigerated'
      ];
      final indexMap = populateIndexMap(db);
      final indexMapKeyList = populateIndexMap(db).keys.toList();

      expect(indexMap.length, equals(4));
      expect(indexMap['pillsbury'], equals(['167512', '167513']));
      expect(indexMap[''], equals(null));
      expect(indexMapKeyList[0], equals(expectedOrderOfKeys[0]));

      expect(indexMapKeyList, orderedEquals(expectedOrderOfKeys));
    });
  });
  group('sortByDescription', () {
    test('should sort indexes by descriptionLength prop', () {
      final unsortedIndexes = populateIndexMap(db);
      final sorted = sortByDescription(unsortedIndexes, db);
      expect(sorted['pillsbury'], equals(['167513', '167512']));
      expect(sorted[''], equals(null));
      expect(sorted.length, equals(4));
    });
  });
}
