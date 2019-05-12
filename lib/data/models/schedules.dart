import 'package:json_annotation/json_annotation.dart';

part 'schedules.g.dart';

@JsonSerializable(nullable: true)
class Schedules{
  int id;
  String type;
  int day;
  int initTime;
  int endTime;

  Schedules({this.id, this.type, this.day, this.initTime, this.endTime});

  factory Schedules.fromJson(Map<String, dynamic> json) => _$SchedulesFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulesToJson(this);
}