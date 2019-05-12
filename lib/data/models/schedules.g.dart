// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedules _$SchedulesFromJson(Map<String, dynamic> json) {
  return Schedules(
      id: json['id'] as int,
      type: json['type'] as String,
      day: json['day'] as int,
      initTime: json['initTime'] as int,
      endTime: json['endTime'] as int);
}

Map<String, dynamic> _$SchedulesToJson(Schedules instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'day': instance.day,
      'initTime': instance.initTime,
      'endTime': instance.endTime
    };
