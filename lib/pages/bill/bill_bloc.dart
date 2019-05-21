import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/repository/bill_repository.dart';
import 'package:oneparking_citizen/util/error_codes.dart';
import 'package:oneparking_citizen/util/state-util.dart';

class BillBloc extends Bloc<BillEvent, BaseState> {
  BillRepository _repository;

  BillBloc(this._repository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(BillEvent event) async* {
    try {
      if (event == BillEvent.fetchData) {
        yield LoadingState();
        final info = await _repository.get();
        yield SuccessState<BillInfo>(data: info);
      }
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      //yield InitialState();
    }
  }
}

enum BillEvent { fetchData }
