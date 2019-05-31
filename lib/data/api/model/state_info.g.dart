// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateInfo _$StateInfoFromJson(Map<String, dynamic> json) {
  return StateInfo(
      state: json['state'] == null
          ? null
          : ZoneState.fromJson(json['state'] as Map<String, dynamic>),
      event: json['event'] == null
          ? null
          : ZoneEvent.fromJson(json['event'] as Map<String, dynamic>));
}

Map<String, dynamic> _$StateInfoToJson(StateInfo instance) =>
    <String, dynamic>{'state': instance.state, 'event': instance.event};
