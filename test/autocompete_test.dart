import 'package:collection/collection.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:usda_db_creation/autocomplete.dart';
import 'package:usda_db_creation/db_parser.dart';

import 'setup/mock_data.dart';
import 'setup/mock_db.dart';
import 'setup/setup.dart';

void main() {
  setUpAll(() {
    set_up_all();
  });

  tearDown(() {
    tear_down();
  });

  group('AutoCompleteHashTable class tests', () {
    group('createAutocompleteHashTable() - ', () {
      test('hashes list correctly', () async {
        when(() => mockFileLoaderService.loadData(filePath: 'fake'))
            .thenReturn(mockUsdaFile);
        when(() => mockFileLoaderService.fileHash)
            .thenReturn(DateTime.now().microsecondsSinceEpoch.toString());

        final dbParser = DBParser.init(
            filePath: 'fake', fileLoaderService: mockFileLoaderService);
        final hash = AutoCompleteHashTable(mockOriginalSubStringMap);
        final res = await hash.createDataStructure(dbParser: dbParser);

        final d = DeepCollectionEquality();

        expect(
            d.equals(
                res!.substringHash, autoCompleteHashTable['substringHash']),
            true);
        expect(
            d.equals(res.indexHash, autoCompleteHashTable['indexHash']), true);
      });
    });
  });
  group('AutoCompleteHashData class tests', () {
    group('toJson() - ', () {
      test('converts all keys to strings', () {
        final data = AutoCompleteHashData(
            substringHash:
                autoCompleteHashTable['substringHash'] as Map<String, int>,
            indexHash:
                autoCompleteHashTable['indexHash'] as Map<int, List<int>>);

        final json = data.toJson();
        final index = json['indexHash'];
        index.keys.forEach((key) {
          expect(key, isA<String>());
        });
        index.values.forEach((value) {
          expect(value, isA<List<int>>());
        });
      });
    });
  });
}

/* cSpell:disable */
const Map<String, dynamic> autoCompleteHashTable = {
  'substringHash': {
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
