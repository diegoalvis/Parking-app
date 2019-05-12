import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle{
  String plate;
  String brand;
  String type;

  Vehicle({this.plate, this.brand, this.type});

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}

@JsonSerializable(nullable: true)
class VehicleLocal extends Vehicle{
  int id;
  bool selected;

  VehicleLocal({this.id, String plate, String brand, this.selected}):super(plate: plate, brand:brand);

  VehicleLocal.fromVehicle(Vehicle car){
    selected = false;
    plate = car.plate;
    brand = car.brand;
  }

  factory VehicleLocal.fromJson(Map<String, dynamic> json) => _$VehicleLocalFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleLocalToJson(this);
}