import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/file_loader_service.dart';
import 'package:usda_db_creation/global_const.dart';

typedef DescriptionRecord = (int, String);
typedef DescriptionMap = Map<int, String>;

/// Abstract class for descriptions. Any class that implements this class
/// must implement the [createDescriptionMap] method.  As this is needed for
/// populating the main foods database and for creating the autocomplete hash map.
abstract class Description {
  Future<DescriptionMap?> createDescriptionMap({
    required DBParser dbParser,
    bool returnMap,
    bool? writeListToFile,
    bool? writeMapToFile,
  });
}

/// A class for parsing description strings from the [originalFoodsList].
/// A map of {{foodId: description}, ...} is needed, for both populating
/// the main foods database and for creating the autocomplete hash map.

class DescriptionParser implements Description {
  /// Creates Description Map from the original foods list.  This is the only method
  /// that needs to be called to create the final description map. All other methods
  /// are helper methods.
  ///
  /// Parameters:
  /// [dbParser] - the DBParser object.
  /// [returnMap] - if true, the map will be returned.
  /// [writeListToFile] - if true, the list will be written to a file.
  /// [writeMapToFile] - if true, the map will be written to a file.
  ///
  ///
  /// Returns:
  /// { 167512: 'Pillsbury Golden Layer Buttermilk Biscuits, (Artificial Flavor,) refrigerated dough' ,
  ///   167513: 'Pillsbury, Cinnamon Rolls with Icing, 100% refrigerated dough',
  ///   167514: 'Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry, 2% milk', ...}

  @override
  Future<DescriptionMap?> createDescriptionMap({
    required DBParser dbParser,
    bool returnMap = true,
    bool? writeListToFile,
    bool? writeMapToFile,
  }) async {
    if (!returnMap && !writeListToFile! && !writeMapToFile!) {
      throw ArgumentError(
          'One of the following parameters must be true: returnMap, writeListToFile, writeMapToFile');
    }
    final descriptions = DescriptionParser.createOriginalDescriptionRecords(
        originalFoodsList: dbParser.originalFoodsList);

    final descriptionsFinal =
        DescriptionParser.removeUnwantedPhrasesFromDescriptions(
            descriptions: descriptions, unwantedPhrases: unwantedPhrases);

    final DescriptionMap descriptionMap = {};
    for (final line in descriptionsFinal) {
      final MapEntry<int, String> entry = MapEntry(line.$1, line.$2);

      descriptionMap[entry.key] = entry.value;
    }
    final fileHash = dbParser.fileLoaderService.fileHash;

    if (writeListToFile == true) {
      await dbParser.fileLoaderService.writeFileByType(
          contents: descriptionsFinal,
          fileName: '${fileHash}_$fileNameFinalDescriptionsTxt');
    }

    if (writeMapToFile == true) {
      final convertedMap =
          descriptionMap.map((key, value) => MapEntry(key.toString(), value));
      await dbParser.fileLoaderService.writeFileByType(
          contents: convertedMap,
          fileName: '${fileHash}_$fileNameFinalDescriptionsMap');
    }

    if (!returnMap) {
      return null;
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

  /// Helper method to create a [DescriptionMap] from a txt file at [filePath].
  /// The text file must be in the format of 1 (id, description) per line
  static DescriptionMap parseDescriptionsFromTxt(
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
  // TODO: Add this method to parse a json file.
  // /// Helper method to create a [DescriptionMap] from a txt file at [filePath].
  // /// The text file must be in the format of 1 (id, description) per line
  // static DescriptionMap parseDescriptionsFromJson(
  //     {required final String filePath,
  //     required final FileLoaderService fileLoaderService}) {
  //   final String fileContents = fileLoaderService.loadData(filePath: filePath);
  //   final Map<String, dynamic> jsonMap = jsonDecode(fileContents);

  //     descriptionMap[entry.key] = entry.value;
  //   }
  //   return descriptionMap;
  // }

  /// Helper method to parse a description record from a line in a txt file.
  static MapEntry<int, String> parseDescriptionRecordFromString(
      final String line) {
    final int id = int.parse(line.substring(1, 7));
    final String description = line.substring(9, line.length - 1);

    return MapEntry(id, description);
  }

  /// Helper Method to get the longest description in a list of [DescriptionRecord]s.
  static int getLongestDescription(
      {required final List<DescriptionRecord> descriptions}) {
    return descriptions.fold(
        0,
        (final maxLength, final record) =>
            maxLength > record.$2.length ? maxLength : record.$2.length);
  }

  /// Helper method to create a frequency map of repeated phrases in a list of strings.
  ///
  /// Parameters:
  /// [listOfRecords] - the list of [DescriptionRecord]s.
  /// [minPhraseLength] - the minimum length of the phrase to be included in the map.
  /// [minNumberOfDuplicatesToShow] - the minimum number of duplicate phrases to be included in the map.
  ///
  ///
  /// Returns:
  ///   {Lorem ipsum: 3,
  ///     Lorem ipsum dolor: 3,
  ///     Lorem ipsum dolor sit: 2,
  ///     Lorem ipsum dolor sit amet: 2,
  ///     ipsum dolor: 3,
  ///     ipsum dolor sit: 2, ...}
  ///

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

  /// Helper method to create a list of phrase's from a [sentence].
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

  /// Helper method to check if a food item is in an excluded category.
  ///  [excludedCategories] can be found in [global_const.dart].
  static isExcludedCategory({required final Map<dynamic, dynamic> foodItem}) {
    final foodCategory = foodItem['foodCategory'];
    final foodCategoryDescription = foodCategory['description'];
    return excludedCategories.contains(foodCategoryDescription);
  }
}
