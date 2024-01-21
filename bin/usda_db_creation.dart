// ignore_for_file: unused_import

import 'package:usda_db_creation/autocomplete.dart';
import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';

import 'package:usda_db_creation/file_loader_service.dart';
import 'package:usda_db_creation/global_const.dart';
import 'package:usda_db_creation/substrings.dart';
import 'package:usda_db_creation/usda_db.dart' as runner;
import 'package:usda_db_creation/word_index.dart';

void main() async {
  // Initialize the file loader service. The filename hash is created in the FileService class.
  final fileService = FileService();

  final dbParser = DBParser.init(
      filePath: fileService.fileNameOriginalDBFile, fileService: fileService);
  await runner.createDBFiles(
      dbParser: dbParser, fileService: fileService, extras: true);

  // final descriptions = DescriptionParser();

  // final desMap = await descriptions.createDataStructure(
  //     dbParser: dbParser, writeFile: true, returnData: true);
  // final wordIndex = WordIndexMap(desMap!);
  // final wordIndexMap =
  //     await wordIndex.createDataStructure(dbParser: dbParser, writeFile: true);
  // final substring = Substrings(wordIndexMap!);
  // final substringMap =
  //     await substring.createDataStructure(dbParser: dbParser, writeFile: false);
  // final hashTable = AutoCompleteHashTable(substringMap!);
  // await hashTable.createDataStructure(dbParser: dbParser, writeFile: true);

  // final db = DB(desMap);
  // db.createDataStructure(dbParser: dbParser, writeFile: true);
}
