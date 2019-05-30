import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/repository/vehicle_repository.dart';
import 'package:oneparking_citizen/data/repository/zone_repository.dart';
import 'package:oneparking_citizen/pages/main/zone/zone_dialog_events.dart';
import 'package:oneparking_citizen/pages/main/zone/zone_dialog_states.dart';
import 'package:oneparking_citizen/util/state-util.dart';

class ZoneDialogBloc extends Bloc<ReadyZone, BaseState> {
  ZoneRepository _zone;
  VehicleRepository _vehicle;

  ZoneDialogBloc(this._zone, this._vehicle);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(ReadyZone event) async* {
    try {
      yield LoadingState();
      final state = await _zone.getState(event.id, event.type);
      if (state.des == StateZ.active) {
        final selected = await _vehicle.selected();
        yield LoadedState(state.state, selected);
      } else if (state.des == StateZ.timeout) {
        yield TimeOutState();
      } else if (state.des == StateZ.event) {
        yield EventState(state.event);
      } else if(state.des == StateZ.holyday){
        yield HolyDayState();
      }
    } on Exception catch (e) {
      yield ZoneDialogError();
    }
  }



}
