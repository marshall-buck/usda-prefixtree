import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/file_loader_service.dart';
import 'package:usda_db_creation/usda_db_creation.dart' as usda_db_creation;

const relativeOriginalDBPath = 'lib/db/original_usda.json';
const relativeRepeatFile = 'lib/db/repeats.txt';

void main() async {
  final fileLoader = FileLoaderService();
  final dbParser = DBParser(fileLoader: fileLoader);
  dbParser.init(relativeOriginalDBPath);
  print(usda_db_creation.getLongestDescriptionLength(dbParser));
}
