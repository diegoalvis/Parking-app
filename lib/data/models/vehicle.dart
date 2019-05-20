import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

const String TYPE_CAR = 'car';
const String TYPE_MOTORCYCLE = 'motorcycle';

@JsonSerializable()
class VehicleBase {
  String plate;
  String brand;
  String type;

  VehicleBase({this.plate, this.brand, this.type});

  Vehicle toLocal() => Vehicle(plate:this.plate, brand:this.brand, type:this.type, selected:0);

  factory VehicleBase.fromJson(Map<String, dynamic> json) => _$VehicleBaseFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleBaseToJson(this);
}

@JsonSerializable(nullable: true)
class Vehicle extends VehicleBase {
  int id;
  int selected;

  Vehicle({this.id, String plate, String brand, String type, this.selected})
      : super(plate: plate, brand: brand, type: type);

  VehicleBase toBaseVehicle() => VehicleBase(plate: plate, brand: brand, type: type);

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
