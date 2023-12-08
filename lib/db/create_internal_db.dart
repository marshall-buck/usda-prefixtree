import '../helpers/file_helpers.dart';

const originalFile = 'lib/db/original_usda.json';

const saveFolder = 'lib/db';

const internalDbName = 'db.json';
const internalTestingDbName = 'test_db.json';
const keepTheseNutrients = [1003, 1004, 1005, 1008, 1079, 1258, 2000];

void main() {
  // createInternalDb();
  createInternalTestingDb();
}

/// Iterates through a food items nutrient list.
///
/// Parameters:
/// - [list] - a list of  all nutrients for a food item
/// [{"type": "FoodNutrient",
///      "id": 1283674,
///      "nutrient": {
///        "id": 1003,
///        "number": "203",
///        "name": "Protein",
///        "rank": 600,
///        "unitName": "g"
///      },
///      "dataPoints": 1,
///      "foodNutrientDerivation": {...} },
///      "amount": 5.88 }, ...]
///
///  Returns [nutrients] - [{ name: Protein, amount: 5.88 },
///                         { name: Calories, amount: 100 } ...],
///  unitName is optional.
///
///
List getFoodNutrients(final List list) {
  final List nutrients = [];

  for (var i = 0; i < list.length; i++) {
    final originalNutrient = list[i];
    var name = originalNutrient['nutrient']['name'];
    final nutrientId = originalNutrient['nutrient']['id'];
    if (!findNutrient(nutrientId)) continue;
    name = switchNutrientName(nutrientId);
    final unitName = originalNutrient['nutrient']['unitName'];

    final amount = originalNutrient['amount'];
    final nutrient = {'name': name, 'unitName': unitName, 'amount': amount};
    if (unitName == 'g' || unitName == 'kcal') {
      nutrient.remove('unitName');
    }
    nutrients.add(nutrient);
  }
  return nutrients;
}

/// Checks if nutrient is in [keepTheseNutrients].
///
/// Parameters:
/// [nutrientId] - the id of the nutrient to be included.
///
/// Returns [bool].
bool findNutrient(final int nutrientId) {
  return keepTheseNutrients.contains(nutrientId);
}

/// Switches nutrient name.
///
/// Parameters [nutrientId]
///
/// Returns [String] of user friendly name.
String switchNutrientName(final nutrientId) {
  switch (nutrientId) {
    case 1004:
      {
        return 'Total Fat';
      }

    case 1005:
      {
        return 'Total Carbs';
      }

    case 1008:
      {
        return 'Calories';
      }

    case 1003:
      {
        return 'Protein';
      }

    case 1258:
      {
        return 'Saturated Fat';
      }

    case 1079:
      {
        return 'Dietary Fiber';
      }

    case 2000:
      {
        return 'Total Sugars';
      }

    default:
      {
        return 'Unknown';
      }
  }
}

/// Writes internal database as a json files and saves to disk.
void createInternalDb() async {
  final data = await readJsonFile(originalFile);

  final Map<String, Map> db = createDb(data);

  await writeJsonFile('$saveFolder/$internalDbName', db);
}

void createInternalTestingDb() async {
  final data = await readJsonFile(originalFile);

  final Map<String, Map> db = createTestingDb(data);

  await writeJsonFile('$saveFolder/$internalTestingDbName', db);
}

/// Creates the database.
///
/// Parameters [data] - the original database of information.
///
/// Returns a map [db]
/// {"167512": {
///         "description": "Pillsbury Golden Layer...",
///         "descriptionLength": 81,
///         "Protein": 5.88,
///         "Dietary Fiber": 1.2,
///         "Saturated Fat": 2.94,
///         "Total Fat": 13.2,
///         "Total Carbs": 41.2,
///         "Calories": 307,
///         "Total Sugars": 5.88
///     },...}.
Map<String, Map> createDb(final Map data) {
  final List originalDb = data['SRLegacyFoods'];
  final Map<String, Map> db = {};
  for (var i = 0; i < originalDb.length; i++) {
    final foodId = originalDb[i]["fdcId"] ??= originalDb[i]["ndbNumber"];
    final String description = originalDb[i]["description"];
    final int descriptionLength = originalDb[i]["description"].length;
    db['$foodId'] = {
      'description': description,
      "descriptionLength": descriptionLength
    };
    final foodNutrients = getFoodNutrients(originalDb[i]["foodNutrients"]);
    createNutrientEntry(db, foodId, foodNutrients);
  }

  return db;
}

Map<String, Map> createTestingDb(final Map data) {
  final List originalDb = data['SRLegacyFoods'];
  final Map<String, Map> db = {};
  for (var i = 0; i < 6; i++) {
    final foodId = originalDb[i]["fdcId"] ??= originalDb[i]["ndbNumber"];
    final String description = originalDb[i]["description"];
    final int descriptionLength = originalDb[i]["description"].length;
    db['$foodId'] = {
      'description': description,
      "descriptionLength": descriptionLength
    };
    final foodNutrients = getFoodNutrients(originalDb[i]["foodNutrients"]);
    createNutrientEntry(db, foodId, foodNutrients);
  }

  return db;
}

/// Adds nutrients as {key: value} to a [foodId] in the db.
///
/// Parameters:
/// [db] - the map that the entries will be added.
/// [foodId] - the key in the map
/// [foodNutrients] - the list of nutrients [{ name: Protein, amount: 5.88 },
///                                         { name: Calories, amount: 100 }, ...].
void createNutrientEntry(final db, final foodId, final foodNutrients) {
  for (var j = 0; j < foodNutrients.length; j++) {
    final name = foodNutrients[j]['name'];
    final amount = foodNutrients[j]['amount'];
    db['$foodId']![name] = amount;
  }
}

// Total Fat =  Total lipid (fat)  1004
// carbs = Carbohydrate, by difference  1005
// Calories = kCal   1008
// Sat Fat = Fatty acids, total saturated  1258
// Fiber = Fiber, total dietary 1079
// sugar = Sugars, total including NLEA  2000

//protein 1003
//[1003,1004,1005,1008, 1079,1258, 2000]
