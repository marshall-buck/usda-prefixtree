import 'package:test/test.dart';
import 'package:usda_db_creation/helpers/string_helpers.dart';

void main() {
  group('stripUnwantedCharacters', () {
    test('should return empty string for an empty string input', () {
      expect(stripUnwantedCharacters(''), '');
    });

    test('should strip a string of numbers', () {
      expect(stripUnwantedCharacters('w9'), 'w');
    });
    test('should return empty string for an string that is a number', () {
      expect(stripUnwantedCharacters('99'), '');
    });

    test('should return the input string with all non-word characters removed',
        () {
      expect(stripUnwantedCharacters("Udi's."), 'udis');
      expect(stripUnwantedCharacters("(Oogruk)"), 'oogruk');
    });

    test('should return the input string with all spaces removed', () {
      expect(stripUnwantedCharacters("Udi's.  "), 'udis');
      expect(stripUnwantedCharacters("(Oog    ruk)    "), 'oogruk');
    });

    test(
        'should return the input string unchanged if it does not contain any non-word characters',
        () {
      expect(stripUnwantedCharacters('Steak'), 'steak');
    });
  });

  group('stripUnwantedWords', () {
    test('should return empty [] for an empty string', () {
      expect(stripUnwantedWords(''), []);
    });

    test('should return a list of sanitized words', () {
      expect(
          stripUnwantedWords(
              "Seal, bearded (Oogruk), me9at, raw (Alaska Native) 99 AA"),
          ['seal', 'bearded', 'oogruk', 'meat', 'raw', 'alaska', 'native']);

      expect(stripUnwantedWords('Steak sandwich'), ['steak', 'sandwich']);
    });

    test('should account for misplaced punctuation and spaces', () {
      expect(
          stripUnwantedWords(
              "Seal, bearded (Oogruk) , meat , raw (Alaska Native)"),
          ['seal', 'bearded', 'oogruk', 'meat', 'raw', 'alaska', 'native']);

      expect(stripUnwantedWords('Steak sandwich'), ['steak', 'sandwich']);
    });

    test('should return list with stop words', () {
      expect(
          stripUnwantedWords(
              "Potatoes, hash brown, refrigerated, prepared, pan-fried in the canola oil"),
          [
            'potatoes',
            'hash',
            'brown',
            'refrigerated',
            'prepared',
            'panfried',
            'canola',
            'oil'
          ]);
    });
  });
}
