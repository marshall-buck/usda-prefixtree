import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:usda_db_creation/file_loader_service.dart';

import 'setup/setup.dart';

void main() {
  setUpAll(() {
    set_up_all();
  });

  tearDown(() {
    tear_down();
  });
  group('FileService class tests', () {
    // tearDown(() async {
    //   final testDirectory =
    //       Directory(p.join(pathToTestFiles, fileService.fileHash));
    //   if (await testDirectory.exists()) {
    //     await testDirectory.delete(recursive: true);
    //   }
    // });

    group('writeFileByType method tests', () {
      test('should write list contents to a text file', () async {
        // final fileName = 'testList';
        final listContents = ['item1', 'item2', 'item3'];

        when(() => mockFileLoaderService.pathToFiles)
            .thenReturn(p.join('test', 'test_files'));

        when(() => mockFileLoaderService.fileHash)
            .thenReturn('2021-09-01_12:00:00.000');

        when(() => mockFileLoaderService.writeFileByType<List, Null>(
              fileName: 'testList',
              convertKeysToStrings: false,
              listContents: any<List>(named: 'listContents'),
            )).thenAnswer((_) => Future.value());

        await mockFileLoaderService.writeFileByType<List, Null>(
          fileName: 'testList',
          convertKeysToStrings: false,
          listContents: listContents,
        );
      });

      // test('should write map contents to a json file', () async {
      //   final fileName = 'testMap';
      //   final mapContents = {'key1': 'value1', 'key2': 'value2'};

      //   await fileService.writeFileByType(
      //     fileName: fileName,
      //     convertKeysToStrings: false,
      //     mapContents: mapContents,
      //   );

      //   final filePath = p.join(pathToTestFiles, '$fileName.json');
      //   final file = File(filePath);

      //   expect(await file.exists(), isTrue);
      //   expect(jsonDecode(await file.readAsString()), mapContents);
      // });

      // test('should throw ArgumentError when no contents are provided', () {
      //   expect(
      //     () async => await fileService.writeFileByType(
      //       fileName: 'testEmpty',
      //       convertKeysToStrings: false,
      //     ),
      //     throwsA(isA<ArgumentError>()),
      //   );
      // });
    });

    // group('readCsvFile method tests', () {
    //   test('should read CSV file and return its contents as a list of lists',
    //       () async {
    //     final filePath = p.join(pathToTestFiles, 'test_file.csv');

    //     final result = await fileService.readCsvFile(filePath);

    //     final d = DeepCollectionEquality();
    //     expect(
    //         d.equals(result, [
    //           ["id", "name", "unit_name", "nutrient_nbr", "rank"],
    //           ["1002", "Nitrogen", "G", "202", "500"],
    //           ["1003", "Protein", "G", "203", "600"],
    //           ["1004", "Total lipid (fat)", "G", "204", "800"],
    //           ["1005", "Carbohydrate, by difference", "G", "205", "1110"]
    //         ]),
    //         true);
    //   });

    //   // Additional tests for error handling, etc., could be added here.
    // });

    // group('loadData method tests', () {
    //   test('should read file and return its contents as a string', () async {
    //     final filePath = p.join(pathToTestFiles, 'test_file.txt');
    //     final testContent = 'This is a test string.';

    //     final result = fileService.loadData(filePath: filePath);

    //     expect(result, testContent);
    //   });

    //   // Additional tests for error handling, etc., could be added here.
    // });

    // Additional groups for other methods...
  });
}
