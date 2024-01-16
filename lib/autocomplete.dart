import 'package:collection/collection.dart';
import 'package:usda_db_creation/data_structure.dart';
import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/extensions/map_ext.dart';

import 'package:usda_db_creation/global_const.dart';

class AutoCompleteHashData {
  final Map<String, int> substringHash;
  final Map<int, List<int>> indexHash;

  AutoCompleteHashData({required this.substringHash, required this.indexHash});

  Map<String, dynamic> toJson() {
    return {
      'substringHash': substringHash,
      'indexHash': indexHash.deepConvertMapKeyToString()
    };
  }
}

class AutoCompleteHashTable implements DataStructure {
  final Map<String, int> _substringHash = {};
  final Map<int, List<int>> _indexHash = {};

  final Map<String, List<int>> substringMap;

  AutoCompleteHashTable(this.substringMap);

  @override
  Future<AutoCompleteHashData?> createDataStructure(
      {required DBParser dbParser,
      bool returnData = true,
      bool writeFile = false}) async {
    _populateHashes();

    final AutoCompleteHashData data = AutoCompleteHashData(
      substringHash: _substringHash,
      indexHash: _indexHash,
    );

    if (writeFile) {
      await dbParser.fileLoaderService
          .writeFileByType<Null, Map<String, dynamic>>(
              fileName: fileNameAutocompleteHash,
              convertKeysToStrings: false,
              mapContents: data.toJson());
    }

    return returnData ? data : null;
  }

  /// Creates an indexHash table from the given [substringMap]  and
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
  //{
  ///
  /// _substringHash = {
  ///   'aba': 0,
  ///   'abap': 0,
  ///   'abapp': 0,
  ///   'abappl': 0,
  ///   'abapple': 0, ...
  ///    },
  ///   _indexHash = {
  ///     0: [3, 4],
  ///     1: [1, 2, 3, 4]
  ///    }
  ///   }
  /// ```
  /// /* Cspell: enable*/
  void _populateHashes() {
    int count = 0;

    for (final element in substringMap.entries) {
      final List<int> indexListValue = element.value;
      final int hashKey = _findHashKey(
          indexListFromSubstring: indexListValue, hashTable: _indexHash);

      if (hashKey == -1) {
        _indexHash[count] = indexListValue;
        _substringHash[element.key] = count;
        count++;
      }

      if (hashKey >= 0) {
        _substringHash[element.key] = hashKey;
      }
    }
  }

  /// Finds the hash key for the given [indexListFromSubstring] and [hashTable].
  static int _findHashKey(
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
