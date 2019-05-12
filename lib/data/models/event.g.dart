// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
      fromDate: json['fromDate'] == null
          ? null
          : DateTime.parse(json['fromDate'] as String),
      toDate: json['toDate'] == null
          ? null
          : DateTime.parse(json['toDate'] as String),
      name: json['name'] as String,
      type: json['type'] as String,
      all: json['all'] as bool);
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'fromDate': instance.fromDate?.toIso8601String(),
      'toDate': instance.toDate?.toIso8601String(),
      'name': instance.name,
      'type': instance.type,
      'all': instance.all
    };

EventInfo _$EventInfoFromJson(Map<String, dynamic> json) {
  return EventInfo(
      fromDate: json['fromDate'] == null
          ? null
          : DateTime.parse(json['fromDate'] as String),
      toDate: json['toDate'] == null
          ? null
          : DateTime.parse(json['toDate'] as String),
      name: json['name'] as String,
      type: json['type'] as String,
      zones: (json['zones'] as List)?.map((e) => e as String)?.toList())
    ..all = json['all'] as bool;
}

Map<String, dynamic> _$EventInfoToJson(EventInfo instance) => <String, dynamic>{
      'fromDate': instance.fromDate?.toIso8601String(),
      'toDate': instance.toDate?.toIso8601String(),
      'name': instance.name,
      'type': instance.type,
      'all': instance.all,
      'zones': instance.zones
    };
