import 'package:test/test.dart';
import 'package:usda_db_creation/helpers/string_helpers.dart';

void main() {
  group('keepCharAndDash', () {
    test('string should only keep chars and dashes and ()', () {
      expect(removeUnwantedChars("he  llo!#!#"), 'hello');
      expect(removeUnwantedChars('  hello-bob '), 'hello-bob');
      expect(removeUnwantedChars('  hello)bob '), 'hello)bob');
      expect(removeUnwantedChars('  hello(bob '), 'hello(bob');
      expect(removeUnwantedChars('  (hello ) '), '(hello)');
      expect(removeUnwantedChars('hello@\$-!@#bob '), 'hello-bob');
      expect(removeUnwantedChars('  hello '), 'hello');
      expect(removeUnwantedChars('  hel  lo'), 'hello');
      expect(removeUnwantedChars(''), '');
      expect(removeUnwantedChars(' '), '');
      expect(removeUnwantedChars('2%'), '2%');
    });
  });
  group('stripDashedAndParenthesisWord', () {
    test('a dashed string should be split into a list', () {
      expect(stripDashedAndParenthesisWord('hello-there'), ['hello', 'there']);
      expect(stripDashedAndParenthesisWord('hello'), ['hello']);
      expect(stripDashedAndParenthesisWord('ready-to-bake'),
          ['ready', 'to', 'bake']);
      expect(stripDashedAndParenthesisWord('-to-bake'), ['', 'to', 'bake']);
      expect(
          stripDashedAndParenthesisWord('-to-bake-'), ['', 'to', 'bake', '']);
    });
    test('an empty string should return an empty list', () {
      expect(stripDashedAndParenthesisWord(''), []);
    });
    test('an word enclosed in () should return list with 1 word', () {
      expect(stripDashedAndParenthesisWord('(hello)'), ['hello']);
    });
    test('an word containing beginning or end parenthesis should be split in 2',
        () {
      expect(stripDashedAndParenthesisWord('he)llo'), ['he', 'llo']);
      expect(stripDashedAndParenthesisWord('he(llo'), ['he', 'llo']);
      expect(stripDashedAndParenthesisWord('he(llo'), ['he', 'llo']);
      expect(stripDashedAndParenthesisWord('(hello'), ['', 'hello']);
      expect(stripDashedAndParenthesisWord('hello)'), ['hello', '']);
    });
  });
  group('cleanSentence()', () {
    test('Sentence should be stripped of all non alpha chars', () {
      expect(cleanSentence('Doughnuts, yeast-Leavened, with jelly filling'),
          {'doughnuts', 'yeast', 'leavened', 'with', 'jelly', 'filling'});

      expect(
          cleanSentence(
              'Muffins, plain, prepared from recipe, made with low fat (2%) milk'),
          {
            'muffins',
            'plain',
            'prepared',
            'from',
            'recipe',
            'made',
            'with',
            'low',
            'fat',
            '2%',
            'milk'
          });

      expect(cleanSentence('Puff pastry, frozen, ready- -to-bake '),
          {'puff', 'pastry', 'frozen', 'ready', 'to', 'bake'});
    });
  });
  group('findRepeatedPhrases', () {
    test('should return repeated phrase 28 chars', () {
      final res = findRepeatedPhrases(sentences, 28);
      print(res);
      expect(res.length, 1);
    });
  });
}

const sentences = [
  'The quick brown fox jumps over the lazy dog.',
  'In a distant galaxy, stars shimmered like diamonds.',
  'A mysterious melody echoed through the ancient forest.',
  'Sunsets paint the sky in hues of orange and pink.',
  'Whispers of the past linger in the old mansion.',
  'Lightning danced across the stormy night sky.',
  'The clock struck midnight, and the world seemed to pause.',
  'Gentle waves lapped against the sandy shore.',
  'Ancient runes glowed on the mysterious artifact.',
  'A lone wolf howled under the full moon.',
  'The aroma of fresh coffee filled the morning air.',
  'In the heart of the city, life buzzed with energy.',
  'The library was a haven of knowledge and silence.',
  'Dreams weave tales of wonder and fear.',
  'Under the starry sky, this is a repeated phrase 28 a campfire crackled.',
  'Majestic mountains towered over the serene valley this is a repeated phrase 28.',
  'The old clock tower chimed, marking the hour.',
  'Raindrops danced on the windowpane during the storm.',
  'The garden bloomed with a myriad of colors.',
  'Whispering winds carried secrets of the ancient forest.',
  'The mirror reflected a room long forgotten.',
  'A hidden path led to an enchanted waterfall.',
  'In the artists studio, creativity knew no this is a repeated phrase 28 bounds.',
  'Stars twinkled like jewels in the night sky.',
  'A forgotten melody played on the old piano.',
  'The old book held tales of magic and adventure.',
  'Shadows played on the walls as night fell.',
  'Laughter echoed in the halls of the grand castle.',
  'The ancient tree stood tall, witnessing centuries.',
  'A mysterious figure appeared in the misty night.',
  'The gentle hum of the city was a song of life.',
  'A secret garden lay hidden behind the ivy-covered walls.',
  'The wise owl watched from its perch in the old oak.',
  'A rainbow arched across the sky after the rain.',
  'The wind whispered tales from distant lands.',
  'The full moon cast a silvery glow on the landscape.',
  'The old lighthouse stood guard over the stormy seas.',
  'Flickering candles cast shadows on the walls.',
  'The train whistled as it journeyed through the night.',
  'Mysterious footprints led through the snowy forest.',
  'The scent of pine filled the crisp mountain air.',
  'An old map revealed secrets of lost treasures.',
  'The night sky was ablaze with a spectacular meteor shower.',
  'A cozy fireplace crackled on a cold winters night.',
  'The ancient bridge spanned the tranquil river.',
  'A kaleidoscope of butterflies fluttered in the meadow.',
  'The quaint village was alive with festive celebrations.',
  'The stars and moon illuminated the desert night.',
  'Old legends spoke of dragons and mythical creatures.',
  'The sun rose, casting a golden light on the new day.',
  'Enchanted whispers echoed in the forgotten ruins.'
];
