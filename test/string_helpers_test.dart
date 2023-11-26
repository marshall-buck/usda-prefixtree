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
  group('cleanSentence', () {
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
}
