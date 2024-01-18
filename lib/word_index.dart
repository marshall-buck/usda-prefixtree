import 'dart:collection';

import 'package:usda_db_creation/data_structure.dart';
import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';
import 'package:usda_db_creation/file_loader_service.dart';
import 'package:usda_db_creation/global_const.dart';
import 'package:usda_db_creation/extensions/string_ext.dart';

/// Class to create a [Map] of words to index, from the Food descriptions.
/// Each key is a word that will be used in an autocomplete search.
/// the value of the word key is a list of [int]s of the food items id's.
/// Technically I could have skipped this step and created the autocomplete
/// hashes without this step, but it is useful to see a visual
/// representation of all the words and location's.
/// So this is needed for the step of creating the [AutoCompleteHashTable]
class WordIndexMap implements DataStructure {
  final DescriptionMap finalDescriptionMap;

  WordIndexMap(this.finalDescriptionMap);

  /// Creates a word index from the given [finalDescriptionMap].
  ///
  /// Parameters:
  /// [finalDescriptionMap] -  [DescriptionMap].
  ///
  /// Returns - [SplayTreeMap<String, List<int>>]
  ///  {..."apple": [167782,..],
  ///      "apples": [ 173175, 174170,...],
  ///      "orange": [ 171686, 171687,...], ...}.
  @override
  Future<SplayTreeMap<String, List<int>>?> createDataStructure(
      {required DBParser dbParser,
      bool returnData = true,
      bool writeFile = false}) async {
    if (!returnData && !writeFile) {
      throw (ArgumentError('Both returnStructure and writeFile are false'));
    }
    final indexMap =
        SplayTreeMap<String, Set<int>>((final a, final b) => a.compareTo(b));

    for (final entry in finalDescriptionMap.entries) {
      final Set<String> sanitizedList = entry.value.getWordsToIndex();
      if (sanitizedList.isNotEmpty) {
        for (String word in sanitizedList) {
          if (word.startsWith('(')) {
            word = word.substring(1);
          }
          if (word.endsWith(')')) {
            word = word.substring(0, word.length - 1);
          }
          if (word.isStopWord(stopWords) ||
              !word.isLowerCaseOrNumberWithPercent()) {
            continue;
          } else if (!word.isNumberWithPercent() && word.length < 3) {
            continue;
          } else {
            indexMap.containsKey(word)
                ? indexMap[word]!.add(entry.key)
                : indexMap[word] = {entry.key};
          }
        }
      }
    }

    // Convert Set values to List's
    final SplayTreeMap<String, List<int>> convertedMap =
        SplayTreeMap<String, List<int>>();
    indexMap.forEach((key, value) {
      convertedMap[key] = value.toList();
    });

    if (writeFile) {
      await dbParser.fileLoaderService.writeFileByType<Null,
              SplayTreeMap<String, List<int>>>(
          fileName: FileLoaderService
              .fileNameAutocompleteWordIndex, // fileNameAutocompleteWordIndex,
          convertKeysToStrings: false,
          mapContents: convertedMap);
    }
    return returnData ? convertedMap : null;
  }
}
