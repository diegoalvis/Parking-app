// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return Vehicle(
      plate: json['plate'] as String,
      brand: json['brand'] as String,
      type: json['type'] as String);
}

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'plate': instance.plate,
      'brand': instance.brand,
      'type': instance.type
    };

VehicleLocal _$VehicleLocalFromJson(Map<String, dynamic> json) {
  return VehicleLocal(
      id: json['id'] as int,
      plate: json['plate'] as String,
      brand: json['brand'] as String,
      selected: json['selected'] as bool)
    ..type = json['type'] as String;
}

Map<String, dynamic> _$VehicleLocalToJson(VehicleLocal instance) =>
    <String, dynamic>{
      'plate': instance.plate,
      'brand': instance.brand,
      'type': instance.type,
      'id': instance.id,
      'selected': instance.selected
    };
