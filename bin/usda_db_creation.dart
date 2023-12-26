import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/file_loader_service.dart';
import 'package:usda_db_creation/usda_db_creation.dart' as usda_db_creation;

// import '../test/create_word_index_test.dart';

const relativeOriginalDBPath = 'lib/db/original_usda.json';
const relativeRepeatFile = 'lib/db/repeats.txt';

void main() async {
  final fileLoader = FileLoaderService();
  final dbParser = DBParser(fileLoader: fileLoader);
  dbParser.init(relativeOriginalDBPath);
  usda_db_creation.writeOriginalDescriptionsToFile(
      dbParser: dbParser, fileLoaderService: fileLoader);
  // usda_db_creation.writeDuplicatePhrasesToFile(
  //     fileLoader: fileLoader, dbParser: dbParser);
  print(usda_db_creation.getFoodCategories(db: dbParser));
}
