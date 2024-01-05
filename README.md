

# A dart Library made to use the USDA SR Legacy database, from json file.

#### Link to download Page
https://fdc.nal.usda.gov/download-datasets.html

#### Link to download
https://fdc.nal.usda.gov/fdc-datasets/FoodData_Central_sr_legacy_food_json_2018-04.zip

The output is 2 files.
1.  The foods and nutritional information.
2.  A lookup hash table of indexed words to search.



### Process

1. Create a map food descriptions `{id: description, ...}` from the original database.  Parse descriptions as necessary.
2. Create the autocomplete hash file, from parsed descriptions.
3. Create the database.


- [ ] Make appropriate methods have the option to save files
- [ ] Abstract class for autocomplete
- [ ] save all files in hash folder
- [ ]





dart run build_runner build --delete-conflicting-outputs
