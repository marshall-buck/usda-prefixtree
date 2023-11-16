import 'package:usda_db_creation/foods_db.dart';

void createFiles() {
  final foods = FoodsDB();
  foods.createDB();
  print("createFiles from barrel file");
}
