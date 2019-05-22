import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  UserSession session;

  MainBloc(this.session);

  @override
  MainState get initialState => MainState.showMap;

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    switch (event) {
      case MainEvent.showMap:
        yield MainState.showMap;
        break;
      case MainEvent.showVehicles:
        yield MainState.showVehicles;
        break;
      case MainEvent.showBills:
        yield MainState.showBills;
        break;
      case MainEvent.showInfo:
        yield MainState.showInfo;
        break;
      case MainEvent.logout:
        await session.clear();
        yield MainState.logout;
        break;
    }
  }
}

enum MainEvent { showMap, showVehicles, showBills, showInfo, logout }
enum MainState { showMap, showVehicles, showBills, showInfo, logout }
