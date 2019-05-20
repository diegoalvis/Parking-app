// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleBase _$VehicleBaseFromJson(Map<String, dynamic> json) {
  return VehicleBase(
      plate: json['plate'] as String,
      brand: json['brand'] as String,
      type: json['type'] as String);
}

Map<String, dynamic> _$VehicleBaseToJson(VehicleBase instance) =>
    <String, dynamic>{
      'plate': instance.plate,
      'brand': instance.brand,
      'type': instance.type
    };

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return Vehicle(
      id: json['id'] as int,
      plate: json['plate'] as String,
      brand: json['brand'] as String,
      type: json['type'] as String,
      selected: json['selected'] as int);
}

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'plate': instance.plate,
      'brand': instance.brand,
      'type': instance.type,
      'id': instance.id,
      'selected': instance.selected
    };
