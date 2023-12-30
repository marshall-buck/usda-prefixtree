const mockUsdaFile = '''
{
    "SRLegacyFoods": [
        {
            "foodClass": "FinalFood",
            "description": "Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough",
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
                        "description": "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                        "foodNutrientSource": {
                            "id": 9,
                            "code": "12",
                            "description": "Manufacturer's analytical; partial documentation"
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
                        "description": "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                        "foodNutrientSource": {
                            "id": 9,
                            "code": "12",
                            "description": "Manufacturer's analytical; partial documentation"
                        }
                    },
                    "amount": 3.50
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
                    "amount": 1.29E+3
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
                        "description": "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                        "foodNutrientSource": {
                            "id": 9,
                            "code": "12",
                            "description": "Manufacturer's analytical; partial documentation"
                        }
                    },
                    "amount": 1.20
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
                        "description": "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                        "foodNutrientSource": {
                            "id": 9,
                            "code": "12",
                            "description": "Manufacturer's analytical; partial documentation"
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
                        "description": "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                        "foodNutrientSource": {
                            "id": 9,
                            "code": "12",
                            "description": "Manufacturer's analytical; partial documentation"
                        }
                    },
                    "amount": 1.06E+3
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
                        "description": "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                        "foodNutrientSource": {
                            "id": 9,
                            "code": "12",
                            "description": "Manufacturer's analytical; partial documentation"
                        }
                    },
                    "amount": 0.000
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
                        "description": "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                        "foodNutrientSource": {
                            "id": 9,
                            "code": "12",
                            "description": "Manufacturer's analytical; partial documentation"
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
                        "description": "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                        "foodNutrientSource": {
                            "id": 9,
                            "code": "12",
                            "description": "Manufacturer's analytical; partial documentation"
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
                        "description": "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                        "foodNutrientSource": {
                            "id": 9,
                            "code": "12",
                            "description": "Manufacturer's analytical; partial documentation"
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
                        "description": "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                        "foodNutrientSource": {
                            "id": 9,
                            "code": "12",
                            "description": "Manufacturer's analytical; partial documentation"
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
                        "description": "Manufacturer supplied(industry or trade association), Analytical data, incomplete documentation",
                        "foodNutrientSource": {
                            "id": 9,
                            "code": "12",
                            "description": "Manufacturer's analytical; partial documentation"
                        }
                    },
                    "amount": 5.88
                }
            ],
            "foodAttributes": [],
            "nutrientConversionFactors": [
                {
                    "type": ".ProteinConversionFactor",
                    "value": 6.25
                }
            ],
            "isHistoricalReference": false,
            "ndbNumber": 18634,
            "foodCategory": {
                "description": "Baked Products"
            },
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
        },
        {
            "foodClass": "FinalFood",
            "description": "Pillsbury, Cinnamon Rolls with Icing, refrigerated dough",
            "foodNutrients": [
                {
                    "type": "FoodNutrient",
                    "id": 1283688,
                    "nutrient": {
                        "id": 1003,
                        "number": "203",
                        "name": "Protein",
                        "rank": 600,
                        "unitName": "g"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 4.34
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283689,
                    "nutrient": {
                        "id": 1007,
                        "number": "207",
                        "name": "Ash",
                        "rank": 1000,
                        "unitName": "g"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 3.08
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283690,
                    "nutrient": {
                        "id": 1062,
                        "number": "268",
                        "name": "Energy",
                        "rank": 400,
                        "unitName": "kJ"
                    },
                    "dataPoints": 0,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 1.38E+3
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283691,
                    "nutrient": {
                        "id": 1079,
                        "number": "291",
                        "name": "Fiber, total dietary",
                        "rank": 1200,
                        "unitName": "g"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 1.40
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283692,
                    "nutrient": {
                        "id": 1089,
                        "number": "303",
                        "name": "Iron, Fe",
                        "rank": 5400,
                        "unitName": "mg"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 1.93
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283693,
                    "nutrient": {
                        "id": 1093,
                        "number": "307",
                        "name": "Sodium, Na",
                        "rank": 5800,
                        "unitName": "mg"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 780
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283694,
                    "nutrient": {
                        "id": 1104,
                        "number": "318",
                        "name": "Vitamin A, IU",
                        "rank": 7500,
                        "unitName": "IU"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 1.00
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283695,
                    "nutrient": {
                        "id": 1106,
                        "number": "320",
                        "name": "Vitamin A, RAE",
                        "rank": 7420,
                        "unitName": "µg"
                    },
                    "dataPoints": 0,
                    "foodNutrientDerivation": {
                        "code": "NR",
                        "description": "Nutrient that is based on other nutrient/s; value used directly, ex. Nut.#204 from Nut.#298",
                        "foodNutrientSource": {
                            "id": 2,
                            "code": "4",
                            "description": "Calculated or imputed"
                        }
                    },
                    "amount": 0.000
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283696,
                    "nutrient": {
                        "id": 1162,
                        "number": "401",
                        "name": "Vitamin C, total ascorbic acid",
                        "rank": 6300,
                        "unitName": "mg"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 0.100
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283697,
                    "nutrient": {
                        "id": 1253,
                        "number": "601",
                        "name": "Cholesterol",
                        "rank": 15700,
                        "unitName": "mg"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 0.000
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283698,
                    "nutrient": {
                        "id": 1257,
                        "number": "605",
                        "name": "Fatty acids, total trans",
                        "rank": 15400,
                        "unitName": "g"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 4.29
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283699,
                    "nutrient": {
                        "id": 1258,
                        "number": "606",
                        "name": "Fatty acids, total saturated",
                        "rank": 9700,
                        "unitName": "g"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 3.25
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283700,
                    "nutrient": {
                        "id": 1004,
                        "number": "204",
                        "name": "Total lipid (fat)",
                        "rank": 800,
                        "unitName": "g"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 11.3
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283701,
                    "nutrient": {
                        "id": 1005,
                        "number": "205",
                        "name": "Carbohydrate, by difference",
                        "rank": 1110,
                        "unitName": "g"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 53.4
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283702,
                    "nutrient": {
                        "id": 1008,
                        "number": "208",
                        "name": "Energy",
                        "rank": 300,
                        "unitName": "kcal"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 330
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283703,
                    "nutrient": {
                        "id": 1051,
                        "number": "255",
                        "name": "Water",
                        "rank": 100,
                        "unitName": "g"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 27.9
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283704,
                    "nutrient": {
                        "id": 2000,
                        "number": "269",
                        "name": "Sugars, total including NLEA",
                        "rank": 1510,
                        "unitName": "g"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 21.3
                },
                {
                    "type": "FoodNutrient",
                    "id": 1283705,
                    "nutrient": {
                        "id": 1087,
                        "number": "301",
                        "name": "Calcium, Ca",
                        "rank": 5300,
                        "unitName": "mg"
                    },
                    "dataPoints": 1,
                    "foodNutrientDerivation": {
                        "code": "MC",
                        "description": "Manufacturer supplied; Calculated by manufacturer or unknown if analytical or calculated",
                        "foodNutrientSource": {
                            "id": 7,
                            "code": "9",
                            "description": "Calculated by manufacturer, not adjusted or rounded for NLEA"
                        }
                    },
                    "amount": 28.0
                }
            ],
            "foodAttributes": [],
            "nutrientConversionFactors": [
                {
                    "type": ".ProteinConversionFactor",
                    "value": 6.25
                }
            ],
            "isHistoricalReference": false,
            "ndbNumber": 18635,
            "foodCategory": {
                "description": "Baked Products"
            },
            "fdcId": 167513,
            "dataType": "SR Legacy",
            "inputFoods": [],
            "publicationDate": "4/1/2019",
            "foodPortions": [
                {
                    "id": 81550,
                    "measureUnit": {
                        "id": 9999,
                        "name": "undetermined",
                        "abbreviation": "undetermined"
                    },
                    "modifier": "serving 1 roll with icing",
                    "gramWeight": 44.0,
                    "sequenceNumber": 1
                }
            ]
        },
        {
            "foodClass": "FinalFood",
            "description": "Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry",
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
                    "foodNutrientDerivation": {
                        "foodNutrientSource": {}
                    },
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
                        "description": "Label claim (back calculated from label by NDL staff; Calculated from label claim/serving (g or %RDI)",
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
            "foodCategory": {
                "description": "Baked Products"
            },
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
        }
    ]
}
''';

