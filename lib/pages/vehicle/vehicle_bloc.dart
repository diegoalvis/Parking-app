import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/repository/vehicle_repository.dart';
import 'package:oneparking_citizen/util/error_codes.dart';
import 'package:oneparking_citizen/util/state-util.dart';

class VehicleEvent {
  String email;
  String pass;

  VehicleEvent({this.email, this.pass});
}

class VehicleBloc extends Bloc<VehicleEvent, BaseState> {
  VehicleRepository _repository;

  VehicleBloc(this._repository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(VehicleEvent event) async* {
    try {
      yield LoadingState();
      await _repository.all();
      yield SuccessState();
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      yield InitialState();
    }
  }
}
