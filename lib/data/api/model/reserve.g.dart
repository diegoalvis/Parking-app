// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReserveReq _$ReserveReqFromJson(Map<String, dynamic> json) {
  return ReserveReq(
      idZone: json['idZone'] as String,
      code: json['code'] as String,
      vehicle: json['vehicle'] == null
          ? null
          : Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
      disability: json['disability'] as bool);
}

Map<String, dynamic> _$ReserveReqToJson(ReserveReq instance) =>
    <String, dynamic>{
      'idZone': instance.idZone,
      'code': instance.code,
      'disability': instance.disability,
      'vehicle': instance.vehicle
    };

ReserveRes _$ReserveResFromJson(Map<String, dynamic> json) {
  return ReserveRes(
      idReserve: json['idReserve'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String));
}

Map<String, dynamic> _$ReserveResToJson(ReserveRes instance) =>
    <String, dynamic>{
      'idReserve': instance.idReserve,
      'date': instance.date?.toIso8601String()
    };

ReserveStopRes _$ReserveStopResFromJson(Map<String, dynamic> json) {
  return ReserveStopRes(cost: json['cost'] as int, time: json['time'] as int);
}

Map<String, dynamic> _$ReserveStopResToJson(ReserveStopRes instance) =>
    <String, dynamic>{'cost': instance.cost, 'time': instance.time};
