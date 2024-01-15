import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:usda_db_creation/autocomplete.dart';

import 'setup/mock_data.dart';
import 'setup/setup.dart';

void main() {
  setUpAll(() {
    set_up_all();
  });

  tearDown(() {
    tear_down();
  });

  group('Autocomplete class tests', () {
    group('createAutocompleteHashTable() - ', () {
      test('hashes list correctly', () async {
        final autocomplete = AutocompleteHash();
        final res = autocomplete.createAutocompleteHashTable(
            originalSubStringMap: originalSubStringMap);
        final d = DeepCollectionEquality();

        expect(d.equals(res['substrings'], autoCompleteHashTable['substrings']),
            true);
        expect(d.equals(res['hashIndex'], autoCompleteHashTable['hashIndex']),
            true);
      });
    });
  });
}

/* cSpell:disable */
const Map<String, List<int>> originalSubStringMap = {
  '%': [3],
  '1': [3, 4],
  '2': [3, 4],
  'aba': [3, 4],
  'abap': [3, 4],
  'abapp': [3, 4],
  'abappl': [3, 4],
  'abapple': [3, 4],
  'app': [1, 2, 3, 4],
  'appl': [1, 2, 3, 4],
  'apple': [1, 2, 3, 4],
  'bap': [3, 4],
  'bapp': [3, 4],
  'bappl': [3, 4],
  'bapple': [3, 4],
  'cra': [3, 4],
  'crab': [3, 4],
  'craba': [3, 4],
  'crabap': [3, 4],
  'crabapp': [3, 4],
  'crabappl': [3, 4],
  'crabapple': [3, 4],
  'ple': [1, 2, 3, 4],
  'ppl': [1, 2, 3, 4],
  'pple': [1, 2, 3, 4],
  'rab': [3, 4],
  'raba': [3, 4],
  'rabap': [3, 4],
  'rabapp': [3, 4],
  'rabappl': [3, 4],
  'rabapple': [3, 4]
};

const Map<String, dynamic> autoCompleteHashTable = {
  'substrings': {
    '%': 0,
    '1': 1,
    '2': 1,
    'aba': 1,
    'abap': 1,
    'abapp': 1,
    'abappl': 1,
    'abapple': 1,
    'app': 2,
    'appl': 2,
    'apple': 2,
    'bap': 1,
    'bapp': 1,
    'bappl': 1,
    'bapple': 1,
    'cra': 1,
    'crab': 1,
    'craba': 1,
    'crabap': 1,
    'crabapp': 1,
    'crabappl': 1,
    'crabapple': 1,
    'ple': 2,
    'ppl': 2,
    'pple': 2,
    'rab': 1,
    'raba': 1,
    'rabap': 1,
    'rabapp': 1,
    'rabappl': 1,
    'rabapple': 1,
  },
  'indexHash': {
    0: [3],
    1: [3, 4],
    2: [1, 2, 3, 4],
  }
};
