import 'package:test/test.dart';
import 'package:usda_db_creation/string_ext.dart';

void main() {
  group('StringExtensions Unit Tests', () {
    group('removeUnwantedChars()', () {
      test(' removes unwanted characters', () {
        expect("he  llo!#!#".removeUnwantedChars(), 'hello');
        expect('  hello-bob '.removeUnwantedChars(), 'hello-bob');
        expect('  hello)bob '.removeUnwantedChars(), 'hello)bob');
        expect('  hello(bob '.removeUnwantedChars(), 'hello(bob');
        expect('  (hello ) '.removeUnwantedChars(), '(hello)');
        expect('hello@\$-!@#bob '.removeUnwantedChars(), 'hello-bob');
        expect('  hello '.removeUnwantedChars(), 'hello');
        expect('  hel  lo'.removeUnwantedChars(), 'hello');
        expect(''.removeUnwantedChars(), '');
        expect(' '.removeUnwantedChars(), '');
        expect('2%'.removeUnwantedChars(), '2%');
      });
    });

    group('stripDashedAndParenthesisWord()', () {
      test(' separates words with dashes or parentheses', () {
        expect(
            'hello-there'.stripDashedAndParenthesisWord(), ['hello', 'there']);
        expect('hello'.stripDashedAndParenthesisWord(), ['hello']);
        expect('ready-to-bake'.stripDashedAndParenthesisWord(),
            ['ready', 'to', 'bake']);
        expect('-to-bake'.stripDashedAndParenthesisWord(), ['', 'to', 'bake']);
        expect('-to-bake-'.stripDashedAndParenthesisWord(),
            ['', 'to', 'bake', '']);
      });
    });

    group('getWordsToIndex()', () {
      test('Sentence should be stripped of all non alpha chars', () {
        final sentence1 = 'Doughnuts, yeast-Leavened, with jelly filling';
        expect(sentence1.getWordsToIndex(),
            {'doughnuts', 'yeast', 'leavened', 'with', 'jelly', 'filling'});
        final sentence2 =
            'Muffins, plain, prepared from recipe, made with low fat (2%) milk';

        expect(sentence2.getWordsToIndex(), {
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

        final sentence3 = 'Puff pastry, frozen, ready- -to-bake ';

        expect(sentence3.getWordsToIndex(),
            {'puff', 'pastry', 'frozen', 'ready', 'to', 'bake'});
      });
    });

    group('isStopWord()', () {
      test('returns true if the word is a stop word', () {
        final stopWords = ['the', 'and', 'or'];
        final input1 = 'the';
        final input2 = 'apple';

        expect(input1.isStopWord(stopWords), isTrue);
        expect(input2.isStopWord(stopWords), isFalse);
      });
    });
  });
}
