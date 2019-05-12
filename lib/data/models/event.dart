import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';


@JsonSerializable(nullable: true)
class Event {
  DateTime fromDate;
  DateTime toDate;
  String name;
  String type;
  bool all;

  Event({this.fromDate, this.toDate, this.name, this.type, this.all});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}

@JsonSerializable(nullable: true)
class EventInfo extends Event {
  List<String> zones;

  EventInfo({DateTime fromDate, DateTime toDate, String name, String type, this.zones})
  :super(fromDate:fromDate, toDate:toDate, name:name, type:type);

  factory EventInfo.fromJson(Map<String, dynamic> json) => _$EventInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EventInfoToJson(this);
}



