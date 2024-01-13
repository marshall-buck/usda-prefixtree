import 'dart:collection';

import 'package:usda_db_creation/description_parser.dart';
import 'package:usda_db_creation/global_const.dart';
import 'package:usda_db_creation/string_ext.dart';

abstract class WordIndex {
  SplayTreeMap<String, List<int>> createAutocompleteWordIndexMap(
      {required final DescriptionMap finalDescriptionMap});
}

class WordIndexMap implements WordIndex {
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
  SplayTreeMap<String, List<int>> createAutocompleteWordIndexMap(
      {required DescriptionMap finalDescriptionMap}) {
    final indexMap =
        SplayTreeMap<String, List<int>>((final a, final b) => a.compareTo(b));

    for (final entry in finalDescriptionMap.entries) {
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
                ? indexMap[word]!.add(entry.key)
                : indexMap[word] = [entry.key];
          }
        }
      }
    }

    return indexMap;
  }
}
