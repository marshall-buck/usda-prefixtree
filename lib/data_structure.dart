import 'package:usda_db_creation/db_parser.dart';

/// Abstract class for the database data structures.
/// All classes that create Objects for the Db must implement this method.
abstract class DataStructure<T> {
  Future<T> createDataStructure({
    required DBParser dbParser,
    bool returnStructure = true,
    bool writeFile = false,
  });
}
