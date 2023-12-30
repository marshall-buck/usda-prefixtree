import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrient.freezed.dart';

@freezed
class Nutrient with _$Nutrient {
  const factory Nutrient({
    required final int id,
    required final String displayName,
    required final num amount,
    required final String unit,
  }) = _Nutrient;
  const Nutrient._();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'amount': amount,
      'unit': unit,
    };
  }

  /// Maps JSON to Nutrient object.
  factory Nutrient.fromJson(final Map<String, dynamic> json) {
    return Nutrient(
      id: json['id'],
      displayName: json['displayName'],
      amount: json['amount'],
      unit: json['unit'],
    );
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
