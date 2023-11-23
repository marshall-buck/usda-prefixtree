class DescriptionParser {
  DescriptionParser(this.foodsDBMap);
  final List<dynamic> foodsDBMap;
  List<Record> originalDescriptions = [];

  void populateOriginalDescriptions() {
    // for (final food in foodsDBMap) {
    //   final rec = (food["fdcId"] ??= food["ndbNumber"], food["description"]);
    //   originalDescriptions.add(rec);
    // }
    originalDescriptions = foodsDBMap
        .map((food) =>
            (food["fdcId"] ??= food["ndbNumber"], food["description"]))
        .toList();
  }
}
