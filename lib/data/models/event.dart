import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

const String EVENT_FREE = 'free';
const String EVENT_FORBIDDEN = 'forbidden';

@JsonSerializable(nullable: true)
class Event {
  DateTime fromDate;
  DateTime toDate;
  String name;
  String type;


  Event({this.fromDate, this.toDate, this.name, this.type});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
