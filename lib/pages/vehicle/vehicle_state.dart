import 'package:equatable/equatable.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';

class VehicleState extends Equatable {}

class InitialState extends VehicleState {
  @override
  String toString() => 'InitialState';
}

class VehiclesLoading extends VehicleState {
  @override
  String toString() => 'VehiclesLoading';
}

class VehiclesLoaded extends VehicleState {
  final List<Vehicle> vehicles;

  VehiclesLoaded(this.vehicles);

  @override
  String toString() => 'VehiclesLoaded {vehicles: $vehicles}';
}

/*class SuccessState extends VehicleState {
  @override
  String toString() => 'SuccessState';
}*/

class ErrorState extends VehicleState {
  String msg;
  ErrorState(this.msg);
  @override
  String toString() => 'ErrorState';
}
