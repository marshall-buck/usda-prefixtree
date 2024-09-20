import 'dart:collection';

import 'package:usda_db_creation/data_structure.dart';
import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/extensions/string_ext.dart';
import 'package:usda_db_creation/file_service.dart';

/// A class that creates substrings from a given word index map.
///
/// The [Substrings] class implements the [DataStructure] interface.
///
/// Example usage:
/// ```dart
/// final wordIndexMap = {'apple': [1, 2], 'crabapple': [3, 4]};
/// final substrings = Substrings(wordIndexMap);
/// final result = await substrings.createDataStructure(dbParser: dbParser);
/// print(result);
/// ```
///
/// The [Substrings] class has the following properties:
/// - [wordIndexMap] A map that contains words as keys and a list of corresponding indices as values.
/// - [minLength] An integer representing the minimum number of characters to use for the substring.
///
/// The [Substrings] class has the following methods:
/// - [createDataStructure] Creates substrings from the given [wordIndexMap] and returns a map of substrings with a minimum length.
///   - Parameters:
///     - [dbParser] A required [DBParser] object used for file operations.
///     - [returnData] A boolean indicating whether to return the created data structure. Default is true.
///     - [writeFile] A boolean indicating whether to write the created data structure to a file. Default is false.
///   - Returns:
///     - A [Future] that resolves to a map of substrings with a minimum length to a list of corresponding indices.
///       If [returnData] is false, the future resolves to null.
class Substrings implements DataStructure {
  Map<String, List<int>> wordIndexMap;
  Substrings(this.wordIndexMap);

  /// Minimum number of characters to use for the substring.
  int minLength = 2;

  /// Creates substrings from the given [wordIndex] and returns a map of
  /// substrings with a minimum of [minLength] length to a list of corresponding index's.
  ///
  ///  {'apple': [1, 2], 'crabapple': [3, 4] };
  ///
  /// /* Cspell: disable*/
  /// Returns:
  /// { 'aba': [3, 4],
  ///   'abap': [3, 4],
  ///   'abapp': [3, 4],
  ///   'abappl': [3, 4],
  ///   'abapple': [3, 4], ... }

  /// /* Cspell: enable*/

  @override
  Future<Map<String, List<int>>?> createDataStructure(
      {required DBParser dbParser,
      bool returnData = true,
      bool writeFile = false}) async {
    if (!returnData && !writeFile) {
      throw (ArgumentError('Both returnStructure and writeFile are false'));
    }
    final indexMap =
        SplayTreeMap<String, Set<int>>((final a, final b) => a.compareTo(b));

    for (final item in wordIndexMap.entries) {
      final String word = item.key;

      final List<int> wordIndexList = List<int>.from(item.value);

      for (int i = 0; i < word.length; i++) {
        // If the word is a number followed by a % or just a number,
        //add it to the indexMap directly, and skip the iteration.
        if (word.isNumberWithPercent() || word.isNumber()) {
          if (!indexMap.containsKey(word)) {
            indexMap[word] = <int>{};
          }
          indexMap[word.toString()]!.addAll(wordIndexList);

          continue;
        }

        for (int j = i + minLength; j <= word.length; j++) {
          final String substring = word.substring(i, j);

          if (!indexMap.containsKey(substring)) {
            indexMap[substring] = <int>{};
          }

          indexMap[substring]!.addAll(wordIndexList);
        }
      }
    }

    final sortedMap = indexMap
        .map((final key, final value) => MapEntry(key, value.toList()..sort()));

    if (writeFile) {
      await dbParser.fileService.writeFileByType<Null, Map<String, List<int>>>(
          fileName: FileService.fileNameSubstrings, // fileNameSubstrings,
          convertKeysToStrings: false,
          mapContents: sortedMap);
    }

    return returnData ? sortedMap : null;
  }
}
