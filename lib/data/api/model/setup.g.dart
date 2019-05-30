// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setup _$SetupFromJson(Map<String, dynamic> json) {
  return Setup(
      version: json['version'] as int,
      config: json['config'] == null
          ? null
          : ConfigComplete.fromJson(json['config'] as Map<String, dynamic>),
      zones: (json['zones'] as List)
          ?.map((e) =>
              e == null ? null : ZoneInfo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      holy: json['holy'] as bool,
      holyDay: json['holyDay'] == null
          ? null
          : HolyDay.fromJson(json['holyDay'] as Map<String, dynamic>));
}

Map<String, dynamic> _$SetupToJson(Setup instance) => <String, dynamic>{
      'version': instance.version,
      'config': instance.config,
      'zones': instance.zones,
      'holy': instance.holy,
      'holyDay': instance.holyDay
    };

HolyDay _$HolyDayFromJson(Map<String, dynamic> json) {
  return HolyDay(
      day: json['day'] as int,
      month: json['month'] as int,
      name: json['name'] as String);
}

Map<String, dynamic> _$HolyDayToJson(HolyDay instance) => <String, dynamic>{
      'day': instance.day,
      'month': instance.month,
      'name': instance.name
    };
