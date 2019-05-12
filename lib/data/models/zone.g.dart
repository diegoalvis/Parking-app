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

ZoneBase _$ZoneBaseFromJson(Map<String, dynamic> json) {
  return ZoneBase(
      type: json['type'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      address: json['address'] as String);
}

Map<String, dynamic> _$ZoneBaseToJson(ZoneBase instance) => <String, dynamic>{
      'type': instance.type,
      'code': instance.code,
      'name': instance.name,
      'address': instance.address
    };

ZoneInfo _$ZoneInfoFromJson(Map<String, dynamic> json) {
  return ZoneInfo(
      type: json['type'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      centerPoint: json['centerPoint'] == null
          ? null
          : Point.fromJson(json['centerPoint'] as Map<String, dynamic>))
    ..id = json['_id'] as String;
}

Map<String, dynamic> _$ZoneInfoToJson(ZoneInfo instance) => <String, dynamic>{
      'type': instance.type,
      'code': instance.code,
      'name': instance.name,
      'address': instance.address,
      '_id': instance.id,
      'centerPoint': instance.centerPoint
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

Zone _$ZoneFromJson(Map<String, dynamic> json) {
  return Zone(
      type: json['type'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num)?.toDouble(),
      lon: (json['lon'] as num)?.toDouble(),
      id: json['id'] as int,
      idZone: json['idZone'] as String);
}

Map<String, dynamic> _$ZoneToJson(Zone instance) => <String, dynamic>{
      'type': instance.type,
      'code': instance.code,
      'name': instance.name,
      'address': instance.address,
      'id': instance.id,
      'lat': instance.lat,
      'lon': instance.lon,
      'idZone': instance.idZone
    };
