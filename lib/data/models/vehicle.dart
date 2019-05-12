import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable()
class VehicleBase{
  String plate;
  String brand;
  String type;

  VehicleBase({this.plate, this.brand, this.type});

  factory VehicleBase.fromJson(Map<String, dynamic> json) => _$VehicleBaseFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleBaseToJson(this);
}

@JsonSerializable(nullable: true)
class Vehicle extends VehicleBase{
  int id;
  bool selected;

  Vehicle({this.id, String plate, String brand, this.selected}):super(plate: plate, brand:brand);

  Vehicle.fromVehicle(Vehicle car){
    selected = false;
    plate = car.plate;
    brand = car.brand;
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}