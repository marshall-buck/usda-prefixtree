import 'dart:collection';

import 'package:collection/collection.dart';

class SearchHash {
  static int window = 3;

  static Map<String, List<String>> createSubstrings(
      final Map<dynamic, dynamic> sortedMap) {
    final indexMap =
        SplayTreeMap<String, Set<String>>((final a, final b) => a.compareTo(b));

    for (var item in sortedMap.entries) {
      String word = item.key;

      List<String> indexList = List<String>.from(item.value);

      for (int i = 0; i < word.length; i++) {
        for (int j = i + window; j <= word.length; j++) {
          String substring = word.substring(i, j);

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
    Map<String, int> newWordIndex = {};
    Map<int, List<String>> hashTable = {};
    int count = 0;

    for (var element in originalMap.entries) {
      List<String> indexListValue = element.value;
      int hashKey = findHashKey(
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

    Map<String, List<String>> stringKeyMap = hashTable
        .map((final key, final value) => MapEntry(key.toString(), value));

    return {"substrings": newWordIndex, "indexHash": stringKeyMap};
  }

  static int findHashKey(
      {required final List<String> indexListFromSubstring,
      required final Map<int, List<String>> hashTable}) {
    for (var element in hashTable.entries) {
      int hashKey = element.key;

      final listEquals = ListEquality();
      if (listEquals.equals(element.value, indexListFromSubstring)) {
        return hashKey;
      }
    }
    return -1;
  }
}
