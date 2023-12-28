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
        expect('syrup/caramel'.removeUnwantedChars(), 'syrup/caramel');
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
        expect('syrup/caramel'.stripDashedAndParenthesisWord(),
            ['syrup', 'caramel']);
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
    group('isNumber()', () {
      test('returns false if the word is a number', () {
        final number = '2';
        final number1 = '20';
        final number2 = '200';
        final notNumber = '2%';
        final notNumber1 = '20%';
        final notNumber2 = '200%';

        expect(number.isNumber(), true);
        expect(number1.isNumber(), true);
        expect(number2.isNumber(), true);
        expect(notNumber.isNumber(), false);
        expect(notNumber1.isNumber(), false);
        expect(notNumber2.isNumber(), false);
      });
    });
    group('isNumberWithPercent()', () {
      test('returns true is number followed by percent', () {
        final number = '2';
        final number1 = '20';
        final number2 = '200';
        final percent = '2%';
        final percent1 = '20%';
        final percent2 = '200%';
        final notNumber = '2%b';

        expect(number.isNumberWithPercent(), false);
        expect(number1.isNumberWithPercent(), false);
        expect(number2.isNumberWithPercent(), false);
        expect(percent.isNumberWithPercent(), true);
        expect(percent1.isNumberWithPercent(), true);
        expect(percent2.isNumberWithPercent(), true);
        expect(notNumber.isNumberWithPercent(), false);
      });
    });
  });
}
