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
}
