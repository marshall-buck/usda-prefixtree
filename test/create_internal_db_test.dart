import 'package:test/test.dart';
import 'package:usda_db_creation/db/create_internal_db.dart';

void main() {
  group('YourClassName', () {
    // Test getFoodNutrients() method
    test('getFoodNutrients should return a list of nutrients', () {
      final inputList = [
        {
          "type": "FoodNutrient",
          "id": 1283674,
          "nutrient": {
            "id": 1003,
            "number": "203",
            "name": "Protein",
            "rank": 600,
            "unitName": "g"
          },
          "dataPoints": 1,
          "foodNutrientDerivation": {},
          "amount": 5.88
        },
        {
          "type": "FoodNutrient",
          "id": 1283710,
          "nutrient": {
            "id": 1008,
            "number": "208",
            "name": "Energy",
            "rank": 300,
            "unitName": "kcal"
          },
          "dataPoints": 0,
          "foodNutrientDerivation": {
            "code": "NC",
            "description": "Calculated",
            "foodNutrientSource": {
              "id": 2,
              "code": "4",
              "description": "Calculated or imputed"
            }
          },
          "amount": 377
        },
      ];

      final result = getFoodNutrients(inputList);

      expect(result, isA<List>());
      expect(result.length, equals(2));
      expect(result[0], isA<Map>());
      expect(result[0]['name'], equals('Protein'));
      expect(result[0]['unitName'], isNull);
      expect(result[0]['amount'], equals(5.88));

      expect(result[1]['name'], equals('Calories'));
      expect(result[1]['unitName'], isNull);
      expect(result[1]['amount'], equals(377));
    });

    // Test findNutrient() method
    test('findNutrient should return true if nutrientId is found in ids', () {
      final nutrientId = 1003;

      final result = findNutrient(nutrientId);

      expect(result, equals(true));
    });

    test('findNutrient should return false if nutrientId is not found in ids',
        () {
      final nutrientId = 9999;

      final result = findNutrient(nutrientId);

      expect(result, equals(false));
    });

    // Test switchNutrientName() method
    test('switchNutrientName should return the correct nutrient name', () {
      final fat = 1004;

      final fatResult = switchNutrientName(fat);

      expect(fatResult, equals('Total Fat'));

      final carbs = 1005;

      final carbsResult = switchNutrientName(carbs);

      expect(carbsResult, equals('Total Carbs'));

      final calories = 1008;

      final caloriesResult = switchNutrientName(calories);

      expect(caloriesResult, equals('Calories'));

      final protein = 1003;

      final proteinResult = switchNutrientName(protein);

      expect(proteinResult, equals('Protein'));

      final satFat = 1258;

      final satFatResult = switchNutrientName(satFat);

      expect(satFatResult, equals('Saturated Fat'));

      final fiber = 1079;

      final fiberResult = switchNutrientName(fiber);

      expect(fiberResult, equals('Dietary Fiber'));

      final sugars = 2000;

      final sugarsResult = switchNutrientName(sugars);

      expect(sugarsResult, equals('Total Sugars'));
    });

    test('switchNutrientName should return "Unknown" for unknown nutrientId',
        () {
      final nutrientId = 9999;

      final result = switchNutrientName(nutrientId);

      expect(result, equals('Unknown'));
    });

    // Test createDb() method
    test('createDb should return a map of food items with nutrients', () {
      final originalDb = {
        "SRLegacyFoods": [
          {
            "foodClass": "FinalFood",
            "description":
                "Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry",
            "foodNutrients": [
              {
                "type": "FoodNutrient",
                "id": 1283706,
                "nutrient": {
                  "id": 1062,
                  "number": "268",
                  "name": "Energy",
                  "rank": 400,
                  "unitName": "kJ"
                },
                "dataPoints": 0,
                "foodNutrientDerivation": {"foodNutrientSource": {}},
                "amount": 1.58E+3
              },
              {
                "type": "FoodNutrient",
                "id": 1283707,
                "nutrient": {
                  "id": 1093,
                  "number": "307",
                  "name": "Sodium, Na",
                  "rank": 5800,
                  "unitName": "mg"
                },
                "dataPoints": 0,
                "foodNutrientDerivation": {
                  "code": "LC",
                  "description":
                      "Label claim (back calculated from label by NDL staff; Calculated from label claim/serving (g or %RDI)",
                  "foodNutrientSource": {
                    "id": 6,
                    "code": "8",
                    "description": "Calculated from nutrient label by NDL"
                  }
                },
                "amount": 2.18E+3
              },
              {
                "type": "FoodNutrient",
                "id": 1283708,
                "nutrient": {
                  "id": 1004,
                  "number": "204",
                  "name": "Total lipid (fat)",
                  "rank": 800,
                  "unitName": "g"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "A",
                  "description": "Analytical",
                  "foodNutrientSource": {
                    "id": 1,
                    "code": "1",
                    "description": "Analytical or derived from analytical"
                  }
                },
                "amount": 3.70
              },
              {
                "type": "FoodNutrient",
                "id": 1283709,
                "nutrient": {
                  "id": 1005,
                  "number": "205",
                  "name": "Carbohydrate, by difference",
                  "rank": 1110,
                  "unitName": "g"
                },
                "dataPoints": 0,
                "foodNutrientDerivation": {
                  "code": "NC",
                  "description": "Calculated",
                  "foodNutrientSource": {
                    "id": 2,
                    "code": "4",
                    "description": "Calculated or imputed"
                  }
                },
                "amount": 79.8
              },
              {
                "type": "FoodNutrient",
                "id": 1283710,
                "nutrient": {
                  "id": 1008,
                  "number": "208",
                  "name": "Energy",
                  "rank": 300,
                  "unitName": "kcal"
                },
                "dataPoints": 0,
                "foodNutrientDerivation": {
                  "code": "NC",
                  "description": "Calculated",
                  "foodNutrientSource": {
                    "id": 2,
                    "code": "4",
                    "description": "Calculated or imputed"
                  }
                },
                "amount": 377
              },
              {
                "type": "FoodNutrient",
                "id": 1283711,
                "nutrient": {
                  "id": 1051,
                  "number": "255",
                  "name": "Water",
                  "rank": 100,
                  "unitName": "g"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "A",
                  "description": "Analytical",
                  "foodNutrientSource": {
                    "id": 1,
                    "code": "1",
                    "description": "Analytical or derived from analytical"
                  }
                },
                "amount": 3.20
              },
              {
                "type": "FoodNutrient",
                "id": 1283712,
                "nutrient": {
                  "id": 1003,
                  "number": "203",
                  "name": "Protein",
                  "rank": 600,
                  "unitName": "g"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "A",
                  "description": "Analytical",
                  "foodNutrientSource": {
                    "id": 1,
                    "code": "1",
                    "description": "Analytical or derived from analytical"
                  }
                },
                "amount": 6.10
              },
              {
                "type": "FoodNutrient",
                "id": 1283713,
                "nutrient": {
                  "id": 1007,
                  "number": "207",
                  "name": "Ash",
                  "rank": 1000,
                  "unitName": "g"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "A",
                  "description": "Analytical",
                  "foodNutrientSource": {
                    "id": 1,
                    "code": "1",
                    "description": "Analytical or derived from analytical"
                  }
                },
                "amount": 7.20
              }
            ],
            "foodAttributes": [],
            "nutrientConversionFactors": [],
            "isHistoricalReference": false,
            "ndbNumber": 18637,
            "foodCategory": {"description": "Baked Products"},
            "fdcId": 167514,
            "dataType": "SR Legacy",
            "inputFoods": [],
            "publicationDate": "4/1/2019",
            "foodPortions": [
              {
                "id": 81551,
                "measureUnit": {
                  "id": 9999,
                  "name": "undetermined",
                  "abbreviation": "undetermined"
                },
                "modifier": "serving",
                "gramWeight": 28.0,
                "sequenceNumber": 1
              }
            ]
          },
          {
            "foodClass": "FinalFood",
            "description":
                "Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough",
            "foodNutrients": [
              {
                "type": "FoodNutrient",
                "id": 1283674,
                "nutrient": {
                  "id": 1003,
                  "number": "203",
                  "name": "Protein",
                  "rank": 600,
                  "unitName": "g"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "MA",
                  "description":
                      "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                  "foodNutrientSource": {
                    "id": 9,
                    "code": "12",
                    "description":
                        "Manufacturer's analytical; partial documentation"
                  }
                },
                "amount": 5.88
              },
              {
                "type": "FoodNutrient",
                "id": 1283675,
                "nutrient": {
                  "id": 1007,
                  "number": "207",
                  "name": "Ash",
                  "rank": 1000,
                  "unitName": "g"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "MA",
                  "description":
                      "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                  "foodNutrientSource": {
                    "id": 9,
                    "code": "12",
                    "description":
                        "Manufacturer's analytical; partial documentation"
                  }
                },
                "amount": 3.5
              },
              {
                "type": "FoodNutrient",
                "id": 1283676,
                "nutrient": {
                  "id": 1062,
                  "number": "268",
                  "name": "Energy",
                  "rank": 400,
                  "unitName": "kJ"
                },
                "dataPoints": 0,
                "foodNutrientDerivation": {
                  "code": "NC",
                  "description": "Calculated",
                  "foodNutrientSource": {
                    "id": 2,
                    "code": "4",
                    "description": "Calculated or imputed"
                  }
                },
                "amount": 1290.0
              },
              {
                "type": "FoodNutrient",
                "id": 1283677,
                "nutrient": {
                  "id": 1079,
                  "number": "291",
                  "name": "Fiber, total dietary",
                  "rank": 1200,
                  "unitName": "g"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "MA",
                  "description":
                      "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                  "foodNutrientSource": {
                    "id": 9,
                    "code": "12",
                    "description":
                        "Manufacturer's analytical; partial documentation"
                  }
                },
                "amount": 1.2
              },
              {
                "type": "FoodNutrient",
                "id": 1283678,
                "nutrient": {
                  "id": 1089,
                  "number": "303",
                  "name": "Iron, Fe",
                  "rank": 5400,
                  "unitName": "mg"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "MA",
                  "description":
                      "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                  "foodNutrientSource": {
                    "id": 9,
                    "code": "12",
                    "description":
                        "Manufacturer's analytical; partial documentation"
                  }
                },
                "amount": 2.12
              },
              {
                "type": "FoodNutrient",
                "id": 1283679,
                "nutrient": {
                  "id": 1093,
                  "number": "307",
                  "name": "Sodium, Na",
                  "rank": 5800,
                  "unitName": "mg"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "MA",
                  "description":
                      "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                  "foodNutrientSource": {
                    "id": 9,
                    "code": "12",
                    "description":
                        "Manufacturer's analytical; partial documentation"
                  }
                },
                "amount": 1060.0
              },
              {
                "type": "FoodNutrient",
                "id": 1283680,
                "nutrient": {
                  "id": 1253,
                  "number": "601",
                  "name": "Cholesterol",
                  "rank": 15700,
                  "unitName": "mg"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "MA",
                  "description":
                      "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                  "foodNutrientSource": {
                    "id": 9,
                    "code": "12",
                    "description":
                        "Manufacturer's analytical; partial documentation"
                  }
                },
                "amount": 0.0
              },
              {
                "type": "FoodNutrient",
                "id": 1283681,
                "nutrient": {
                  "id": 1257,
                  "number": "605",
                  "name": "Fatty acids, total trans",
                  "rank": 15400,
                  "unitName": "g"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "MA",
                  "description":
                      "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                  "foodNutrientSource": {
                    "id": 9,
                    "code": "12",
                    "description":
                        "Manufacturer's analytical; partial documentation"
                  }
                },
                "amount": 4.41
              },
              {
                "type": "FoodNutrient",
                "id": 1283682,
                "nutrient": {
                  "id": 1258,
                  "number": "606",
                  "name": "Fatty acids, total saturated",
                  "rank": 9700,
                  "unitName": "g"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "MA",
                  "description":
                      "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                  "foodNutrientSource": {
                    "id": 9,
                    "code": "12",
                    "description":
                        "Manufacturer's analytical; partial documentation"
                  }
                },
                "amount": 2.94
              },
              {
                "type": "FoodNutrient",
                "id": 1283683,
                "nutrient": {
                  "id": 1004,
                  "number": "204",
                  "name": "Total lipid (fat)",
                  "rank": 800,
                  "unitName": "g"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "MA",
                  "description":
                      "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                  "foodNutrientSource": {
                    "id": 9,
                    "code": "12",
                    "description":
                        "Manufacturer's analytical; partial documentation"
                  }
                },
                "amount": 13.2
              },
              {
                "type": "FoodNutrient",
                "id": 1283684,
                "nutrient": {
                  "id": 1005,
                  "number": "205",
                  "name": "Carbohydrate, by difference",
                  "rank": 1110,
                  "unitName": "g"
                },
                "dataPoints": 0,
                "foodNutrientDerivation": {
                  "code": "NC",
                  "description": "Calculated",
                  "foodNutrientSource": {
                    "id": 2,
                    "code": "4",
                    "description": "Calculated or imputed"
                  }
                },
                "amount": 41.2
              },
              {
                "type": "FoodNutrient",
                "id": 1283685,
                "nutrient": {
                  "id": 1008,
                  "number": "208",
                  "name": "Energy",
                  "rank": 300,
                  "unitName": "kcal"
                },
                "dataPoints": 0,
                "foodNutrientDerivation": {
                  "code": "NC",
                  "description": "Calculated",
                  "foodNutrientSource": {
                    "id": 2,
                    "code": "4",
                    "description": "Calculated or imputed"
                  }
                },
                "amount": 307
              },
              {
                "type": "FoodNutrient",
                "id": 1283686,
                "nutrient": {
                  "id": 1051,
                  "number": "255",
                  "name": "Water",
                  "rank": 100,
                  "unitName": "g"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "MA",
                  "description":
                      "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                  "foodNutrientSource": {
                    "id": 9,
                    "code": "12",
                    "description":
                        "Manufacturer's analytical; partial documentation"
                  }
                },
                "amount": 35.5
              },
              {
                "type": "FoodNutrient",
                "id": 1283687,
                "nutrient": {
                  "id": 2000,
                  "number": "269",
                  "name": "Sugars, total including NLEA",
                  "rank": 1510,
                  "unitName": "g"
                },
                "dataPoints": 1,
                "foodNutrientDerivation": {
                  "code": "MA",
                  "description":
                      "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                  "foodNutrientSource": {
                    "id": 9,
                    "code": "12",
                    "description":
                        "Manufacturer's analytical; partial documentation"
                  }
                },
                "amount": 5.88
              }
            ],
            "foodAttributes": [],
            "nutrientConversionFactors": [
              {"type": ".ProteinConversionFactor", "value": 6.25}
            ],
            "isHistoricalReference": false,
            "ndbNumber": 18634,
            "foodCategory": {"description": "Baked Products"},
            "fdcId": 167512,
            "dataType": "SR Legacy",
            "inputFoods": [],
            "publicationDate": "4/1/2019",
            "foodPortions": [
              {
                "id": 81549,
                "measureUnit": {
                  "id": 9999,
                  "name": "undetermined",
                  "abbreviation": "undetermined"
                },
                "modifier": "serving",
                "gramWeight": 34.0,
                "sequenceNumber": 1
              }
            ]
          }
        ]
      };

      final result = createDb(originalDb);

      expect(result, isA<Map>());
      expect(result.length, equals(2));
      expect(result.containsKey('167514'), isTrue);
      expect(result.containsKey('167512'), isTrue);
      expect(result['167514'], isA<Map>());

      expect(result['167514']?['descriptionLen'], equals(64));
      expect(result['167514']?.containsKey('Protein'), isTrue);
    });
  });
}
