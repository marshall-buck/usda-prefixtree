import 'package:usda_db_creation/db_parser.dart';

/// Abstract class for the database data structures.
/// All classes that create Objects for the Db must implement this method.
/// Parameters:
/// [dbParser] - The instance of the  [DBParser] class.
/// [returnStructure] - If true the method will return the object created.
/// [writeFile] - If true will write the data to a file.
abstract class DataStructure<T> {
  Future<T> createDataStructure({
    required DBParser dbParser,
    bool returnData = true,
    bool writeFile = false,
  });
}
