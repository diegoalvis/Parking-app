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
          : Config.fromJson(json['config'] as Map<String, dynamic>),
      zones: (json['zones'] as List)
          ?.map((e) =>
              e == null ? null : Zone.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SetupToJson(Setup instance) => <String, dynamic>{
      'version': instance.version,
      'config': instance.config,
      'zones': instance.zones
    };
