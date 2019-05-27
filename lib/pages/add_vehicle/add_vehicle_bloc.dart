import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';
import 'package:oneparking_citizen/util/state-util.dart';
import 'package:oneparking_citizen/data/repository/vehicle_repository.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class AddVehicleEvent {
  final Vehicle vehicle;

  AddVehicleEvent(this.vehicle);

  @override
  String toString() => 'AddVehicle {vehicle: $vehicle}';
}

class AddVehicleBloc extends Bloc<AddVehicleEvent, BaseState> {
  VehicleRepository _repository;

  AddVehicleBloc(this._repository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(AddVehicleEvent event) async* {
    List<Vehicle> vehicles = await _repository.all();
    try {
      yield LoadingState();
      if (vehicles.length == 0) {
        event.vehicle.selected = 1;
        await _repository.add(event.vehicle);
      } else {
        await _repository.add(event.vehicle);
      }
      yield SuccessState();
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 2));
      yield InitialState();
    }
  }

  void vehiclesList() {}
}
