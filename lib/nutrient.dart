import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrient.freezed.dart';

part 'nutrient.g.dart';

@freezed
class Nutrient with _$Nutrient {
  const factory Nutrient({
    required String id,
    required String displayName,
    required num amount,
    required String unit,
  }) = _Nutrient;

  factory Nutrient.fromJson(Map<String, Object?> json) =>
      _$NutrientFromJson(json);

  const Nutrient._();

  /// Switches nutrient name.
  ///
  /// Parameters [nutrientId]
  ///
  /// Returns [String] of user friendly name.
  String switchNutrientName(nutrientId) {
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
}
