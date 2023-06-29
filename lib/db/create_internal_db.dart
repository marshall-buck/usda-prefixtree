import '../helpers/file_helpers.dart';

const originalFile = 'lib/db/original_usda.json';

const saveFolder = 'lib';

const internalDbName = 'db.json';

void main() {
  createInternalDb();
}

/// Iterates through a food items nutrient list [list],
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
///  Returns a new list of [nutrient]s to be used in the db.json
/// [{name": Protein,  amount: 5.88}, ...], unitName is optional/
List getFoodNutrients(List list) {
  final List out = [];

  for (var i = 0; i < list.length; i++) {
    final map = list[i];
    var name = map['nutrient']['name'];
    final nutrientId = map['nutrient']['id'];
    if (!findNutrient(nutrientId)) continue;
    name = switchNutrientName(nutrientId);
    final unitName = map['nutrient']['unitName'];

    final amount = map['amount'];
    final nutrient = {'name': name, 'unitName': unitName, 'amount': amount};
    if (unitName == 'g' || unitName == 'kcal') {
      nutrient.remove('unitName');
    }
    out.add(nutrient);
  }
  return out;
}

/// Returns [bool]:  checks if the [nutrientId] is in [ids].
bool findNutrient(int nutrientId) {
  const ids = [1003, 1004, 1005, 1008, 1079, 1258, 2000];

  return ids.contains(nutrientId);
}

/// Returns user friendly name [String] from nutrient [id].
String switchNutrientName(id) {
  switch (id) {
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

///Writes internal database as a json files and saves to disk.
void createInternalDb() async {
  final data = await readJsonFile(originalFile);

  // final List originalDb = data['SRLegacyFoods'];

  final Map<String, Map> db = createDb(data);

  await writeJsonFile('$saveFolder/$internalDbName', db);
}

/// Returns a Map [db] from List of the  [originalDb],
Map<String, Map> createDb(Map data) {
  final List originalDb = data['SRLegacyFoods'];
  final Map<String, Map> db = {};
  for (var i = 0; i < originalDb.length; i++) {
    final id = originalDb[i]["fdcId"] ??= originalDb[i]["ndbNumber"];
    final String description = originalDb[i]["description"];
    final int descriptionLength = originalDb[i]["description"].length;
    db['$id'] = {
      'description': description,
      "descriptionLen": descriptionLength
    };
    final foodNutrients = getFoodNutrients(originalDb[i]["foodNutrients"]);
    createNutrientEntry(db, id, foodNutrients);
    if (i == originalDb.length - 1) {
      assert(originalDb.length == i + 1);
    }
  }

  return db;
}

/// Creates the {name: amount} pair for a nutrient  in the [db] with the [id]
///  of a foodItem, from the List of [foodNutrients]
void createNutrientEntry(db, id, foodNutrients) {
  for (var j = 0; j < foodNutrients.length; j++) {
    final name = foodNutrients[j]['name'];
    final amount = foodNutrients[j]['amount'];
    db['$id']![name] = amount;
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
