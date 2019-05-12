import 'package:json_annotation/json_annotation.dart';
import 'package:oneparking_citizen/data/models/config.dart';
import 'package:oneparking_citizen/data/models/zone.dart';

part 'setup.g.dart';

@JsonSerializable(nullable: true)
class Setup{
  int version;
  ConfigComplete config;
  List<ZoneInfo> zones;

  Setup({this.version, this.config, this.zones});

  factory Setup.fromJson(Map<String, dynamic> json) => _$SetupFromJson(json);
  Map<String, dynamic> toJson() => _$SetupToJson(this);

}