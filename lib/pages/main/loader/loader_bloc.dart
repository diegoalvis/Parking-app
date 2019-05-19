import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/repository/setup_repository.dart';
import 'package:oneparking_citizen/util/error_codes.dart';
import 'package:oneparking_citizen/util/state-util.dart';

enum LoaderEvent { fetchData }

class LoaderBloc extends Bloc<LoaderEvent, BaseState> {

  SetupRepository _repository;

  LoaderBloc(this._repository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(LoaderEvent event) async* {
    try {
      if (event == LoaderEvent.fetchData) {
        final isCurrentVersion = await _repository.isCurrentVersion();
        if (isCurrentVersion) {
          yield SuccessState();
        } else {
          await _repository.setupCurrentVersion();
          yield SuccessState();
        }
      }
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
    }
  }
}
