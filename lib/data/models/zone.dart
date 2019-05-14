import 'package:json_annotation/json_annotation.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';

part 'zone.g.dart';

const String TYPE_RESIDENTIAL = 'residential';
const String TYPE_BUSINESS = 'business';

@JsonSerializable(nullable: true)
class Point {
  String type;
  List<double> coordinates;

  Point({this.type, this.coordinates});

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);

  Map<String, dynamic> toJson() => _$PointToJson(this);
}

@JsonSerializable(nullable: true)
class ZoneBase {
  String type;
  String code;
  String name;
  String address;

  ZoneBase({this.type, this.code, this.name, this.address});

  factory ZoneBase.fromJson(Map<String, dynamic> json) =>
      _$ZoneBaseFromJson(json);

  Map<String, dynamic> toJson() => _$ZoneBaseToJson(this);
}

@JsonSerializable(nullable: true)
class ZoneInfo extends ZoneBase {
  @JsonKey(name: "_id")
  String id;
  Point centerPoint;

  ZoneInfo(
      {String type, String code, String name, String address, this.centerPoint})
      : super(type: type, code: code, name: name, address: address);

  Zone toZone()=> Zone(
      type: type,
      idZone: id,
      code: code,
      address: address,
      name: name,
      lat: centerPoint.coordinates[1],
      lon: centerPoint.coordinates[0]);

  factory ZoneInfo.fromJson(Map<String, dynamic> json) =>
      _$ZoneInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ZoneInfoToJson(this);
}

@JsonSerializable(nullable: true)
class ZoneState {
  int carCells;
  int usedCarCells;
  int motorcycleCells;
  int usedMotorcycleCells;
  int disabilityCells;
  int usedDisabilityCells;

  ZoneState(this.carCells, this.usedCarCells, this.motorcycleCells,
      this.usedMotorcycleCells, this.disabilityCells, this.usedDisabilityCells);

  factory ZoneState.fromJson(Map<String, dynamic> json) =>
      _$ZoneStateFromJson(json);

  Map<String, dynamic> toJson() => _$ZoneStateToJson(this);


}

@JsonSerializable(nullable: true)
class Zone extends ZoneBase {
  int id;
  double lat;
  double lon;
  String idZone;

  Zone(
      {String type,
      String code,
      String name,
      String address,
      this.lat,
      this.lon,
      this.id,
      this.idZone})
      : super(type: type, code: code, name: name, address: address);

  factory Zone.fromJson(Map<String, dynamic> json) => _$ZoneFromJson(json);

  Map<String, dynamic> toJson() => _$ZoneToJson(this);
}

@JsonSerializable(nullable: true)
class ZoneNovelty{
  String type;
  int cell;
  String reserveType;

  ZoneNovelty({this.type, this.cell, this.reserveType});

  factory ZoneNovelty.fromJson(Map<String, dynamic> json) => _$ZoneNoveltyFromJson(json);

  Map<String, dynamic> toJson() => _$ZoneNoveltyToJson(this);

}
