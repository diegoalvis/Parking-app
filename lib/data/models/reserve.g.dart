// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reserve _$ReserveFromJson(Map<String, dynamic> json) {
  return Reserve(
      id: json['id'] as int,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      plate: json['plate'] as String,
      name: json['name'] as String,
      address: json['address'] as String)
    ..type = json['type'] as String;
}

Map<String, dynamic> _$ReserveToJson(Reserve instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'plate': instance.plate,
      'type': instance.type,
      'name': instance.name,
      'address': instance.address
    };
