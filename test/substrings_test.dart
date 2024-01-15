import 'package:test/test.dart';

import 'setup/setup.dart';

void main() {
  setUpAll(() {
    set_up_all();
  });

  tearDown(() {
    tear_down();
  });
  group('Substrings class tests', () {
    // group('createSubstringsFromWordIndex()', () {
    //   test('substrings populates correctly', () async {
    //     final res = AutocompleteHash.createSubstringsFromWordIndex(
    //         wordIndex: mockAutocompleteIndex);

    //     final deep = DeepCollectionEquality();

    //     expect(deep.equals(res, originalSubStringMap), true);
    //   });
    // });
  });
}
