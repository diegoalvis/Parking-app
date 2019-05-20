import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/repository/info_repository.dart';
import 'package:oneparking_citizen/util/error_codes.dart';
import 'package:oneparking_citizen/util/state-util.dart';

class InfoBloc extends Bloc<InfoEvent, BaseState> {
  InfoRepository _repository;

  InfoBloc(this._repository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(InfoEvent event) async* {
    try {
      if (event == InfoEvent.fetchData) {
        final info = await _repository.get();
        yield SuccessState<Info>(data: info);
      }
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      //yield InitialState();
    }
  }
}

enum InfoEvent { fetchData }
