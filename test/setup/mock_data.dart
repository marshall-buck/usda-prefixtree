import 'package:usda_db_creation/food_model.dart';
import 'package:usda_db_creation/nutrient.dart';

const mockDescriptionTxtFile = '''
(167512, Pillsbury Golden Layer Buttermilk Biscuits, (Artificial Flavor,) refrigerated dough)
(167513, Pillsbury, Cinnamon Rolls with Icing, 100% refrigerated dough)
(167514, Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry, 2% milk)
''';

const mockDescriptionMap = {
  167512:
      'Pillsbury Golden Layer Buttermilk Biscuits, (Artificial Flavor,) refrigerated dough',
  167513: 'Pillsbury, Cinnamon Rolls with Icing, 100% refrigerated dough',
  167514:
      'Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry, 2% milk',
};

const Map<String, List<String>> mockAutocompleteIndex = {
  "apple": ['1', '2'],
  "crabapple": ['3', '4'],
  "2%": ['3'],
  "21": ['3', '4'],
};

const mockProtein = Nutrient(id: 1004, name: 'Protein', amount: 10, unit: 'g');

const mockTotalFat =
    Nutrient(id: 1003, name: 'Total Fat', amount: 5, unit: 'mg');

const mockTotalCarbs =
    Nutrient(id: 1005, name: 'Total Carbs', amount: 10, unit: 'g');

const mockCalories =
    Nutrient(id: 1008, name: 'Calories', amount: 80, unit: 'g');

const mockSaturatedFat =
    Nutrient(id: 1258, name: 'Saturated Fat', amount: 10, unit: 'g');

const mockFoodItem = FoodModel(
    id: 111111,
    description:
        'Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough',
    nutrients: [
      mockProtein,
      mockTotalFat,
      mockTotalCarbs,
      mockCalories,
      mockSaturatedFat
    ]);
const Map<int, dynamic> mockFoodJson = {
  111111: {
    'description':
        'Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough',
    'nutrients': [
      {'id': 1004, 'name': 'Protein', 'amount': 10, 'unit': 'g'},
      {'id': 1003, 'name': 'Total Fat', 'amount': 5, 'unit': 'mg'},
      {'id': 1005, 'name': 'Total Carbs', 'amount': 10, 'unit': 'g'},
      {'id': 1008, 'name': 'Calories', 'amount': 80, 'unit': 'g'},
      {'id': 1258, 'name': 'Saturated Fat', 'amount': 10, 'unit': 'g'},
    ]
  }
};

const mockNutrientCSVFile = '''
"id","name","unit_name","nutrient_nbr","rank"
"1002","Nitrogen","G","202","500"
''';

const mockCsvLines = [
  ['id', 'name', 'unit_name', 'nutrient_nbr', 'rank'],
  ['1002', 'Nitrogen', 'G', '202', '500'],
  ["1003", "Protein", "G", "203", "600"],
];

const mockDescriptionRecords = [
  (111111, 'George Weston Bakeries, Thomas English Muffins'),
  (
    111112,
    "Pears, raw, green anjou (Includes foods for USDA's Food Distribution Program)"
  ),
  (
    111113,
    "Apples, raw, fuji, with skin (Includes foods for USDA's Food Distribution Program)"
  ),
  (
    111114,
    "Apples, raw, red delicious, with skin (Includes foods for USDA's Food Distribution Program)"
  ),
  (123456, 'The quick brown fox jumps over the lazy dog. '),
  (234567, 'In a distant galaxy, stars shimmered like diamonds.'),
  (345678, 'A mysterious melody echoed through the ancient forest.'),
  (456789, 'Sunsets paint the sky in hues of orange and pink.'),
  (567890, 'Whispers of the past linger in the old mansion.'),
  (678901, 'Lightning danced across the stormy night sky.'),
  (789012, 'The clock struck midnight, and the world seemed to pause.'),
  (890123, 'Gentle waves lapped against the sandy shore.'),
  (901234, 'Ancient runes glowed on the mysterious artifact.'),
  (102345, 'A lone wolf howled under the full moon.'),
  (112346, 'The aroma of fresh coffee filled the morning air.'),
  (122347, 'In the heart of the city, life buzzed with energy.'),
  (132348, 'The library was a haven of knowledge and silence.'),
  (142349, 'Dreams weave tales of wonder and fear.'),
  (
    152340,
    'Under the starry sky, this is a repeated phrase 28 a campfire crackled.'
  ),
  (
    162341,
    'Majestic mountains towered over the serene valley this is a repeated phrase 28'
  ),
  (172342, 'The old clock tower chimed, marking the hour.'),
  (182343, 'Raindrops danced on the windowpane during the storm.'),
  (192344, 'The garden bloomed with a myriad of colors.'),
  (202345, 'Whispering winds carried secrets of the ancient forest.'),
  (212346, 'The mirror reflected a room long forgotten.'),
  (222347, 'A hidden path led to an enchanted waterfall.'),
  (
    232348,
    'In the artists studio, creativity knew no this is a repeated phrase 28 bounds.'
  ),
  (242349, 'Stars twinkled like jewels in the night sky.'),
  (252340, 'A forgotten melody played on the old piano.'),
  (262341, 'The old book held tales of magic and adventure.'),
  (272342, 'Shadows played on the walls as night fell.'),
  (282343, 'Laughter echoed in the halls of the grand castle.'),
  (292344, 'The ancient tree stood tall, witnessing centuries.'),
  (302345, 'A mysterious figure appeared in the misty night.'),
  (312346, 'The gentle hum of the city was a song of life.'),
  (322347, 'A secret garden lay hidden behind the ivy-covered walls.'),
  (332348, 'The wise owl watched from its perch in the old oak.'),
  (342349, 'A rainbow arched across the sky after the rain.'),
  (352340, 'The wind whispered tales from distant lands.'),
  (362341, 'The full moon cast a silvery glow on the landscape.'),
  (372342, 'The old lighthouse stood guard over the stormy seas.'),
  (382343, 'Flickering candles cast shadows on the walls.'),
  (392344, 'The train whistled as it journeyed through the night.'),
  (402345, 'Mysterious footprints led through the snowy forest.'),
  (412346, 'The scent of pine filled the crisp mountain air.'),
  (422347, 'An old map revealed secrets of lost treasures.'),
  (432348, 'The night sky was ablaze with a spectacular meteor shower.'),
  (442349, 'A cozy fireplace crackled on a cold winters night.'),
  (452340, 'The ancient bridge spanned the tranquil river.'),
  (462341, 'A kaleidoscope of butterflies fluttered in the meadow.'),
  (472342, 'The quaint village was alive with festive celebrations.'),
  (482343, 'The stars and moon illuminated the desert night.'),
  (492344, 'Old legends spoke of dragons and mythical creatures.'),
  (502345, 'The sun rose, casting a golden light on the new day.'),
  (512346, 'Enchanted whispers echoed in the forgotten ruins.')
]; //length 55

