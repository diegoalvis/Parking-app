import 'package:json_annotation/json_annotation.dart';

part 'incident.g.dart';

@JsonSerializable(nullable: true)
class IncidentUser{
  String name;
  String phone;

  IncidentUser({this.name, this.phone});

  factory IncidentUser.fromJson(Map<String, dynamic> json) => _$IncidentUserFromJson(json);
  Map<String, dynamic> toJson() => _$IncidentUserToJson(this);
}

@JsonSerializable(nullable: true)
class IncidentZone{
  String idZone;
  String code;
  String name;

  IncidentZone({this.idZone, this.code, this.name});

  factory IncidentZone.fromJson(Map<String, dynamic> json) => _$IncidentZoneFromJson(json);
  Map<String, dynamic> toJson() => _$IncidentZoneToJson(this);
}

@JsonSerializable(nullable: true)
class Incident{
  String image;
  String observations;
  IncidentZone zone;
  IncidentUser reportUser;

  Incident({this.image, this.observations, this.zone, this.reportUser});

  factory Incident.fromJson(Map<String, dynamic> json) => _$IncidentFromJson(json);
  Map<String, dynamic> toJson() => _$IncidentToJson(this);

}