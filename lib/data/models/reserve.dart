import 'package:json_annotation/json_annotation.dart';

part 'reserve.g.dart';

@JsonSerializable(nullable: true)
class Reserve{
  int id;
  String idReserve;
  DateTime date;
  String plate;
  String type;
  String name;
  String address;

  Reserve({this.id, this.idReserve, this.date, this.plate, this.name, this.address, this.type});

  factory Reserve.fromJson(Map<String, dynamic> json) => _$ReserveFromJson(json);

  Map<String, dynamic> toJson() => _$ReserveToJson(this);

}