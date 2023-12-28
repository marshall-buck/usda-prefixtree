// Class to handle the map of sords to index ands thier locations in the database.
// The words and locations are created for the DecsriptionRecords method
// - createFinalDescriptionMapFromFile
import 'dart:collection';

import 'package:usda_db_creation/global_const.dart';
import 'package:usda_db_creation/string_ext.dart';

class AutocompleteWordIndex {
  /// Populates a [SplayTreeMap] where the key is a [word] and the
  /// value is a list of id's from the [db].
  ///
  /// Parameters:
  /// [descriptionMap] - the [Map] from the json file.
  ///
  /// Returns - [indexMap]
  ///  {..."apple": ["167782",..],
  ///      "apples": [ "173175", "174170",...],
  ///      "orange": [ "171686", "171687",...], ...}.
  static SplayTreeMap<String, List<String>> populateIndexMap(
      {required final Map<int, String> descriptionMap}) {
    final indexMap = SplayTreeMap<String, List<String>>(
        (final a, final b) => a.compareTo(b));

    for (final entry in descriptionMap.entries) {
      final sanitizedList = entry.value.getWordsToIndex();
      if (sanitizedList.isNotEmpty) {
        for (final word in sanitizedList) {
          if (!word.isStopWord(stopWords) && word.length > 1) {
            indexMap.containsKey(word)
                ? indexMap[word]!.add(entry.key.toString())
                : indexMap[word] = [entry.key.toString()];
          }
        }
      }
    }

    return indexMap;
  }
}
