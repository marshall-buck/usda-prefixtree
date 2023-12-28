import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:usda_db_creation/global_const.dart';
import 'package:usda_db_creation/string_ext.dart';

/// Class to handle the word index for the autocomplete search.
class Autocomplete {
  static int window = 3;

  /// Populates a [SplayTreeMap] where the key is a [word] and the
  /// value is a list of id's from the [db].
  ///
  /// Parameters:
  /// [descriptionMap] - the [DescriptionRecords] from a text file.
  ///
  /// Returns - [SplayTreeMap]
  ///  {..."apple": ["167782",..],
  ///      "apples": [ "173175", "174170",...],
  ///      "orange": [ "171686", "171687",...], ...}.
  static Map<String, List<String>> createAutocompleteIndexMap(
      {required final Map<int, String> descriptionMap}) {
    final indexMap = SplayTreeMap<String, List<String>>(
        (final a, final b) => a.compareTo(b));

    for (final entry in descriptionMap.entries) {
      final sanitizedList = entry.value.getWordsToIndex();
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
                ? indexMap[word]!.add(entry.key.toString())
                : indexMap[word] = [entry.key.toString()];
          }
        }
      }
    }

    return indexMap;
  }

  /// Creates substrings from the given [autoCompleteMap] and returns a map of
  /// substrings to a list of corresponding index's.
  ///
  /// Example usage:
  /// ```dart
  /// final autoCompleteMap = {
  ///   'apple': ['1', '2'],
  ///   'crabapple': ['3', '4'],
  /// };
  ///
  /// final indexMap = createSubstrings(autoCompleteMap: autoCompleteMap);
  /// ```
  /// { 'aba': ['3', '4'],
  ///   'abap': ['3', '4'],
  ///   'abapp': ['3', '4'],
  ///   'abappl': ['3', '4'],
  ///   'abapple': ['3', '4'],
  ///   'app': ['1', '2', '3', '4'],
  ///   'appl': ['1', '2', '3', '4'],
  ///   'apple': ['1', '2', '3', '4'],
  ///   'bap': ['3', '4'],
  ///   'bapp': ['3', '4'],
  ///   'bappl': ['3', '4'],
  ///   'bapple': ['3', '4'],
  ///   'cra': ['3', '4'],
  ///   'crab': ['3', '4'],
  ///   'craba': ['3', '4'],
  ///   'crabap': ['3', '4'],
  ///   'crabapp': ['3', '4'],
  ///   'crabappl': ['3', '4'],
  ///   'crabapple': ['3', '4'],
  ///   'ple': ['1', '2', '3', '4'],
  ///   'ppl': ['1', '2', '3', '4'],
  ///   'pple': ['1', '2', '3', '4'],
  ///   'rab': ['3', '4'],
  ///   'raba': ['3', '4'],
  ///   'rabap': ['3', '4'],
  ///   'rabapp': ['3', '4'],
  ///   'rabappl': ['3', '4'],
  ///   'rabapple': ['3', '4'],
  /// }
  /// ```
  static Map<String, List<String>> createSubstrings(
      {required final Map<String, List<String>> autoCompleteMap}) {
    final indexMap =
        SplayTreeMap<String, Set<String>>((final a, final b) => a.compareTo(b));

    for (final item in autoCompleteMap.entries) {
      final String word = item.key;

      final List<String> indexList = List<String>.from(item.value);

      for (int i = 0; i < word.length; i++) {
        for (int j = i + window; j <= word.length; j++) {
          final String substring = word.substring(i, j);

          if (!indexMap.containsKey(substring)) {
            indexMap[substring] = <String>{};
          }

          indexMap[substring]!.addAll(indexList);
        }
      }
    }

    return indexMap
        .map((final key, final value) => MapEntry(key, value.toList()..sort()));
  }

  static Map<String, dynamic> createHashTable(
      final Map<String, List<String>> originalMap) {
    final Map<String, int> newWordIndex = {};
    final Map<int, List<String>> hashTable = {};
    int count = 0;

    for (final element in originalMap.entries) {
      final List<String> indexListValue = element.value;
      final int hashKey = findHashKey(
          indexListFromSubstring: indexListValue, hashTable: hashTable);

      if (hashKey == -1) {
        hashTable[count] = indexListValue;
        newWordIndex[element.key] = count;
        count++;
      }

      if (hashKey >= 0) {
        newWordIndex[element.key] = hashKey;
      }
    }

    final Map<String, List<String>> stringKeyMap = hashTable
        .map((final key, final value) => MapEntry(key.toString(), value));

    return {"substrings": newWordIndex, "indexHash": stringKeyMap};
  }

  static int findHashKey(
      {required final List<String> indexListFromSubstring,
      required final Map<int, List<String>> hashTable}) {
    for (final element in hashTable.entries) {
      final int hashKey = element.key;

      final listEquals = ListEquality();
      if (listEquals.equals(element.value, indexListFromSubstring)) {
        return hashKey;
      }
    }
    return -1;
  }
}
