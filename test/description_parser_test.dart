import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:usda_db_creation/db_parser.dart';
import 'package:usda_db_creation/description_parser.dart';

import 'setup/mock_strings.dart';
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
        const List<(int, String)> expectedOriginalDescriptions = [
          (
            167512,
            "Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough"
          ),
          (167513, "Pillsbury, Cinnamon Rolls with Icing, refrigerated dough"),
          (
            167514,
            "Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry",
          ),
        ];
        when(() => mockFileLoaderService.loadData('fake'))
            .thenReturn(mockUsdaFile);
        final dbParser = DBParser(fileLoader: mockFileLoaderService);
        dbParser.init('fake');

        final res =
            DescriptionParser.populateOriginalDescriptions(dbParser.foodsDBMap);

        expect(res, expectedOriginalDescriptions);
      });
    });
  });
}
