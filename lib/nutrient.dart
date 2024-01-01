import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrient.freezed.dart';

@freezed
class Nutrient with _$Nutrient {
  const factory Nutrient({
    required final int id,
    required final String name,
    required final num amount,
    required final String unit,
  }) = _Nutrient;
  const Nutrient._();

  Map<String, dynamic> toJson() {
    return {'id': id, 'info': '$name*$amount*$unit'};
  }
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'amount': amount,
  //     'unit': unit,
  //   };
  // }

  /// Maps JSON to Nutrient object.
  factory Nutrient.fromJson(final Map<String, dynamic> json) {
    final info = json['info'].split('*');
    return Nutrient(
      id: json['id'],
      name: info[0],
      amount: num.parse(info[1]),
      unit: info[2],
    );
  }

  /// Given the string form a csv file, iterate and create the nutrien info map
  ///
  /// Returns:{ {"1004" : {"name": "Total Fat", "unit": "g"}, ...}

  static Map<String, dynamic> createNutrientInfoMap(
      {required List<List<String>> csvLines}) {
    final Map<String, dynamic> nutrientsMap = {};
    // print('csvLines: $csvLines\n csvLines.length: ${csvLines.length}');
    for (var i = 1; i < csvLines.length; i++) {
      final line = csvLines[i];

      final key = line[0];
      final name = line[1];
      final unit = line[2].toLowerCase();

      nutrientsMap[key] = {"name": name, "unit": unit};
    }

    return nutrientsMap;
  }

  /// Switches nutrient name.
  ///
  /// Parameters [nutrientId]
  ///
  /// Returns [String] of user friendly name.
  static String switchNutrientName(final int id) {
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
}
