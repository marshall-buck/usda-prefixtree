import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';
import 'package:usda_db_creation/file_loader_service.dart';

const relativeOriginalDBPath = 'lib/db/original_usda.json';
const relativeRepeatFile = 'lib/db/repeats.json';
void createFiles() {
  // final foods = FoodsDB();
  // foods.createDB();
  print("createFiles from barrel file");
}

/// Creates the duplicate phrases file and writes to [path].
Future<void> createDuplicatePhrases(
    {final int minPhraseLength = 45,
    final showResultsLongerThan = 10,
    required final FileLoaderService fileLoader,
    required final DBParser dbParser}) async {
  final descriptionRecords =
      DescriptionParser.populateOriginalDescriptionRecords(
          foodsDBMap: dbParser.foodsDBMap);

  final repeats = DescriptionParser.getRepeatedPhrases(
      listOfRecords: descriptionRecords,
      minPhraseLength: minPhraseLength,
      howManyTimesRepeated: showResultsLongerThan);

  await fileLoader.writeJsonFile(relativeRepeatFile, repeats);
  print('Complete: ${repeats.length}');
}

// The answer is 134 for the original descriptions.
int getLongestDescriptionLength(final DBParser dbParser) {
  final descriptions = DescriptionParser.populateOriginalDescriptionRecords(
      foodsDBMap: dbParser.foodsDBMap);
  return DescriptionParser.getLongestDescription(descriptions: descriptions);
}
