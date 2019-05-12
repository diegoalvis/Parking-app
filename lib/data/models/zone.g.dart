// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Point _$PointFromJson(Map<String, dynamic> json) {
  return Point(
      type: json['type'] as String,
      coordinates: (json['coordinates'] as List)
          ?.map((e) => (e as num)?.toDouble())
          ?.toList());
}

Map<String, dynamic> _$PointToJson(Point instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates
    };

Zone _$ZoneFromJson(Map<String, dynamic> json) {
  return Zone(
      type: json['type'] as String,
      centerPoint: json['centerPoint'] == null
          ? null
          : Point.fromJson(json['centerPoint'] as Map<String, dynamic>),
      code: json['code'] as String,
      name: json['name'] as String,
      address: json['address'] as String);
}

Map<String, dynamic> _$ZoneToJson(Zone instance) => <String, dynamic>{
      'type': instance.type,
      'centerPoint': instance.centerPoint,
      'code': instance.code,
      'name': instance.name,
      'address': instance.address
    };

ZoneState _$ZoneStateFromJson(Map<String, dynamic> json) {
  return ZoneState(
      json['carCells'] as int,
      json['usedCarCells'] as int,
      json['motorcycleCells'] as int,
      json['usedMotorcycleCells'] as int,
      json['disabilityCells'] as int,
      json['usedDisabilityCells'] as int);
}

Map<String, dynamic> _$ZoneStateToJson(ZoneState instance) => <String, dynamic>{
      'carCells': instance.carCells,
      'usedCarCells': instance.usedCarCells,
      'motorcycleCells': instance.motorcycleCells,
      'usedMotorcycleCells': instance.usedMotorcycleCells,
      'disabilityCells': instance.disabilityCells,
      'usedDisabilityCells': instance.usedDisabilityCells
    };
