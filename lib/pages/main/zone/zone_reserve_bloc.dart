import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:oneparking_citizen/data/repository/reserve_repository.dart';
import 'package:oneparking_citizen/pages/main/zone/zone_dialog_events.dart';
import 'package:oneparking_citizen/pages/main/zone/zone_dialog_states.dart';
import 'package:oneparking_citizen/util/state-util.dart';

class ZoneReserveBloc extends Bloc<ReserveZone, BaseState> {
  ReserveRepository _reserve;

  ZoneReserveBloc(this._reserve);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(ReserveZone event) async* {
    yield* _reserveZone(event.zone);
  }

  Stream<BaseState> _reserveZone(Zone zone) async* {
    try {
      yield LoadingReserveState();
      await _reserve.start(zone.idZone, zone.name, zone.address, zone.code, false);
      yield SuccessReserveState();
    } on Exception catch (e) {
      yield ErrorReserveState();
      await Future.delayed(Duration(seconds: 1));
      yield InitialState();
    }
  }
}
