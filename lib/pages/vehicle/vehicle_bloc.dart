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
  VehicleState get initialState => InitialState();

  @override
  Stream<VehicleState> mapEventToState(VehicleEvent event) async* {
    if (event is LoadVehicles) {
      yield* _mapLoadVehiclesToState();
    } else if (event is DeleteVehicle) {
      yield* _mapDeleteVehiclesToState(event, currentState);
    } else if (event is SelectVehicle) {
      yield* _mapSelectVehiclesToState(event);
    } else if(event is ReloadVehicles){
      yield* _mapReloadVehiclesToState();
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

  Stream<VehicleState> _mapDeleteVehiclesToState(DeleteVehicle event, VehicleState currentState) async* {
    try {
      await this.repository.remove(event.vehicle);
      yield InitialState();
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      yield InitialState();
    }
  }

  Stream<VehicleState> _mapSelectVehiclesToState(SelectVehicle event) async* {
    try {
      await this.repository.select(event.vehicle);
      yield VehiclesLoaded(await this.repository.all());
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      yield InitialState();
    }
  }

  Stream<VehicleState> _mapReloadVehiclesToState() async* {
    try {
      yield VehiclesLoading();
      final vehicles = await this.repository.reload();
      yield VehiclesLoaded(vehicles);
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      yield InitialState();
    }
  }
}
