class DescriptionParser {
  DescriptionParser(this.foodsDBMap);
  final List<dynamic> foodsDBMap;
  List<Record> originalDescriptions = [];
  // List<Record> originalDescriptions = [];

  void populateOriginalDescriptions() {
    originalDescriptions = foodsDBMap
        .map((food) =>
            (food["fdcId"] ??= food["ndbNumber"], food["description"]))
        .toList();
  }
}


// List<String> findStrings(List<String> strings, int minLength) {
//   List<String> result = [];

//   for (String input in strings) {
//     String lowerInput = input.toLowerCase(); // Convert to lowercase for case-insensitive comparison
//     for (int i = 0; i < input.length; i++) {
//       for (int j = i + minLength; j <= input.length; j++) {
//         String subString = input.substring(i, j);
//         String lowerSubString = subString.toLowerCase();
//         if (lowerInput.indexOf(lowerSubString, i + 1) != -1) {
//           result.add(input);
//           break;
//         }
//       }
//     }
//   }

//   return result.toSet().toList(); // Remove duplicates and convert back to a list
// }

// void main() {
//   List<String> inputList = [
//     "Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough",
//     "Pillsbury, Cinnamon Rolls with Icing, refrigerated dough",
//     "George Weston Bakeries, Thomas English Muffins",
//   ];

//   int minLength = 17;

//   List<String> result = findStrings(inputList, minLength);

//   for (String str in result) {
//     print(str);
//   }
// }
