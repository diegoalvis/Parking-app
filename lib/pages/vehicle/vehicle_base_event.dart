import 'package:equatable/equatable.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';

class VehicleEvent extends Equatable {}

class LoadVehicles extends VehicleEvent {
  @override
  String toString() => 'LoadVehicles';
}

class SelectVehicle extends VehicleEvent {
  final Vehicle vehicle;

  SelectVehicle(this.vehicle);

  @override
  String toString() => 'SelectVehicle {selectVehicle: $vehicle}';
}

class DeleteVehicle extends VehicleEvent {
  final Vehicle vehicle;

  DeleteVehicle(this.vehicle);

  @override
  String toString() => 'DeleteVehicle {vehicle: $vehicle}';
}
