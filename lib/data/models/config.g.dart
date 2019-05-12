// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeDescription _$TimeDescriptionFromJson(Map<String, dynamic> json) {
  return TimeDescription(
      initTime: json['initTime'] as int, endTime: json['endTime'] as int);
}

Map<String, dynamic> _$TimeDescriptionToJson(TimeDescription instance) =>
    <String, dynamic>{
      'initTime': instance.initTime,
      'endTime': instance.endTime
    };

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
      limitTime: json['limitTime'] as int);
}

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'userVehicles': instance.userVehicles,
      'basePrice': instance.basePrice,
      'fractionPrice': instance.fractionPrice,
      'mcBasePrice': instance.mcBasePrice,
      'mcFractionPrice': instance.mcFractionPrice,
      'baseTime': instance.baseTime,
      'fractionTime': instance.fractionTime,
      'limitTime': instance.limitTime
    };

ConfigComplete _$ConfigCompleteFromJson(Map<String, dynamic> json) {
  return ConfigComplete(
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
              e == null ? null : EventInfo.fromJson(e as Map<String, dynamic>))
          ?.toList())
    ..userVehicles = json['userVehicles'] as int
    ..basePrice = json['basePrice'] as int
    ..fractionPrice = json['fractionPrice'] as int
    ..mcBasePrice = json['mcBasePrice'] as int
    ..mcFractionPrice = json['mcFractionPrice'] as int
    ..baseTime = json['baseTime'] as int
    ..fractionTime = json['fractionTime'] as int
    ..limitTime = json['limitTime'] as int;
}

Map<String, dynamic> _$ConfigCompleteToJson(ConfigComplete instance) =>
    <String, dynamic>{
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
