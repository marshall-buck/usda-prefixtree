A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.

A Library made to use the USDA SR Legacy database, from json file.

#### Link to download Page
https://fdc.nal.usda.gov/download-datasets.html

#### Link to download
https://fdc.nal.usda.gov/fdc-datasets/FoodData_Central_sr_legacy_food_json_2018-04.zip

dart run build_runner build --delete-conflicting-outputs

#### All file names below are properties in the `lib/global_const.dart` file

1. ##### `writeFinalDescriptionsTxtFile()`
   - `createOriginalDescriptionRecords()`
     - This creates a `List(int, String)` from the `fileNameOriginalDBFile`.  this list will not contain any food categories in `excludedCategories`.
   - `removeUnwantedPhrasesFromDescriptions()`
    - This process will remove unwanted phrases from `unwantedPhrases` and return a new list. There are several helper methods to help user choose which phrases to include in the `unwantedPhrases` property.
   - writes to file  from prop: `fileNameFinalDescriptionsTxt`
2. #####  `writeAutocompleteHashToFile()`
   - `createFinalDescriptionMapFromFile()`
     - This will open the final txt file from step 1, and create a substring map in the foll
   - `createAutocompleteWordIndexMap()`
     - This return a word index in the following format `{"apple": ["123456", "234567", ...], ...}`
     - This function takes care of filtering the description string from stop words and other criteria.  such a s common stop words in the property `stopWords`.
   - `createOriginalSubstringMap()`
     - This will create a substring map based on the word index from above.  `{"app": ["123456", "234567", "appl": ["123456", "234567"], ...]`.  The `Autocomplete` class has a static parameter `minLength`, for the minimum length of substrings to use.  There are exceptions for numbers followed by a percent sign. So someone can use 4% for the search term.
     - `createAutocompleteHashTable()`
       - This will take the substring map and create a hash table lookup, for substring values.
       - The resulting map would be: `{"substrings": {"app": 0, "appl": 3} "indexHash" {0: [111111,112345, ...], 1: [123456, ...]}}`
   - The resulting Map from `createAutocompleteHashTable()` is written to `fileNameAutocompleteHash`





