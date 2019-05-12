import 'package:json_annotation/json_annotation.dart';

part 'zone.g.dart';

@JsonSerializable(nullable: true)
class Point{
  String type;
  List<double> coordinates;
  Point({this.type, this.coordinates});

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
  Map<String, dynamic> toJson() => _$PointToJson(this);
}

@JsonSerializable(nullable: true)
class Zone{
  String type;
  Point centerPoint;
  String code;
  String name;
  String address;

  Zone({this.type, this.centerPoint, this.code, this.name, this.address});

  factory Zone.fromJson(Map<String, dynamic> json) => _$ZoneFromJson(json);
  Map<String, dynamic> toJson() => _$ZoneToJson(this);
}

@JsonSerializable(nullable: true)
class ZoneState{
  int carCells;
  int usedCarCells;
  int motorcycleCells;
  int usedMotorcycleCells;
  int disabilityCells;
  int usedDisabilityCells;

  ZoneState(this.carCells, this.usedCarCells, this.motorcycleCells, this.usedMotorcycleCells, this.disabilityCells, this.usedDisabilityCells);

  factory ZoneState.fromJson(Map<String, dynamic> json) => _$ZoneStateFromJson(json);
  Map<String, dynamic> toJson() => _$ZoneStateToJson(this);
}