const mockFoodsMapResult = {
  '167512': {
    'description':
        "Pillsbury Golden Layer Buttermilk Biscuits, (Artificial Flavor,) refrigerated dough",
    'descriptionLength': 83,
    'nutrients': [
      {'id': 1003, 'displayName': 'Protein', 'amount': 5.88, 'unit': 'g'},
      {'id': 1079, 'displayName': 'Dietary Fiber', 'amount': 1.2, 'unit': 'g'},
      {'id': 1258, 'displayName': 'Saturated Fat', 'amount': 2.94, 'unit': 'g'},
      {'id': 1004, 'displayName': 'Total Fat', 'amount': 13.2, 'unit': 'g'},
      {'id': 1005, 'displayName': 'Total Carbs', 'amount': 41.2, 'unit': 'g'},
      {'id': 1008, 'displayName': 'Calories', 'amount': 307, 'unit': 'kcal'},
      {'id': 2000, 'displayName': 'Total Sugars', 'amount': 5.88, 'unit': 'g'}
    ]
  },
  '167513': {
    'description':
        "Pillsbury, Cinnamon Rolls with Icing, 100% refrigerated dough",
    'descriptionLength': 61,
    'nutrients': [
      {'id': 1003, 'displayName': 'Protein', 'amount': 4.34, 'unit': 'g'},
      {'id': 1079, 'displayName': 'Dietary Fiber', 'amount': 1.4, 'unit': 'g'},
      {'id': 1258, 'displayName': 'Saturated Fat', 'amount': 3.25, 'unit': 'g'},
      {'id': 1004, 'displayName': 'Total Fat', 'amount': 11.3, 'unit': 'g'},
      {'id': 1005, 'displayName': 'Total Carbs', 'amount': 53.4, 'unit': ' g'},
      {'id': 1008, 'displayName': 'Calories', 'amount': 330, 'unit': 'kcal'},
      {'id': 2000, 'displayName': 'Total Sugars', 'amount': 21.3, 'unit': 'g'}
    ]
  },
  '167514': {
    'description':
        "Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry, 2% milk",
    'descriptionLength': 73,
    'nutrients': [
      {'id': 1004, 'displayName': 'Total Fat', 'amount': 3.7, 'unit': 'g'},
      {'id': 1005, 'displayName': 'Total Carbs', 'amount': 79.8, 'unit': 'g'},
      {'id': 1008, 'displayName': 'Calories', 'amount': 377, 'unit': 'kcal'},
      {'id': 1003, 'displayName': 'Protein', 'amount': 6.1, 'unit': 'g'}
    ]
  }
};
