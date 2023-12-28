import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:usda_db_creation/file_loader_service.dart';

import 'package:usda_db_creation/search_hash.dart';

import 'setup/mock_data.dart';

//  cSpell: disable
void main() {
  group('create reverse index tests', () {
    group('createSubstrings() - ', () {
      test('substrings populates correctly', () async {
        // final FileLoaderService fileLoaderService = FileLoaderService();
        // final file = await fileLoaderService
        //     .readJsonFile('test/data/test_word_index.json');
        final res = SearchHash.createSubstrings(mockWordIndex);
        final deep = DeepCollectionEquality();

        expect(deep.equals(res, indexRes), true);
      });
    });
    group('createHashTable() - ', () {
      test('returns correct list', () async {
        final res = SearchHash.createHashTable(indexRes);
        final d = DeepCollectionEquality();
        // print(res);
        expect(d.equals(res['substrings'], newIndex['substrings']), true);
        expect(d.equals(res['hashIndex'], newIndex['hashIndex']), true);
      });
    });
  });
}

const Map<String, List<String>> indexRes = {
  'aba': ['3', '4'],
  'abap': ['3', '4'],
  'abapp': ['3', '4'],
  'abappl': ['3', '4'],
  'abapple': ['3', '4'],
  'app': ['1', '2', '3', '4'],
  'appl': ['1', '2', '3', '4'],
  'apple': ['1', '2', '3', '4'],
  'bap': ['3', '4'],
  'bapp': ['3', '4'],
  'bappl': ['3', '4'],
  'bapple': ['3', '4'],
  'cra': ['3', '4'],
  'crab': ['3', '4'],
  'craba': ['3', '4'],
  'crabap': ['3', '4'],
  'crabapp': ['3', '4'],
  'crabappl': ['3', '4'],
  'crabapple': ['3', '4'],
  'ple': ['1', '2', '3', '4'],
  'ppl': ['1', '2', '3', '4'],
  'pple': ['1', '2', '3', '4'],
  'rab': ['3', '4'],
  'raba': ['3', '4'],
  'rabap': ['3', '4'],
  'rabapp': ['3', '4'],
  'rabappl': ['3', '4'],
  'rabapple': ['3', '4'],
};

const Map<int, List<String>> hashRes = {
  0: ['3', '4'],
  1: ['1', '2', '3', '4']
};

const Map<String, dynamic> newIndex = {
  'substrings': {
    'aba': 0,
    'abap': 0,
    'abapp': 0,
    'abappl': 0,
    'abapple': 0,
    'app': 1,
    'appl': 1,
    'apple': 1,
    'bap': 0,
    'bapp': 0,
    'bappl': 0,
    'bapple': 0,
    'cra': 0,
    'crab': 0,
    'craba': 0,
    'crabap': 0,
    'crabapp': 0,
    'crabappl': 0,
    'crabapple': 0,
    'ple': 1,
    'ppl': 1,
    'pple': 1,
    'rab': 0,
    'raba': 0,
    'rabap': 0,
    'rabapp': 0,
    'rabappl': 0,
    'rabapple': 0,
  },
  'indexHash': {
    0: ['3', '4'],
    1: ['1', '2', '3', '4']
  }
};
