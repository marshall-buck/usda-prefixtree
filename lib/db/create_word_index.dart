import 'dart:collection';

import '../helpers/file_helpers.dart';
import '../helpers/string_helpers.dart';

const filePath = 'lib/db/word_index_db.json';

void main() async {
  final db = await readJsonFile('lib/db/db.json');
  final unsortedIndexes = populateIndexMap(db);
  final sorted = sortByDescription(unsortedIndexes, db);
  await writeJsonFile(filePath, sorted);
}

/// Populates a [SplayTreeMap] where the key is a [word] and the
/// value is a list of id's from the [db].
///
/// Parameters:
/// [db] - the [Map] from the json file.
///
/// Returns - [indexMap]
///  {..."apple": ["167782",..],
///      "apples": [ "173175", "174170",...],
///      "orange": [ "171686", "171687",...], ...}.
SplayTreeMap<String, List<String>> populateIndexMap(Map<dynamic, dynamic> db) {
  final indexMap = SplayTreeMap<String, List<String>>((a, b) => a.compareTo(b));

  for (var food in db.entries) {
    final index = food.key;

    final description = food.value['description'];

    final sanitizedList = cleanSentence(description);
    if (sanitizedList.isNotEmpty) {
      for (var word in sanitizedList) {
        if (!isStopWord(word) && word.length > 2) {
          indexMap.containsKey(word)
              ? indexMap[word]!.add(index)
              : indexMap[word] = [index];
        }
      }
    }
  }

  return indexMap;
}

SplayTreeMap<String, List<String>> sortByDescription(
    SplayTreeMap<String, List<String>> unsortedMap, Map<dynamic, dynamic> db) {
  final SplayTreeMap<String, List<String>> sorted = unsortedMap;
  for (var list in sorted.values) {
    sortListByDescriptionLength(list, db);
  }
  return sorted;
}

List<String> sortListByDescriptionLength(
    List<String> itemList, Map<dynamic, dynamic> db) {
  itemList.sort((a, b) {
    int lengthA = db[a]['descriptionLength'];
    int lengthB = db[b]['descriptionLength'];
    return lengthA.compareTo(lengthB);
  });

  return itemList;
}
