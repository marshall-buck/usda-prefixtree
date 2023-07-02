import 'package:test/test.dart';
import 'package:usda_db_creation/db/create_word_index.dart';

void main() {
  group('populateIndexMap', () {
    test('should return a sorted map of words to a list of indexes', () {
      final db = {
        "167512": {
          "description": "Pillsbury Golden to (with) refrigerated, 99#",
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
          "Protein": 4.34,
          "Dietary Fiber": 1.4,
          "Saturated Fat": 3.25,
          "Total Fat": 11.3,
          "Total Carbs": 53.4,
          "Calories": 330,
          "Total Sugars": 21.3
        },
      };

      final expectedOrderOfKeys = [
        'cinnamon',
        'golden',
        'pillsbury',
        'refrigerated'
      ];

      final indexMap = populateIndexMap(db).keys.toList();

      expect(indexMap[0], equals(expectedOrderOfKeys[0]));
      expect(indexMap.contains(""), isFalse);
      expect(indexMap, orderedEquals(expectedOrderOfKeys));
    });
  });
}
