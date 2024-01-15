import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:usda_db_creation/extensions/map_ext.dart';

void main() {
  group('MpExtensions', () {
    group('convertMapKeyToString()', () {
      test('should convert int keys to string keys', () {
        final map = {
          1: 'one',
          2: 'two',
          3: {'4': 'four'}
        };
        final result = map.convertMapKeyToString();

        expect(result, isA<Map<String, dynamic>>());

        final deep = DeepCollectionEquality();
        expect(
            deep.equals(result, {
              '1': 'one',
              '2': 'two',
              '3': {'4': 'four'}
            }),
            true);
        expect(
            deep.equals(result, {
              '1': 'one',
              '2': 'two',
              3: {'4': 'four'}
            }),
            false);
      });

      test('should handle nested maps', () {
        final map = {
          1: 'one',
          2: {
            3: {
              4: [1, 2, 3, 4]
            }
          }
        };
        final result = map.convertMapKeyToString();

        expect(result['2'], isA<Map<String, dynamic>>());
        expect(result['2'].keys, contains('3'));

        final deep = DeepCollectionEquality();
        expect(
            deep.equals(result, {
              '1': 'one',
              '2': {
                '3': {
                  '4': [1, 2, 3, 4]
                }
              }
            }),
            true);
        expect(
            deep.equals(result, {
              '1': 'one',
              '2': {
                '3': {
                  4: [1, 2, 3, 4]
                }
              }
            }),
            false);
      });
    });
    group('convertStringKeysToInts', () {
      test('should convert string keys to int keys', () {
        final map = {
          '1': 'one',
          '2': 'two',
          '3': {'4': 'four'}
        };
        final result = map.convertMapKeyToInt();
        final deep = DeepCollectionEquality();
        expect(
            deep.equals(result, {
              1: 'one',
              2: 'two',
              3: {4: 'four'}
            }),
            true);
      });

      test('should handle nested maps', () {
        final map = {
          '1': 'one',
          '2': {
            '3': {'4': 'four'}
          }
        };
        final result = map.convertMapKeyToInt();
        final deep = DeepCollectionEquality();
        expect(
            deep.equals(result, {
              1: 'one',
              2: {
                3: {4: 'four'}
              }
            }),
            true);
      });

      test('should ignore non-string keys', () {
        final map = {1: 'one', '2': 'two', '3': true};
        final result = map.convertMapKeyToInt();
        final deep = DeepCollectionEquality();
        expect(deep.equals(result, {1: 'one', 2: 'two', 3: true}), true);
      });

      test('should ignore non-integer string keys', () {
        final map = {'a': 'alpha', '2': 'two', '3b': 'threeB'};
        final result = map.convertMapKeyToInt();
        final deep = DeepCollectionEquality();
        expect(deep.equals(result, {'a': 'alpha', 2: 'two', '3b': 'threeB'}),
            true);
      });
    });
  });
}
