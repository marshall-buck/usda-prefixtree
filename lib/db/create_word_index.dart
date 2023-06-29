import 'dart:collection';

import '../helpers/file_helpers.dart';
import '../helpers/string_helpers.dart';

const filePath = 'lib/db/word_index_db.json';

void main() async {
  final db = await readJsonFile('lib/db.json');
  final indexMap = populateIndexMap(db);
  await writeJsonFile(filePath, indexMap);
}

/// Iterate through [db], and create a map of words for a key and a list as a value.
/// Returns [indexMap]
SplayTreeMap<String, List<String>> populateIndexMap(db) {
  final indexMap = SplayTreeMap<String, List<String>>((a, b) => a.compareTo(b));

  for (var food in db.entries) {
    final index = food.key;
    final description = food.value['description'];
    final sanitizedList = stripUnwantedWords(description);
    if (sanitizedList.isNotEmpty) {
      for (var word in sanitizedList) {
        indexMap.containsKey(word)
            ? indexMap[word]!.add(index)
            : indexMap[word] = [index];
      }
    }
  }

  return indexMap;
}
