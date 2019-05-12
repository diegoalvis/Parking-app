// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncidentUser _$IncidentUserFromJson(Map<String, dynamic> json) {
  return IncidentUser(
      idUser: json['idUser'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      type: json['type'] as String);
}

Map<String, dynamic> _$IncidentUserToJson(IncidentUser instance) =>
    <String, dynamic>{
      'idUser': instance.idUser,
      'name': instance.name,
      'phone': instance.phone,
      'type': instance.type
    };

IncidentZone _$IncidentZoneFromJson(Map<String, dynamic> json) {
  return IncidentZone(
      idZone: json['idZone'] as String,
      code: json['code'] as String,
      name: json['name'] as String);
}

Map<String, dynamic> _$IncidentZoneToJson(IncidentZone instance) =>
    <String, dynamic>{
      'idZone': instance.idZone,
      'code': instance.code,
      'name': instance.name
    };

Incident _$IncidentFromJson(Map<String, dynamic> json) {
  return Incident(
      image: json['image'] as String,
      observations: json['observations'] as String,
      zone: json['zone'] == null
          ? null
          : IncidentZone.fromJson(json['zone'] as Map<String, dynamic>),
      reportUser: json['reportUser'] == null
          ? null
          : IncidentUser.fromJson(json['reportUser'] as Map<String, dynamic>));
}

Map<String, dynamic> _$IncidentToJson(Incident instance) => <String, dynamic>{
      'image': instance.image,
      'observations': instance.observations,
      'zone': instance.zone,
      'reportUser': instance.reportUser
    };
