import 'package:usda_db_creation/helpers/string_helpers.dart';

class DescriptionParser {
  // DescriptionParser(this.foodsDBMap);
  // final List<dynamic> foodsDBMap;
  // List<(int, String)> originalDescriptions = [];
  // List<String> cleanedFirstRunDescriptions = [];

  static List<(int, String)> populateOriginalDescriptions(
      List<dynamic> foodsDBMap) {
    return foodsDBMap.map((food) {
      int id;
      if (food["fdcId"] == null) {
        id = food["ndbNumber"];
      } else {
        id = food["fdcId"];
      }

      // Return a tuple containing the fdcId and description
      return (id, food["description"] as String);
    }).toList();
  }

  // static List<(int, String)> createDuplicatePhraseFile(
  //     List<dynamic> foodsDBMap) {
  //   final originalDescriptions = populateOriginalDescriptions(foodsDBMap);
  //   final descriptions = originalDescriptions.map((e) => e.$2).toList();
  //   final repeats = findRepeatedPhrases(descriptions, 40);
  //   print(repeats);
  // }
}
