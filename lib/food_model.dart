import 'package:equatable/equatable.dart';

class FoodModel extends Equatable {
  final dynamic id;
  final String description;
  final Map<String, num> nutrientsMap;

  const FoodModel(
      {required this.id,
      required this.description,
      required this.nutrientsMap});

  Map<String, dynamic> toJson() {
    return {
      id.toString(): {
        'description': description,
        'nutrients': nutrientsMap,
      }
    };
  }

  // factory FoodModel.fromJson(final Map<int, dynamic> json) {
  //   final foodJson = json.values.first;
  //   final nutrientsJson = foodJson['nutrients'] as List<dynamic>;

  //   final nutrients = nutrientsJson
  //       .map((e) => Nutrient.fromJson(e as MapEntry<String, dynamic>))
  //       .toList();

  //   return FoodModel(
  //     id: json.keys.first,
  //     description: foodJson['description'],
  //     nutrients: nutrients,
  //   );
  // }
  @override
  List<Object?> get props => [id, description, nutrientsMap];
}
