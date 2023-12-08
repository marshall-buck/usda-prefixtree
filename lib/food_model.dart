import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_model.freezed.dart';

part 'food_model.g.dart';

@freezed
class FoodModel with _$FoodModel {
  const factory FoodModel(
      {required final String id,
      required final String description,
      required final num descriptionLength,
      final num? protein,
      final num? dietaryFiber,
      final num? satFat,
      final num? totCarb,
      final num? calories,
      final num? totFat,
      final num? totSugars}) = _FoodModel;

  factory FoodModel.fromJson(final Map<String, Object?> json) =>
      _$FoodModelFromJson(json);
}
