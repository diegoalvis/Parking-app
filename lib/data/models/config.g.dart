// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

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
      zones: (json['zones'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'fromDate': instance.fromDate?.toIso8601String(),
      'toDate': instance.toDate?.toIso8601String(),
      'name': instance.name,
      'type': instance.type,
      'zones': instance.zones
    };

TimeDescription _$TimeDescriptionFromJson(Map<String, dynamic> json) {
  return TimeDescription(init: json['init'] as int, end: json['end'] as int);
}

Map<String, dynamic> _$TimeDescriptionToJson(TimeDescription instance) =>
    <String, dynamic>{'init': instance.init, 'end': instance.end};

TimeRange _$TimeRangeFromJson(Map<String, dynamic> json) {
  return TimeRange(
      days: (json['days'] as List)?.map((e) => e as int)?.toList(),
      times: (json['times'] as List)
          ?.map((e) => e == null
              ? null
              : TimeDescription.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$TimeRangeToJson(TimeRange instance) =>
    <String, dynamic>{'days': instance.days, 'times': instance.times};

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return Config(
      userVehicles: json['userVehicles'] as int,
      basePrice: json['basePrice'] as int,
      fractionPrice: json['fractionPrice'] as int,
      mcBasePrice: json['mcBasePrice'] as int,
      mcFractionPrice: json['mcFractionPrice'] as int,
      baseTime: json['baseTime'] as int,
      fractionTime: json['fractionTime'] as int,
      limitTime: json['limitTime'] as int,
      residentialSchedule: (json['residentialSchedule'] as List)
          ?.map((e) =>
              e == null ? null : TimeRange.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      businessSchedule: (json['businessSchedule'] as List)
          ?.map((e) =>
              e == null ? null : TimeRange.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      events: (json['events'] as List)
          ?.map((e) =>
              e == null ? null : Event.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'userVehicles': instance.userVehicles,
      'basePrice': instance.basePrice,
      'fractionPrice': instance.fractionPrice,
      'mcBasePrice': instance.mcBasePrice,
      'mcFractionPrice': instance.mcFractionPrice,
      'baseTime': instance.baseTime,
      'fractionTime': instance.fractionTime,
      'limitTime': instance.limitTime,
      'residentialSchedule': instance.residentialSchedule,
      'businessSchedule': instance.businessSchedule,
      'events': instance.events
    };
