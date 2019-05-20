// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedules _$SchedulesFromJson(Map<String, dynamic> json) {
  return Schedules(
      id: json['id'] as int,
      type: json['type'] as String,
      mo: json['mo'] as int,
      tu: json['tu'] as int,
      we: json['we'] as int,
      th: json['th'] as int,
      fr: json['fr'] as int,
      sa: json['sa'] as int,
      su: json['su'] as int,
      initTime: json['initTime'] as int,
      endTime: json['endTime'] as int);
}

Map<String, dynamic> _$SchedulesToJson(Schedules instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'mo': instance.mo,
      'tu': instance.tu,
      'we': instance.we,
      'th': instance.th,
      'fr': instance.fr,
      'sa': instance.sa,
      'su': instance.su,
      'initTime': instance.initTime,
      'endTime': instance.endTime
    };
