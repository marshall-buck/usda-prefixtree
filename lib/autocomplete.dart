import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:usda_db_creation/data_structure.dart';
import 'package:usda_db_creation/db_parser.dart';

import 'package:usda_db_creation/extensions/string_ext.dart';

// class AutoCompleteHashTable {
//   final Map<String, Map<String, int>> substrings;
//   final Map<String, Map<int, List<String>>> indexHash;

//   AutoCompleteHashTable(this.substrings, this.indexHash);

//   Map<String, dynamic> toJson() {
//     return {
//       'substrings': substrings,
//       'indexHash': indexHash,
//     };
//   }

//   @override
//   String toString() {
//     return 'AutoCompleteHashTable(substrings: $substrings, indexHash: $indexHash)';
//   }
// }

/// Class to handle the word index for the autocomplete search.
class AutocompleteHash implements DataStructure {
  static int minLength = 3;
  @override
  Future createDataStructure(
      {required DBParser dbParser,
      bool returnData = true,
      bool writeFile = false}) {
    // TODO: implement createDataStructure
    throw UnimplementedError();
  }

  /// Minimum number of characters to use for the substring.

//TODO: Change to list of <int>.
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
  static Map<String, List<int>> createSubstringsFromWordIndex(
      {required final Map<String, List<String>> wordIndex}) {
    final indexMap =
        SplayTreeMap<String, Set<int>>((final a, final b) => a.compareTo(b));

    for (final item in wordIndex.entries) {
      final String word = item.key;

      final List<int> wordIndexList = List<int>.from(item.value);
      // this inner loop will check for numbers and percents, for these
      // we will not enforce a minimum length.
      for (int i = 0; i < word.length; i++) {
        if (word[i] == '%' || word[i].isNumber()) {
          if (!indexMap.containsKey(word[i])) {
            indexMap[word[i]] = <int>{};
          }

          indexMap[word[i].toString()]!.addAll(wordIndexList);

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

    return indexMap
        .map((final key, final value) => MapEntry(key, value.toList()..sort()));
  }

  /// Creates an indexHash table from the given [originalSubStringMap]  and
  /// rewrites the substring map with the new index values.
  ///
  /// This is the final step in creating the autocomplete hash table.
  /// Write this output to a file.
  ///
  /// Example usage:
  /// /* Cspell: disable*/
  /// ```dart
  /// final originalSubStringMap = {
  ///     'aba': [3, 4],
  ///     'abap': [3, 4],
  ///     'abapp': [3, 4],
  ///     'abappl': [3, 4], ...
  ///      };
  ///
  /// final table = createAutocompleteHashTable(originalSubStringMap: originalSubStringMap);
  /// ```
  ///
  /// Returns -  {
  ///   'substrings': {
  ///   'aba': 0,
  ///   'abap': 0,
  ///   'abapp': 0,
  ///   'abappl': 0,
  ///   'abapple': 0, ...
  ///    },
  ///   'indexHash': {
  ///     0: [3, 4],
  ///     1: [1, 2, 3, 4]
  ///    }
  ///   }
  /// ```
  /// /* Cspell: enable*/

  Map<String, dynamic> createAutocompleteHashTable(
      {required final Map<String, List<int>> originalSubStringMap}) {
    final Map<String, int> newWordIndex = {};
    final Map<int, List<int>> hashTable = {};
    int count = 0;

    for (final element in originalSubStringMap.entries) {
      final List<int> indexListValue = element.value;
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
// TODO: change index to numbers
    final Map<String, List<String>> stringKeyMap = hashTable
        .map((final key, final value) => MapEntry(key.toString(), value));

    return {"substrings": newWordIndex, "indexHash": stringKeyMap};
  }

  /// Finds the hash key for the given [indexListFromSubstring] and [hashTable].
  static int findHashKey(
      {required final List<int> indexListFromSubstring,
      required final Map<int, List<int>> hashTable}) {
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


// class MyAutoComplete extends AutoComplete {
//   @override
//   AutoCompleteHashTable createAutocompleteHashTable({final List? descriptions}) {
//     // Implementation for a method that takes a List as descriptions
//     // For example, processing the list to create an AutoCompleteHashTable
//     // ...

//     // Returning a dummy AutoCompleteHashTable for demonstration
//     return AutoCompleteHashTable({'substrings': {}}, {'indexHash': {}});
//   }

//   @override
//   AutoCompleteHashTable createSubstrings({final Map? otherObject}) {
//     // Implementation for a method that takes a Map as otherObject
//     // For example, processing the map to create an AutoCompleteHashTable
//     // ...

//     // Returning a dummy AutoCompleteHashTable for demonstration
//     return AutoCompleteHashTable({'substrings': {}}, {'indexHash': {}});
//   }
// }
