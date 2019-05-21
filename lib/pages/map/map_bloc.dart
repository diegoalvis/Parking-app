import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:oneparking_citizen/data/repository/zone_repository.dart';
import 'package:oneparking_citizen/util/state-util.dart';
import 'package:oneparking_citizen/util/error_codes.dart';

class MapBloc extends Bloc<MapEvent, BaseState> {

  final ZoneRepository _repository;

  MapBloc(this._repository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(MapEvent event) async* {
    try {
      if (event == MapEvent.fetchData) {
        final zones = await _repository.getZones();
        yield SuccessState<List<Zone>>(data: zones);
      }
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      //yield InitialState();
    }
  }

}

enum MapEvent { fetchData }
