import 'package:json_annotation/json_annotation.dart';
import 'package:oneparking_citizen/data/models/zone.dart';

part 'state_info.g.dart';

@JsonSerializable(nullable: true)
class StateInfo{
  ZoneState state;
  ZoneEvent event;

  StateInfo({this.state, this.event});

  factory StateInfo.fromJson(Map<String, dynamic> json) => _$StateInfoFromJson(json);
  Map<String, dynamic> toJson() => _$StateInfoToJson(this);
}



