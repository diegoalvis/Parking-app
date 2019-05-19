import 'package:json_annotation/json_annotation.dart';
import 'package:oneparking_citizen/data/models/event.dart';
import 'package:oneparking_citizen/data/models/schedules.dart';

part 'config.g.dart';

@JsonSerializable(nullable: true)
class TimeDescription {
  int initTime;
  int endTime;

  TimeDescription({this.initTime, this.endTime});

  factory TimeDescription.fromJson(Map<String, dynamic> json) =>
      _$TimeDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$TimeDescriptionToJson(this);
}

@JsonSerializable(nullable: true)
class TimeRange {
  List<int> days;
  List<TimeDescription> times;

  TimeRange({this.days, this.times});

  List<Schedules> toSchedules(String type){
    final dayState = [false, false, false, false, false, false, false ];
    days.forEach((d)=>dayState[d] = true);
    return times.map((t)=>Schedules(type: type,
        mo: dayState[0],
        tu: dayState[1],
        we: dayState[2],
        th: dayState[3],
        fr: dayState[4],
        sa: dayState[5],
        su: dayState[6],
        endTime: t.endTime,
        initTime: t.initTime
    )).toList();
  }

  factory TimeRange.fromJson(Map<String, dynamic> json) =>
      _$TimeRangeFromJson(json);

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

  Config({
    this.userVehicles,
    this.basePrice,
    this.fractionPrice,
    this.mcBasePrice,
    this.mcFractionPrice,
    this.baseTime,
    this.fractionTime,
    this.limitTime,
  });

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}

@JsonSerializable(nullable: true)
class ConfigComplete extends Config {
  List<TimeRange> residentialSchedule;
  List<TimeRange> businessSchedule;
  List<EventInfo> events;

  ConfigComplete(
      {this.residentialSchedule, this.businessSchedule, this.events});

  Config toConfig() => Config(
        basePrice: basePrice,
        baseTime: baseTime,
        fractionPrice: fractionPrice,
        fractionTime: fractionTime,
        limitTime: limitTime,
        mcBasePrice: mcBasePrice,
        mcFractionPrice: mcFractionPrice,
        userVehicles: userVehicles,
      );

  factory ConfigComplete.fromJson(Map<String, dynamic> json) =>
      _$ConfigCompleteFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigCompleteToJson(this);
}
