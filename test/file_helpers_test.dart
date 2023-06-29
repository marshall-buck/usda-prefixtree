import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:usda_db_creation/helpers/file_helpers.dart';

const testFile1 =
    "test/data/Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry.json";

const txtFilePath = 'test/data/not_json.txt';

const invalidPath = 'test/invalid/invalid.json';

/// Tests for reading and writing json files.
void main() {
  group('readJsonFile', () {
    test('should read a valid JSON file', () async {
      final map = await readJsonFile(testFile1);

      expect(map, isMap);
      expect(map['description'],
          'Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry');
    });

    test('should throw an exception if the path does not exist', () async {
      const filePath = invalidPath;

      try {
        await readJsonFile(filePath);
        fail('Expected an exception to be thrown');
      } catch (e) {
        // Assert
        expect(e, isA<PathNotFoundException>());
      }
    });

    test('should throw an exception if the file is not a JSON file', () async {
      const filePath = txtFilePath;

      try {
        await readJsonFile(filePath);
        fail('Expected an exception to be thrown');
      } catch (e) {
        // Assert
        expect(e, isA<FormatException>());
      }
    });
  });

  group('writeJsonFile', () {
    test('should write a JSON file to disk', () async {
      const filePath = 'test/output.json';
      final contents = {'name': 'John Doe', 'age': 30};

      await writeJsonFile(filePath, contents);

      final file = File(filePath);
      expect(file.existsSync(), true);
      final actualContents = await file.readAsString();
      expect(actualContents, jsonEncode(contents));
      await file.delete();
    });
  });
}
