import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable(nullable: true)
class Event {
  DateTime fromDate;
  DateTime toDate;
  String name;
  String type;
  List<String> zones;

  Event({this.fromDate, this.toDate, this.name, this.type, this.zones});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}

@JsonSerializable(nullable: true)
class TimeDescription {
  int init;
  int end;

  TimeDescription({this.init, this.end});

  factory TimeDescription.fromJson(Map<String, dynamic> json) => _$TimeDescriptionFromJson(json);
  Map<String, dynamic> toJson() => _$TimeDescriptionToJson(this);
}

@JsonSerializable(nullable: true)
class TimeRange {
  List<int> days;
  List<TimeDescription> times;

  TimeRange({this.days, this.times});

  factory TimeRange.fromJson(Map<String, dynamic> json) => _$TimeRangeFromJson(json);
  Map<String, dynamic> toJson() => _$TimeRangeToJson(this);
}

@JsonSerializable(nullable: true)
class Config {
  int userVehicles;
  int basePrice;
  int fractionPrice;
  int mcBasePrice;
  int mcFractionPrice;
  int baseTime;
  int fractionTime;
  int limitTime;
  List<TimeRange> residentialSchedule;
  List<TimeRange> businessSchedule;
  List<Event> events;

  Config(
      {this.userVehicles,
      this.basePrice,
      this.fractionPrice,
      this.mcBasePrice,
      this.mcFractionPrice,
      this.baseTime,
      this.fractionTime,
      this.limitTime,
      this.residentialSchedule,
      this.businessSchedule,
      this.events});

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
