import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/repository/vehicle_repository.dart';
import 'package:oneparking_citizen/pages/vehicle/vehicle_base_event.dart';
import 'package:oneparking_citizen/pages/vehicle/vehicle_state.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleRepository repository;

  VehicleBloc(this.repository);

  @override
  VehicleState get initialState => VehiclesLoading();

  @override
  Stream<VehicleState> mapEventToState(VehicleEvent event) async* {
    if (event is LoadVehicles) {
      yield* _mapLoadVehiclesToState();
    } else if (event is DeleteVehicle) {
      yield* _mapDeleteVehiclesToState(event);
    } else if (event is SelectVehicle) {
      yield* _mapSelectVehiclesToState(event);
    }
  }

  Stream<VehicleState> _mapLoadVehiclesToState() async* {
    try {
      yield VehiclesLoading();
      yield VehiclesLoaded(await this.repository.all());
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      yield InitialState();
    }
  }

  /*Stream<VehicleState> _mapDeleteVehiclesToState(VehicleState currentState, DeleteVehicle event) async* {
    if (currentState is VehiclesLoaded) {
      await this.repository.remove(event.vehicle);
      //final updatedVehicles = currentState.vehicles.where((vehicle) => vehicle.id != event.vehicle.id).toList();
      yield VehiclesLoaded(currentState.vehicles);
    }
  }*/

  Stream<VehicleState> _mapDeleteVehiclesToState(DeleteVehicle event) async* {
    try {
      await this.repository.remove(event.vehicle);
      yield VehiclesLoaded(await this.repository.all());
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      yield InitialState();
    }
  }

  Stream<VehicleState> _mapSelectVehiclesToState(SelectVehicle event) async* {
    try {
      await this.repository.select(event.vehicle);
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      yield InitialState();
    }
  }
}
