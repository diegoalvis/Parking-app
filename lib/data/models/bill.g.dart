// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoneBill _$ZoneBillFromJson(Map<String, dynamic> json) {
  return ZoneBill(
      idZone: json['idZone'] as String,
      code: json['code'] as String,
      cell: json['cell'] as int);
}

Map<String, dynamic> _$ZoneBillToJson(ZoneBill instance) => <String, dynamic>{
      'idZone': instance.idZone,
      'code': instance.code,
      'cell': instance.cell
    };

Bill _$BillFromJson(Map<String, dynamic> json) {
  return Bill(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      vehiclePlate: json['vehiclePlate'] as String,
      type: json['type'] as String,
      value: json['value'] as int,
      zone: json['zone'] == null
          ? null
          : ZoneBill.fromJson(json['zone'] as Map<String, dynamic>),
      time: json['time'] as int);
}

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'vehiclePlate': instance.vehiclePlate,
      'type': instance.type,
      'value': instance.value,
      'zone': instance.zone,
      'time': instance.time
    };

Debt _$DebtFromJson(Map<String, dynamic> json) {
  return Debt(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      vehiclePlate: json['vehiclePlate'] as String,
      value: json['value'] as int,
      zone: json['zone'] == null
          ? null
          : ZoneBill.fromJson(json['zone'] as Map<String, dynamic>));
}

Map<String, dynamic> _$DebtToJson(Debt instance) => <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'vehiclePlate': instance.vehiclePlate,
      'value': instance.value,
      'zone': instance.zone
    };
