/// A class for parsing description strings from the [originalFoodsList].
class DescriptionParser {
  //
  /// Parses [originalFoodsList] to create a list of description records.
  static List<(int, String)> createOriginalDescriptionRecords(
      {required final List<dynamic> originalFoodsList}) {
    return originalFoodsList.map((final food) {
      int id;
      if (food["fdcId"] == null) {
        id = food["ndbNumber"];
      } else {
        id = food["fdcId"];
      }

      return (id, food["description"] as String);
    }).toList();
  }

  /// Creates a frequency map of repeated phrases in the description records.
  ///
  ///  Will only include phrases that repeat more than [minNumberOfDuplicatesToShow].

  static Map<String, int> createRepeatedPhraseFrequencyMap(
      {required final List<(int, String)> listOfRecords,
      required final int minPhraseLength,
      required final minNumberOfDuplicatesToShow}) {
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

    freqMap.removeWhere(
        (final key, final value) => value < minNumberOfDuplicatesToShow);
    final sortedList = freqMap.entries.toList()
      ..sort((final a, final b) => b.value.compareTo(a.value));

    return Map.fromEntries(sortedList);
  }

  /// Creates a list of  phrase's from a [sentence].
  ///
  /// The phrase will be at least [minPhraseLength] long.
  ///
  /// separateIntoPhrasesWithMinimumLength(
  ///           "Quietly, an old oak stood, surrounded by natures.", 20) =>
  /// [
  ///        "Quietly, an old oak stood,",
  ///        "Quietly, an old oak stood, surrounded",
  ///        "Quietly, an old oak stood, surrounded by",
  ///        "Quietly, an old oak stood, surrounded by natures.",
  ///        "an old oak stood, surrounded",
  ///        "an old oak stood, surrounded by",
  ///        "an old oak stood, surrounded by natures.",
  ///        "old oak stood, surrounded",
  ///        "old oak stood, surrounded by",
  ///        "old oak stood, surrounded by natures.",
  ///        "oak stood, surrounded",
  ///        "oak stood, surrounded by",
  ///        "oak stood, surrounded by natures.",
  ///        "stood, surrounded by",
  ///        "stood, surrounded by natures.",
  ///        "surrounded by natures."
  ///      ];

  static List<String?> separateIntoPhrasesWithMinimumLength({
    required final String sentence,
    required final int minPhraseLength,
  }) {
    final Set<String> listOfPhrases = {};

    final List<String> wordList = sentence.split(' ');

    int length = wordList.join(' ').length;

    while (length >= minPhraseLength) {
      String phrase = wordList.removeAt(0);

      for (final word in wordList) {
        phrase = '$phrase $word';
        if (phrase.length >= minPhraseLength) {
          listOfPhrases.add(phrase);
        }
      }
      length = wordList.join(' ').length;
    }

    return listOfPhrases.toList();
  }

  /// Finds the longest description in a list of description records.
  static int getLongestDescription(
      {required final List<(int, String)> descriptions}) {
    return descriptions.fold(
        0,
        (final maxLength, final record) =>
            maxLength > record.$2.length ? maxLength : record.$2.length);
  }
}
