import 'helpers/string_helpers.dart';

class DescriptionParser {
  // Returns List of [(index, description).]
  static List<(int, String)> populateOriginalDescriptionRecords(
      List<dynamic> foodsDBMap) {
    return foodsDBMap.map((food) {
      int id;
      if (food["fdcId"] == null) {
        id = food["ndbNumber"];
      } else {
        id = food["fdcId"];
      }

      // Return a tuple containing the fdcId and description
      return (id, food["description"] as String);
    }).toList();
  }

  static int getLongestDescription(
      {required List<(int, String)> descriptions}) {
    return descriptions.fold(
        0,
        (maxLength, record) =>
            maxLength > record.$2.length ? maxLength : record.$2.length);
  }

  static Map<String, int> getRepeatedPhrases(
      {required List<(int, String)> listOfRecords,
      required int minPhraseLength,
      required showResultsLongerThan}) {
    final Map<String, int> freqMap = {};

    for (final record in listOfRecords) {
      final String description = record.$2;
      final phrases = separateIntoPhrasesWithMinimumLength(
          sentence: description, minPhraseLength: minPhraseLength);

      for (final phrase in phrases) {
        if (phrase!.isNotEmpty) {
          if (freqMap.containsKey(phrase)) {
            freqMap[phrase] = freqMap[phrase]! + 1;
          } else {
            freqMap[phrase] = 1;
          }
        }
      }
    }

    freqMap.removeWhere((key, value) => value < showResultsLongerThan);

    return freqMap;
  }
}
