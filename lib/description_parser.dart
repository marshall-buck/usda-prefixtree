import 'helpers/string_helpers.dart';

/// Class to help with parsing the description strings.
class DescriptionParser {
  // Returns [List<int, String>] of [( index,  description), ...].
  static List<(int, String)> populateOriginalDescriptionRecords(
      final List<dynamic> foodsDBMap) {
    return foodsDBMap.map((final food) {
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
      {required final List<(int, String)> descriptions}) {
    return descriptions.fold(
        0,
        (final maxLength, final record) =>
            maxLength > record.$2.length ? maxLength : record.$2.length);
  }

  static Map<String, int> getRepeatedPhrases(
      {required final List<(int, String)> listOfRecords,
      required final int minPhraseLength,
      required final howManyTimesRepeated}) {
    final Map<String, int> freqMap = {};

    for (final record in listOfRecords) {
      final String description = record.$2;
      final List<String?> phrases = separateIntoPhrasesWithMinimumLength(
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

    freqMap
        .removeWhere((final key, final value) => value < howManyTimesRepeated);
    var sortedList = freqMap.entries.toList()
      ..sort((final a, final b) => b.value.compareTo(a.value));

    return Map.fromEntries(sortedList);
  }
}
