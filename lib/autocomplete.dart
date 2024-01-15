import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:usda_db_creation/data_structure.dart';
import 'package:usda_db_creation/db_parser.dart';

import 'package:usda_db_creation/extensions/string_ext.dart';
import 'package:usda_db_creation/word_index.dart';

class AutoCompleteHashTable {
  late final Map<String, Map<String, int>> substrings;
  late final Map<String, Map<int, List<String>>> indexHash;

  // AutoCompleteHashTable(this.substrings, this.indexHash);

  Map<String, dynamic> toJson() {
    return {
      'substrings': substrings,
      'indexHash': indexHash,
    };
  }

  @override
  String toString() {
    return 'AutoCompleteHashTable(substrings: $substrings, indexHash: $indexHash)';
  }
}

/// Class to handle the word index for the autocomplete search.
class AutocompleteHash implements DataStructure {
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
  @override
  Map<String, dynamic> createDataStructure(
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
