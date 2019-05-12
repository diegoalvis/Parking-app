// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedules _$SchedulesFromJson(Map<String, dynamic> json) {
  return Schedules(
      id: json['id'] as int,
      type: json['type'] as String,
      mo: json['mo'] as bool,
      tu: json['tu'] as bool,
      we: json['we'] as bool,
      th: json['th'] as bool,
      fr: json['fr'] as bool,
      sa: json['sa'] as bool,
      su: json['su'] as bool,
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
