import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';
import 'package:oneparking_citizen/data/repository/setup_repository.dart';
import 'package:oneparking_citizen/util/error_codes.dart';
import 'package:oneparking_citizen/util/state-util.dart';

enum LoaderEvent { fetchData }

class LoaderBloc extends Bloc<LoaderEvent, BaseState> {

  SetupRepository _repository;
  UserSession _session;

  LoaderBloc(this._repository, this._session);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(LoaderEvent event) async* {
    try {
      if (event == LoaderEvent.fetchData) {
        final isCurrentVersion = await _repository.isCurrentVersion();
        final now = DateTime.now();
        if (isCurrentVersion) {
          _session.setToDay(now.day, now.month);
          yield SuccessState();
        } else {
          await _repository.setupCurrentVersion();
          _session.setToDay(now.day, now.month);
          yield SuccessState();
        }
      }
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
    }
  }
}
