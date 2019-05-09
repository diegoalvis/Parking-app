// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) {
  return Car(placa: json['placa'] as String, marca: json['marca'] as String);
}

Map<String, dynamic> _$CarToJson(Car instance) =>
    <String, dynamic>{'placa': instance.placa, 'marca': instance.marca};

CarLocal _$CarLocalFromJson(Map<String, dynamic> json) {
  return CarLocal(
      id: json['id'] as int,
      placa: json['placa'] as String,
      marca: json['marca'] as String,
      selected: json['selected'] as bool);
}

Map<String, dynamic> _$CarLocalToJson(CarLocal instance) => <String, dynamic>{
      'placa': instance.placa,
      'marca': instance.marca,
      'id': instance.id,
      'selected': instance.selected
    };
