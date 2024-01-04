import 'package:collection/collection.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';

import 'setup/mock_data.dart';
import 'setup/mock_db.dart';
import 'setup/setup.dart';

void main() {
  setUpAll(() {
    set_up_all();
  });

  tearDown(() {
    tear_down();
  });
  group('DescriptionParser class tests', () {
    group('populateOriginalDescriptions', () {
      test('populates the correct records', () {
        const List<DescriptionRecord> expectedResults = [
          (
            167512,
            'Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough'
          ),
          (167513, 'Pillsbury, Cinnamon Rolls with Icing, refrigerated dough'),
          // Excluded category
          // (
          //   167514,
          //   'Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry',
          // ),
        ];
        when(() => mockFileLoaderService.loadData(filePath: 'fake'))
            .thenReturn(mockUsdaFile);

        final dbParser = DBParser.init(
            filePath: 'fake', fileLoaderService: mockFileLoaderService);

        final res = DescriptionParser.createOriginalDescriptionRecords(
            originalFoodsList: dbParser.originalFoodsList);

        expect(res, expectedResults);
      });
    });
    group('getLongestDescription()--', () {
      test('returns length of longest string', () {
        final res = DescriptionParser.getLongestDescription(
            descriptions: descriptionRecords);
        expect(res, 91);
      });
    });
    group('createRepeatedPhraseFrequencyMap()', () {
      test('returns duplicates from anywhere in sentence', () {
        final Map<String, int> res =
            DescriptionParser.createRepeatedPhraseFrequencyMap(
                listOfRecords: descriptionRecords,
                minPhraseLength: 28,
                minNumberOfDuplicatesToShow: 3);

        final bool doesContainValue1 =
            res.containsKey('this is a repeated phrase 28');
        expect(doesContainValue1, true);
      });
    });
    group('separateIntoPhrasesWithMinimumLength()', () {
      test('String greater than twice minLength returns correctly', () {
        // 'Quietly, an old oak stood, surrounded by natures.'

        const expectation = [
          'Quietly, an old oak stood,',
          'Quietly, an old oak stood, surrounded',
          'Quietly, an old oak stood, surrounded by',
          'Quietly, an old oak stood, surrounded by natures.',
          'an old oak stood, surrounded',
          'an old oak stood, surrounded by',
          'an old oak stood, surrounded by natures.',
          'old oak stood, surrounded',
          'old oak stood, surrounded by',
          'old oak stood, surrounded by natures.',
          'oak stood, surrounded',
          'oak stood, surrounded by',
          'oak stood, surrounded by natures.',
          'stood, surrounded by',
          'stood, surrounded by natures.',
          'surrounded by natures.'
        ];
        /* cSpell:enable */
        final res = DescriptionParser.separateIntoPhrasesWithMinimumLength(
          sentence: sentence49,
          minPhraseLength: 20,
        );

        final listEquals = ListEquality();

        expect(listEquals.equals(expectation, res), true);
      });
      test('String of equal length to minLength returns correctly', () {
        // 'Quietly, an old oak stood, surrounded by natures.'

        const expectation = [
          'Quietly, an old oak ',
        ];

        final res = DescriptionParser.separateIntoPhrasesWithMinimumLength(
          sentence: 'Quietly, an old oak ',
          minPhraseLength: 20,
        );

        final listEquals = ListEquality();
        expect(listEquals.equals(expectation, res), true);
      });
      test('String of equal length + 1 to minLength returns correctly', () {
        // 'Quietly, an old oak stood, surrounded by natures.'

        const expectation = ['Quietly, an old oaK T'];

        final res = DescriptionParser.separateIntoPhrasesWithMinimumLength(
          sentence: 'Quietly, an old oaK T',
          minPhraseLength: 20,
        );

        final listEquals = ListEquality();
        expect(listEquals.equals(expectation, res), true);
      });
      test('String of equal length - 1 to minLength returns correctly', () {
        // 'Quietly, an old oak stood, surrounded by natures.'

        final res = DescriptionParser.separateIntoPhrasesWithMinimumLength(
          sentence: 'Quietly, an old oak',
          minPhraseLength: 20,
        );
        final listEquals = ListEquality();
        expect(listEquals.equals([], res), true);
        expect(res.isEmpty, true);
      });
      test('String of less than to minLength returns correctly', () {
        // 'Quietly, an old oak stood, surrounded by natures.'

        final res = DescriptionParser.separateIntoPhrasesWithMinimumLength(
          sentence: 'George Weston Bakeries, Thomas English Muffins',
          minPhraseLength: 48,
        );
        final listEquals = ListEquality();
        expect(listEquals.equals([], res), true);
        expect(res.isEmpty, true);
      });

      test('When the next space is always the last space', () {
        // 'Quietly, an old oak stood, surrounded by natures.'
        const expectation = [
          'In a distant galaxy, stars shimmered like diamonds.',
          'a distant galaxy, stars shimmered like diamonds.',
          'distant galaxy, stars shimmered like diamonds.'
        ];
        final res = DescriptionParser.separateIntoPhrasesWithMinimumLength(
          sentence: 'In a distant galaxy, stars shimmered like diamonds.', //51
          minPhraseLength: 45,
        );

        final listEquals = ListEquality();
        expect(listEquals.equals(expectation, res), true);
      });
    });

    group('removeUnwantedPhrasesFromDescriptions()', () {
      test('removes unwanted descriptions', () {
        const List<DescriptionRecord> expectedDescriptions = [
          (111111, 'George Weston Bakeries, Thomas English Muffins'),
          (111112, 'Pears, raw, green anjou '),
          (111113, 'Apples, raw, fuji, with skin '),
          (111114, 'Apples, raw, red delicious, with skin '),
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
          (152340, 'Under the starry sky,  a campfire crackled.'),
          (162341, 'Majestic mountains towered over the serene valley '),
          (172342, 'The old clock tower chimed, marking the hour.'),
          (182343, 'Raindrops danced on the windowpane during the storm.'),
          (192344, 'The garden bloomed with a myriad of colors.'),
          (202345, 'Whispering winds carried secrets of the ancient forest.'),
          (212346, 'The mirror reflected a room long forgotten.'),
          (222347, 'A hidden path led to an enchanted waterfall.'),
          (232348, 'In the artists studio, creativity knew no  bounds.'),
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
          (
            432348,
            'The night sky was ablaze with a spectacular meteor shower.'
          ),
          (442349, 'A cozy fireplace crackled on a cold winters night.'),
          (452340, 'The ancient bridge spanned the tranquil river.'),
          (462341, 'A kaleidoscope of butterflies fluttered in the meadow.'),
          (472342, 'The quaint village was alive with festive celebrations.'),
          (482343, 'The stars and moon illuminated the desert night.'),
          (492344, 'Old legends spoke of dragons and mythical creatures.'),
          (502345, 'The sun rose, casting a golden light on the new day.'),
          (512346, 'Enchanted whispers echoed in the forgotten ruins.')
        ];

        const listOfPhrasesToDelete = [
          "(Includes foods for USDA's Food Distribution Program)",
          'this is a repeated phrase 28'
        ];
        final res = DescriptionParser.removeUnwantedPhrasesFromDescriptions(
            descriptions: descriptionRecords,
            unwantedPhrases: listOfPhrasesToDelete);

        final listEquals = ListEquality();

        expect(listEquals.equals(expectedDescriptions, res), true);
      });
    });
  });
  group('parseDescriptionRecordFromString()', () {
    test('parses description record correctly', () {
      // Input string
      final String input =
          '(111111, George Weston Bakeries, Thomas English Muffins)';

      // Expected result
      final expectedOutput =
          MapEntry(111111, 'George Weston Bakeries, Thomas English Muffins');

      // Execute the function
      final result = DescriptionParser.parseDescriptionRecordFromString(input);
      expect(result.key, equals(expectedOutput.key));
      expect(result.value, equals(expectedOutput.value));
    });
  });
  group('createFinalDescriptionMapFromFile()', () {
    test('coverts list of descriptions records to map', () {
      when(() => mockFileLoaderService.loadData(filePath: 'fake'))
          .thenReturn(mockDescriptionFile);

      const expected = {
        167512:
            'Pillsbury Golden Layer Buttermilk Biscuits, (Artificial Flavor,) refrigerated dough',
        167513: 'Pillsbury, Cinnamon Rolls with Icing, 100% refrigerated dough',
        167514:
            'Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry, 2% milk',
      };

      final res = DescriptionParser.parseDescriptionsFromTxt(
          filePath: 'fake', fileLoaderService: mockFileLoaderService);
      final mapEquals = MapEquality();
      expect(mapEquals.equals(expected, res), true);
    });
  });
  group('createDescriptionMap()', () {
    test('coverts list of descriptions records to map', () async {
      when(() => mockFileLoaderService.loadData(filePath: 'fake'))
          .thenReturn(mockUsdaFile);
      when(() => mockFileLoaderService.fileHash)
          .thenReturn(DateTime.now().microsecondsSinceEpoch.toString());

      const expected = {
        167512:
            "Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough",
        167513: "Pillsbury, Cinnamon Rolls with Icing, refrigerated dough",
        // excluded category
        // 167514:
        //     "Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry"
      };

      final dbParser = DBParser.init(
          filePath: 'fake', fileLoaderService: mockFileLoaderService);

      final descriptions = DescriptionParser();
      final res = await descriptions.createDescriptionMap(dbParser: dbParser);

      final mapEquals = MapEquality();
      expect(mapEquals.equals(expected, res), true);
    });
  });
  group('isExcludedCategory', () {
    test('returns true is foodItem has an excluded category', () {
      when(() => mockFileLoaderService.loadData(filePath: 'fake'))
          .thenReturn(mockUsdaFile);
      final dbParser = DBParser.init(
          filePath: 'fake', fileLoaderService: mockFileLoaderService);
      final originalFoodsList = dbParser.originalFoodsList;
      final foodItem = originalFoodsList[2];
      final res = DescriptionParser.isExcludedCategory(foodItem: foodItem);
      expect(res, true);
    });
    test('returns false is foodItem has an excluded category', () {
      when(() => mockFileLoaderService.loadData(filePath: 'fake'))
          .thenReturn(mockUsdaFile);
      final dbParser = DBParser.init(
          filePath: 'fake', fileLoaderService: mockFileLoaderService);
      final originalFoodsList = dbParser.originalFoodsList;
      final foodItem = originalFoodsList[0];
      final res = DescriptionParser.isExcludedCategory(foodItem: foodItem);
      expect(res, false);
    });
  });
}

const descriptionRecords = [
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
const sentence134 =
    'Under the (shimmering) moonlight, an old oak, rooted deeply, stood majestically as the silent guardian of the ancient, mystical woods.';
const sentence49 = 'Quietly, an old oak stood, surrounded by natures.';

// const expectation = [
//   'Quietly, an old oak ',
//   'Quietly, an old oak stood,',
//   'Quietly, an old oak stood, surrounded',
//   'Quietly, an old oak stood, surrounded by',
//   'Quietly, an old oak stood, surrounded by natures.',
//   'an old oak stood, surrounded',
//   'an old oak stood, surrounded by',
//   'an old oak stood, surrounded by natures.',
//   'old oak stood, surrounded',
//   'old oak stood, surrounded by',
//   'old oak stood, surrounded by natures.',
//   'oak stood, surrounded',
//   'oak stood, surrounded by',
//   'oak stood, surrounded by natures.',
//   'stood, surrounded by',
//   'stood, surrounded by natures.',
//   'surrounded by natures.'
// ];
