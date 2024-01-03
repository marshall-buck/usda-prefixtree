import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/file_loader_service.dart';
import 'package:usda_db_creation/global_const.dart';

typedef DescriptionRecord = (int, String);
typedef DescriptionMap = Map<int, String>;

/// A class for parsing description strings from the [originalFoodsList].
/// A map of {{foodId: description}, ...} is needed, for both populating
/// the main foods database and for creating the autocomplete hash map.

class DescriptionParser {
  /// Creates Description Map from the original foods list.  This is the only method
  /// that needs to be called to create the final description map. All other methods
  /// are helper methods.
  ///
  /// Parameters:
  /// [dbParser] - the DBParser object.
  /// [writeListToFile] - if true, the list will be written to a file.
  /// [writeMapToFile] - if true, the map will be written to a file.
  ///
  ///
  /// Returns:
  /// { 167512: 'Pillsbury Golden Layer Buttermilk Biscuits, (Artificial Flavor,) refrigerated dough' ,
  ///   167513: 'Pillsbury, Cinnamon Rolls with Icing, 100% refrigerated dough',
  ///   167514: 'Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry, 2% milk', ...}
  static DescriptionMap createDescriptionMapFromOriginalFoodsList(
      {required DBParser dbParser,
      bool? writeListToFile,
      bool? writeMapToFile}) {
    final descriptions = DescriptionParser.createOriginalDescriptionRecords(
        originalFoodsList: dbParser.originalFoodsList);
    // assert(descriptions.length == 3);
    final descriptionsFinal =
        DescriptionParser.removeUnwantedPhrasesFromDescriptions(
            descriptions: descriptions, unwantedPhrases: unwantedPhrases);

    final DescriptionMap descriptionMap = {};
    for (final line in descriptionsFinal) {
      final MapEntry<int, String> entry = MapEntry(line.$1, line.$2);

      descriptionMap[entry.key] = entry.value;
    }

    if (writeListToFile == true) {
      dbParser.fileLoaderService.writeListToTxtFile(
          list: descriptionsFinal,
          filePath: '$pathToFiles/$fileNameFinalDescriptionsTxt');
    }

    if (writeMapToFile == true) {
      final convertedMap =
          descriptionMap.map((key, value) => MapEntry(key.toString(), value));
      dbParser.fileLoaderService.writeJsonFile(
          filePath: '$pathToFiles/$fileNameFinalDescriptionsMap',
          contents: convertedMap);
    }
    return descriptionMap;
  }

  //************************ Helper Methods **********************************/

  /// Parses [originalFoodsList] to create a list of [DescriptionRecord].
  /// The descriptions will be unedited.
  /// This is the first method called in the process of creating the final database.
  ///
  /// The list will be filtered to remove any unwanted food categories,
  /// from the [excludedCategories] list.  The list is defined in [global_const.dart].
  ///
  /// Parameters:
  /// [originalFoodsList] - the list of food items from the original_usda.json file.
  ///
  /// Returns: [DescriptionRecord]
  ///  [(id, description), ...]

  static List<DescriptionRecord> createOriginalDescriptionRecords(
      {required final List<dynamic> originalFoodsList}) {
    return originalFoodsList
        .map((final food) {
          final int id = food["fdcId"];
          assert(food["fdcId"] != null);

          if (!isExcludedCategory(foodItem: food)) {
            return (id, food["description"] as String);
          }
          // return null; // Add this line to handle the case where the return value may be null.
        })
        .whereType<DescriptionRecord>()
        .toList(); // Add this line to convert the nullable values to non-null values.
  }

  /// Removes unwanted phrases from the descriptions.  This will
  /// mutate the description as needed and return a new list.
  ///
  /// Returns:
  ///  [(id, description), ...]
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

  /// Creates the description map from a txt file at [filePath]. the text file
  /// must be in the format of (id, description).
  ///
  /// Returns:
  /// { 167512: 'Pillsbury Golden Layer Buttermilk Biscuits, (Artificial Flavor,) refrigerated dough' ,
  ///   167513: 'Pillsbury, Cinnamon Rolls with Icing, 100% refrigerated dough',
  ///   167514: 'Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry, 2% milk', ...}
  static Map<int, String> createFinalDescriptionMapFromTxtFile(
      {required final String filePath,
      required final FileLoaderService fileLoaderService}) {
    final String fileContents = fileLoaderService.loadData(filePath: filePath);
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

  /// Parses a string from a text file into a description record.
  static MapEntry<int, String> parseDescriptionRecordFromString(
      final String line) {
    final int id = int.parse(line.substring(1, 7));
    final String description = line.substring(9, line.length - 1);

    return MapEntry(id, description);
  }

  /// Finds the longest description in a list of description records.
  static int getLongestDescription(
      {required final List<DescriptionRecord> descriptions}) {
    return descriptions.fold(
        0,
        (final maxLength, final record) =>
            maxLength > record.$2.length ? maxLength : record.$2.length);
  }

  /// Creates a frequency map of repeated phrases in the given text.

  /// Example usage:
  /// ```dart
  /// listOfRecords= ['Lorem ipsum dolor sit amet',
  ///                'Lorem ipsum dolor.',
  ///                'Lorem ipsum dolor sit amet',
  ///                'Hi there!'].
  /// createRepeatedPhraseFrequencyMap(listOfRecords: listOfRecords,
  ///                                   minPhraseLength: 10,
  ///                                   minNumberOfDuplicatesToShow: 2);
  /// Returns:
  ///   {Lorem ipsum: 3,
  ///     Lorem ipsum dolor: 3,
  ///     Lorem ipsum dolor sit: 2,
  ///     Lorem ipsum dolor sit amet: 2,
  ///     ipsum dolor: 3,
  ///     ipsum dolor sit: 2, ...}
  /// ```

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

  static isExcludedCategory({required final Map<dynamic, dynamic> foodItem}) {
    final foodCategory = foodItem['foodCategory'];
    final foodCategoryDescription = foodCategory['description'];
    return excludedCategories.contains(foodCategoryDescription);
  }
}
