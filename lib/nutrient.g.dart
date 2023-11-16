// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NutrientImpl _$$NutrientImplFromJson(Map<String, dynamic> json) =>
    _$NutrientImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      amount: json['amount'] as num,
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$$NutrientImplToJson(_$NutrientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'amount': instance.amount,
      'unit': instance.unit,
    };
