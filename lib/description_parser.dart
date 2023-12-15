/// A class for parsing description strings from the [foodsDBMap].
class DescriptionParser {
  //
  /// Parses [foodsDBMap] to create a list of description records.
  static List<(int, String)> createOriginalDescriptionRecords(
      {required final List<dynamic> foodsDBMap}) {
    return foodsDBMap.map((final food) {
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

  /// Returns list of indexes where spaces are located in a string.
  static List<int> findAllSpacesInString(final String sentence) {
    final List<int> indexesOfSpaces = [];
    if (sentence.isEmpty) return [];
    for (var i = 0; i < sentence.length; i++) {
      if (sentence[i] == " ") {
        if (i != sentence.length - 1) indexesOfSpaces.add(i);
      }
    }
    return indexesOfSpaces;
  }

// TODO:Add functionality to stop at EACH word withing minPhrase length
  /// Creates a list of  phrase's from a [sentence].
  ///
  /// It does this from the start of the sentence, and repeats at each space.
  /// the phrase will include the first word and the last word whose character's
  /// index is at least [minPhraseLength] form the start of that phrase.
  /// The list will also include phrases from each whose to the enc of the sentence,
  /// if greater than [minPhraseLength].
  ///
  /// separateIntoPhrasesWithMinimumLength(
  ///           "Quietly, an old oak stood, surrounded by natures.", 20) =>
  ///   [
  ///        "Quietly, an old oak ",
  ///        "Quietly, an old oak stood, surrounded by natures.",
  ///        "an old oak stood, surrounded",
  ///        "an old oak stood, surrounded by natures.",
  ///        "old oak stood, surrounded",
  ///        "old oak stood, surrounded by natures.",
  ///        "oak stood, surrounded",
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

    final List<int> spacesList = findAllSpacesInString(sentence);

    spacesList.insert(0, -1);

    final int sentenceLength = sentence.length;
    if (spacesList.isEmpty) return [sentence.substring(0, sentenceLength)];
    if (sentenceLength < minPhraseLength) return listOfPhrases.toList();

    if (sentenceLength == minPhraseLength) {
      return [sentence];
    }

    for (int i = 0; i < spacesList.length; i++) {
      final int currentSpace = spacesList[i];
      if (currentSpace + minPhraseLength > sentenceLength) break;
      final int nextSpace = spacesList.firstWhere(
          (final element) => element >= currentSpace + minPhraseLength,
          orElse: () => sentenceLength);

      int subStringEndExclusive = i == 0 ? nextSpace + 1 : nextSpace;

      if (i == 0 && nextSpace != sentenceLength) {
        subStringEndExclusive = nextSpace + 1;
      } else {
        subStringEndExclusive = nextSpace;
      }

      assert(subStringEndExclusive <= sentenceLength);
      listOfPhrases
          .add(sentence.substring(currentSpace + 1, subStringEndExclusive));
      listOfPhrases.add(sentence.substring(currentSpace + 1, sentenceLength));
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
