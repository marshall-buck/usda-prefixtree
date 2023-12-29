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
        expect('hello-there'.stripDashedAndParenthesisAndorwardSlashesWord(),
            ['hello', 'there']);
        expect(
            'hello'.stripDashedAndParenthesisAndorwardSlashesWord(), ['hello']);
        expect('ready-to-bake'.stripDashedAndParenthesisAndorwardSlashesWord(),
            ['ready', 'to', 'bake']);
        expect('-to-bake'.stripDashedAndParenthesisAndorwardSlashesWord(),
            ['', 'to', 'bake']);
        expect('-to-bake-'.stripDashedAndParenthesisAndorwardSlashesWord(),
            ['', 'to', 'bake', '']);
        expect('syrup/caramel'.stripDashedAndParenthesisAndorwardSlashesWord(),
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
    group('isLowerCaseOrNumberWithPercent()', () {
      test(
          'returns true if the string is lowercase caracther or a number followed by percent',
          () {
        expect('a'.isLowerCaseOrNumberWithPercent(), true);
        expect('b'.isLowerCaseOrNumberWithPercent(), true);
        expect('1'.isLowerCaseOrNumberWithPercent(), false);
        expect('18g'.isLowerCaseOrNumberWithPercent(), false);
        expect('18%'.isLowerCaseOrNumberWithPercent(), true);
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
// group('isLowerCaseOrNumberWithPercent()', () {
//   test('returns true if the string is lowercase or a number followed by percent', () {
//     expect('a'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('b'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('1'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('2'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('3'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('4'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('5'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('6'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('7'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('8'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('9'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('0'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('2%'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('20%'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('200%'.isLowerCaseOrNumberWithPercent(), isTrue);
//     expect('2%b'.isLowerCaseOrNumberWithPercent(), isFalse);
//     expect('A'.isLowerCaseOrNumberWithPercent(), isFalse);
//     expect('B'.isLowerCaseOrNumberWithPercent(), isFalse);
//     expect('!'.isLowerCaseOrNumberWithPercent(), isFalse);
//     expect('@'.isLowerCaseOrNumberWithPercent(), isFalse);
//     expect('#'.isLowerCaseOrNumberWithPercent(), isFalse);
//     expect('$'.isLowerCaseOrNumberWithPercent(), isFalse);
//     expect('%'.isLowerCaseOrNumberWithPercent(), isFalse);
//     expect('^'.isLowerCaseOrNumberWithPercent(), isFalse);
//     expect('&'.isLowerCaseOrNumberWithPercent(), isFalse);
//     expect('*'.isLowerCaseOrNumberWithPercent(), isFalse);
//     expect('()'.isLowerCaseOrNumberWithPercent(), isFalse);
//     expect(''.isLowerCaseOrNumberWithPercent(), isFalse);
//   });
// });