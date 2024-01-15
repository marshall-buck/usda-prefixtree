import 'package:usda_db_creation/db_parser.dart';

/// Abstract class for the database data structures.
/// All classes that create Objects for the Db must implement this method.
/// Parameters:
/// [dbParser] - The instance of the  [DBParser] Class
/// [returnStructure] - If true the method will return the object the method
/// creates
/// [writeFile] - If true will write object the method created to file
abstract class DataStructure<T> {
  Future<T> createDataStructure({
    required DBParser dbParser,
    bool returnData = true,
    bool writeFile = false,
  });
}
