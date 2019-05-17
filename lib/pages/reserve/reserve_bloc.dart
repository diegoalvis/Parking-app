import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/models/reserve.dart';
import 'package:oneparking_citizen/data/repository/reserve_repository.dart';
import 'package:oneparking_citizen/util/error_codes.dart';
import 'package:oneparking_citizen/util/state-util.dart';

class ReserveBloc extends Bloc<ReserveEvent, BaseState> {
  ReserveRepository _repository;

  ReserveBloc(this._repository) {
   dispatch(ReserveEvent.getActive);
  }

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(ReserveEvent event) async* {
    try {
      switch (event) {
        case ReserveEvent.getActive:
          yield LoadingState();
          final reserve = await _repository.getCurrentReserve();
          yield SuccessState(data: reserve);
          break;
        case ReserveEvent.stop:
          yield LoadingState();
          await _repository.stop();
          yield FinishReserveState();
          break;
        case ReserveEvent.getValue:
          final value = await _repository.getValue();
          yield UpdateTimeState(value);
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      yield InitialState();
    }
  }
}

enum ReserveEvent { stop, getActive, getValue }

class UpdateTimeState extends BaseState {
  UpdateTimeState(int value);

  @override
  String toString() => 'state-update-time';
}

class FinishReserveState extends BaseState {
  @override
  String toString() => 'state-finish-reserve';
}
