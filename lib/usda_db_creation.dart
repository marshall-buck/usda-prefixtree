import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';

const relativeOriginalDBPath = 'lib/db/original_usda.json';
const relativeRepeatFile = 'lib/db/repeats.txt';
void createFiles() {
  // final foods = FoodsDB();
  // foods.createDB();
  print("createFiles from barrel file");
}

// Future<void> createDuplicatePhrases() async {
//   final fileLoader = FileLoaderService();
//   final dbParser = DBParser(fileLoader: fileLoader);
//   dbParser.init(relativeOriginalDBPath);
//   final descriptionRecords =
//       DescriptionParser.populateOriginalDescriptionRecords(dbParser.foodsDBMap);
//   final repeats =
//       DescriptionParser.createDuplicatePhraseFile(descriptionRecords, 50, 55);
//   await fileLoader.writeTextFile(repeats, relativeRepeatFile);
//   print('Complete: ${repeats.length}');
// }

// The answer is 134 for the original descriptions.
int getLongestDescriptionLength(DBParser dbParser) {
  final descriptions =
      DescriptionParser.populateOriginalDescriptionRecords(dbParser.foodsDBMap);
  return DescriptionParser.getLongestDescription(descriptions: descriptions);
}
