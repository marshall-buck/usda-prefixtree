import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:usda_db_creation/helpers/file_helpers.dart';

void main() async {
  final wordIndex = await readJsonFile('lib/db/word_index_db.json');
  final indexMap = createSubstrings(wordIndex);
  final index = createHashTable(indexMap);
  // final hashTable = index['hashTable'];
  // final newWordIndex = index['newWordIndex'];

  // await writeJsonFile('lib/db/substring_index.json', newWordIndex);
  // var stringKeyMap =
  //     hashTable.map((key, value) => MapEntry(key.toString(), value));
  await writeJsonFile('lib/db/substring_hash.json', index);
}

const window = 3;

Map<String, List<String>> createSubstrings(final Map<dynamic, dynamic> sortedMap) {
  final indexMap = SplayTreeMap<String, Set<String>>((final a, final b) => a.compareTo(b));

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

  return indexMap.map((final key, final value) => MapEntry(key, value.toList()..sort()));
}

Map<String, dynamic> createHashTable(final Map<String, List<String>> originalMap) {
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

  Map<String, List<String>> stringKeyMap =
      hashTable.map((final key, final value) => MapEntry(key.toString(), value));

  return {"substrings": newWordIndex, "indexHash": stringKeyMap};
}

int findHashKey(
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

// bool doesContainList(Map<int, List<String>> map, List listToCheck) {
//   final listEquals = ListEquality();
//   return map.values.any((list) => listEquals.equals(list, listToCheck));
// }
