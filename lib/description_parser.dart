class DescriptionParser {
  static List<(int, String)> populateOriginalDescriptionRecords(
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

  static int getLongestDescription(
      {required List<(int, String)> descriptions}) {
    return descriptions.fold(
        0,
        (maxLength, record) =>
            maxLength > record.$2.length ? maxLength : record.$2.length);
  }

  // static List<String> createDuplicatePhraseFile(
  //     List<(int, String)> descriptionRecords,
  //     int minPhraseLength,
  //     int maxPhraseLength) {
  //   final descriptions = descriptionRecords.map((e) => e.$2).toList();

  //   return findRepeatedPhrases(descriptions, minPhraseLength, maxPhraseLength);
  // }

  // static List<(int, String)> deletePhrases(List<(int, String)> phrases) {}
}
