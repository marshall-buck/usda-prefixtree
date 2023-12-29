import 'package:usda_db_creation/file_loader_service.dart';
import 'package:usda_db_creation/global_const.dart';

typedef DescriptionRecord = (int, String);

/// A class for parsing description strings from the [originalFoodsList].
class DescriptionParser {
  //
  /// Parses [originalFoodsList] to create a list of description records.
  /// Removes unwanted categories from the list.
  static List<(int, String)> createOriginalDescriptionRecords(
      {required final List<dynamic> originalFoodsList}) {
    return originalFoodsList
        .map((final food) {
          final int id = food["fdcId"];
          assert(food["fdcId"] != null);

          final foodCategory = food['foodCategory'];
          final foodCategoryDescription = foodCategory['description'];
          if (!excludedCategories.contains(foodCategoryDescription)) {
            return (id, food["description"] as String);
          }
          return null; // Add this line to handle the case where the return value may be null.
        })
        .whereType<(int, String)>()
        .toList(); // Add this line to convert the nullable values to non-null values.
  }

  /// Creates a frequency map of repeated phrases in the description records.
  ///
  ///  Will only include phrases that repeat more than [minNumberOfDuplicatesToShow].

  static Map<String, int> createRepeatedPhraseFrequencyMap(
      {required final List<DescriptionRecord> listOfRecords,
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
      {required final List<DescriptionRecord> descriptions}) {
    return descriptions.fold(
        0,
        (final maxLength, final record) =>
            maxLength > record.$2.length ? maxLength : record.$2.length);
  }

  static List<DescriptionRecord> removeUnwantedPhrasesFromDescriptions({
    required final List<DescriptionRecord> descriptions,
    required final List<String> unwantedPhrases,
  }) {
    return descriptions.map((final record) {
      String description = record.$2;
      for (final phrase in unwantedPhrases) {
        if (description.contains(phrase)) {
          description = description.replaceAll(phrase, '');
        }
      }
      return (record.$1, description);
    }).toList();
  }

  /// Creates the final description map from a text file. Use this map when creating
  /// the autpocomplete list, and the food models.
  static createFinalDescriptionMapFromFile(
      {required final String path,
      required final FileLoaderService fileLoaderService}) {
    final String fileContents = fileLoaderService.loadData(path);
    final List<String> lines = fileContents.split('\n');

    lines.removeWhere(
        (final line) => line.isEmpty); // Add this line to remove empty lines.
    final Map<int, String> descriptionMap = {};
    for (final line in lines) {
      final MapEntry<int, String> entry =
          parseDescriptionRecordFromString(line);

      descriptionMap[entry.key] = entry.value;
    }
    return descriptionMap;
  }

  static MapEntry<int, String> parseDescriptionRecordFromString(
      final String line) {
    final int id = int.parse(line.substring(1, 7));
    final String description = line.substring(9, line.length - 1);

    return MapEntry(id, description);
  }
}
