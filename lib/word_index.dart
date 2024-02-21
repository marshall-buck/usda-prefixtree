import 'dart:collection';

import 'package:usda_db_creation/data_structure.dart';
import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';
import 'package:usda_db_creation/file_service.dart';
import 'package:usda_db_creation/global_const.dart';
import 'package:usda_db_creation/extensions/string_ext.dart';

/// A class that represents a word index map.
///
/// This class implements the [DataStructure] interface and provides a method t
/// o create a word index from a given [finalDescriptionMap].
/// The word index is represented as a [SplayTreeMap] where the keys are
/// words and the values are lists of integers representing the indices of the descriptions that contain the word.
///
/// Example:
/// ```
/// WordIndexMap wordIndexMap = WordIndexMap(finalDescriptionMap);
/// SplayTreeMap<String, List<int>>? indexMap = await wordIndexMap.createDataStructure(dbParser: dbParser, returnData: true, writeFile: false);
/// ```
///
/// The [createDataStructure] method takes the following parameters:
/// - [dbParser] A [DBParser] object used for file operations.
/// - [returnData] A boolean value indicating whether to return the created
/// word index map. Default is `true`.
/// - [writeFile] A boolean value indicating whether to write the created
/// word index map to a file. Default is `false`.
///
/// If both [returnData] and [writeFile] are set to `false`, an [ArgumentError]
/// is thrown.
///
/// The method returns a [Future] that resolves to a [SplayTreeMap] of words
/// and their corresponding indices.
/// If [returnData] is set to `true`, the method returns the word index map.
/// Otherwise, it returns `null`.
///
/// Example:
/// ```
/// SplayTreeMap<String, List<int>>? indexMap = await wordIndexMap.createDataStructure(dbParser: dbParser, returnData: true, writeFile: false);
/// if (indexMap != null) {
///   // Do something with the word index map
/// }
/// ```

class WordIndexMap implements DataStructure {
  final DescriptionMap finalDescriptionMap;

  WordIndexMap(this.finalDescriptionMap);

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
  Future<SplayTreeMap<String, List<int>>?> createDataStructure(
      {required DBParser dbParser,
      bool returnData = true,
      bool writeFile = false}) async {
    if (!returnData && !writeFile) {
      throw (ArgumentError('Both returnStructure and writeFile are false'));
    }
    final indexMap =
        SplayTreeMap<String, Set<int>>((final a, final b) => a.compareTo(b));

    for (final entry in finalDescriptionMap.entries) {
      final Set<String> sanitizedList = entry.value.getWordsToIndex();
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
                : indexMap[word] = {entry.key};
          }
        }
      }
    }

    // Convert Set values to List's
    final SplayTreeMap<String, List<int>> convertedMap =
        SplayTreeMap<String, List<int>>();
    indexMap.forEach((key, value) {
      convertedMap[key] = value.toList();
    });

    if (writeFile) {
      await dbParser.fileService.writeFileByType<Null,
              SplayTreeMap<String, List<int>>>(
          fileName: FileService
              .fileNameAutocompleteWordIndex, // fileNameAutocompleteWordIndex,
          convertKeysToStrings: false,
          mapContents: convertedMap);
    }
    return returnData ? convertedMap : null;
  }
}
