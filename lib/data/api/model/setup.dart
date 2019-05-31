import 'package:json_annotation/json_annotation.dart';
import 'package:oneparking_citizen/data/models/config.dart';
import 'package:oneparking_citizen/data/models/zone.dart';

part 'setup.g.dart';

@JsonSerializable(nullable: true)
class Setup {
  int version;
  ConfigComplete config;
  List<ZoneInfo> zones;
  bool holy;
  HolyDay holyDay;

  Setup({this.version, this.config, this.zones, this.holy, this.holyDay});

  factory Setup.fromJson(Map<String, dynamic> json) => _$SetupFromJson(json);
  Map<String, dynamic> toJson() => _$SetupToJson(this);
}

@JsonSerializable(nullable: true)
class HolyDay{
  int day;
  int month;
  String name;

  HolyDay({this.day, this.month, this.name});

  factory HolyDay.fromJson(Map<String, dynamic> json) => _$HolyDayFromJson(json);
  Map<String, dynamic> toJson() => _$HolyDayToJson(this);
}