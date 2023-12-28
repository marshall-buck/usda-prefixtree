import 'package:usda_db_creation/db_parser.dart';

import 'package:usda_db_creation/file_loader_service.dart';
import 'package:usda_db_creation/usda_db.dart' as db;

// import '../test/create_word_index_test.dart';

const relativeOriginalDBPath = 'lib/db/original_usda.json';
const relativeRepeatFile = 'lib/db/repeats.txt';

void main() async {
  final fileLoaderService = FileLoaderService();
  final dbParser = DBParser.init(
      path: relativeOriginalDBPath, fileLoaderService: fileLoaderService);

  await db.writeDescriptionsToFile(
      fileLoaderService: fileLoaderService, dbParser: dbParser);

  // usda_db_creation.writeDuplicatePhrasesToFile(
  //     fileLoaderService: fileLoaderService, dbParser: dbParser);
  // print(usda_db_creation.getFoodCategories(db: dbParser));
}
