import 'package:json_annotation/json_annotation.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';

part 'reserve.g.dart';

@JsonSerializable(nullable: true)
class ReserveReq{
  String idZone;
  String code;
  bool disability;
  VehicleBase vehicle;

  ReserveReq({this.idZone, this.code, this.vehicle, this.disability});

  factory ReserveReq.fromJson(Map<String, dynamic> json) => _$ReserveReqFromJson(json);
  Map<String, dynamic> toJson() => _$ReserveReqToJson(this);
}

@JsonSerializable(nullable: true)
class ReserveRes{
  String idReserve;
  DateTime date;

  ReserveRes({this.idReserve, this.date});

  factory ReserveRes.fromJson(Map<String, dynamic> json) => _$ReserveResFromJson(json);
  Map<String, dynamic> toJson() => _$ReserveResToJson(this);
}

@JsonSerializable(nullable: true)
class ReserveStopRes{
  int cost;
  int time;

  ReserveStopRes({this.cost, this.time});

  factory ReserveStopRes.fromJson(Map<String, dynamic> json) => _$ReserveStopResFromJson(json);
  Map<String, dynamic> toJson() => _$ReserveStopResToJson(this);
}

@JsonSerializable(nullable: true)
class ReserveDescription{
  int time;
  int totalCost;
  bool retired;
  bool stopped;

  ReserveDescription({this.time, this.totalCost, this.retired, this.stopped});

  factory ReserveDescription.fromJson(Map<String, dynamic> json) => _$ReserveDescriptionFromJson(json);
  Map<String, dynamic> toJson() => _$ReserveDescriptionToJson(this);
}