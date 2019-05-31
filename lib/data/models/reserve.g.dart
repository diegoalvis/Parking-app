// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reserve _$ReserveFromJson(Map<String, dynamic> json) {
  return Reserve(
      id: json['id'] as int,
      idReserve: json['idReserve'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      plate: json['plate'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      type: json['type'] as String);
}

Map<String, dynamic> _$ReserveToJson(Reserve instance) => <String, dynamic>{
      'id': instance.id,
      'idReserve': instance.idReserve,
      'date': instance.date?.toIso8601String(),
      'plate': instance.plate,
      'type': instance.type,
      'name': instance.name,
      'address': instance.address
    };

ReserveNovelty _$ReserveNoveltyFromJson(Map<String, dynamic> json) {
  return ReserveNovelty(state: json['state'] as int);
}

Map<String, dynamic> _$ReserveNoveltyToJson(ReserveNovelty instance) =>
    <String, dynamic>{'state': instance.state};
