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

  const FoodModel._();

  /// Maps object to custom JSON.
  ///

  Map<String, dynamic> toJson() {
    final nutrientList = nutrients.map((e) => e.toJson()).toList();
    final nutrientMap = Map.fromEntries(
        nutrientList.map((e) => MapEntry(e.keys.first, e.values.first)));
    return {
      id: {
        'description': description,
        'descriptionLength': descriptionLength,
        'nutrients': nutrientMap,
      }
    };
  }

  /// Maps JSON to FoodModel object.
  factory FoodModel.fromJson(final Map<String, dynamic> json) {
    final key = json.keys.first;
    final value = json[key];
    final nutrientMap = value['nutrients'];
    final nutrientList = nutrientMap.entries
        .map((e) => Nutrient.fromJson({e.key: e.value}))
        .toList();
    return FoodModel(
      id: key,
      description: value['description'],
      descriptionLength: value['descriptionLength'],
      nutrients: nutrientList,
    );
  }
}
