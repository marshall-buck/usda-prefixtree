import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:usda_db_creation/nutrient.dart';

part 'food_model.freezed.dart';

@freezed
class FoodModel with _$FoodModel {
  const factory FoodModel(
      {required final String id,
      required final String description,
      required final num descriptionLength,
      required final List<Nutrient> nutrients}) = _FoodModel;
}
