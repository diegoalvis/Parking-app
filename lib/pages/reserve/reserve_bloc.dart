import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:oneparking_citizen/data/models/reserve.dart';
import 'package:oneparking_citizen/data/repository/reserve_repository.dart';
import 'package:oneparking_citizen/data/socket/reserve_socket.dart';
import 'package:oneparking_citizen/util/error_codes.dart';
import 'package:oneparking_citizen/util/state-util.dart';
import 'package:rxdart/rxdart.dart';

class ReserveBloc extends Bloc<ReserveEvent, BaseState> {
  static const STOP_INTENTS = 3;

  ReserveRepository _repository;
  ReserveSocket _socket;
  StreamSubscription _subs;
  String plate;

  int retryIntents = STOP_INTENTS;

  final _valueSubject = BehaviorSubject<int>();

  Stream<int> get valueStream => _valueSubject.stream;

  final _errorSubject = PublishSubject<String>();

  Stream<String> get errorStream => _errorSubject.stream;

  ReserveBloc(this._repository, this._socket);

  void _listenReserveState(String plate) async {
    _subs?.cancel();
    _subs = null;
    _socket.close();

    await _socket.init();
    _subs = _socket.novelty(plate).stream.listen((stateReserve) {
      dispatch(ReserveEvent(ReserveEventType.getActive));
    }, onError: (e) {
      print("hola");
    });
  }

  @override
  void dispose() {
    _subs?.cancel();
    _subs = null;
    _socket.close();
    _valueSubject.close();
    _errorSubject.close();
    super.dispose();
  }

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(ReserveEvent event) async* {
    try {
      switch (event.event) {
        case ReserveEventType.getActive:
          yield LoadingState();
          final info = await _repository.current();
          if (info.reserve == null ||
              info.reserve.date == null ||
              info.retired) {
            yield NoReservesState();
          } else if (info.stopped) {
            _listenReserveState(info.reserve.plate);
            _valueSubject.add(info.value);
            await _repository.forceStop();
            yield FinishReserveState(reserve: info.reserve);
          } else {
            _listenReserveState(info.reserve.plate);
            yield SuccessState(data: info.reserve);
            final time = DateTime.now().difference(info.reserve.date);
            final value =
                await _repository.getValue(timeInMinutes: time.inMinutes + 1);
            _valueSubject.sink.add(value);
          }
          break;
        case ReserveEventType.stop:
          retryIntents--;
          if (retryIntents == 0) {
            await _repository.forceStop();
            yield FinishReserveState();
            break;
          }
          final stopRes = await _repository.stop();
          _valueSubject.add(stopRes);
          yield FinishReserveState();
          break;
        case ReserveEventType.getValue:
          final value =
              await _repository.getValue(timeInMinutes: event.data + 1 as int);
          _valueSubject.sink.add(value);
          break;
      }
    } on Exception catch (e) {
      if (e is StopReserveException) {
        _errorSubject.sink.add(e.cause);
        return;
      }
      yield ErrorState(errorMessage(e));
      await Future.delayed(Duration(seconds: 1));
      yield InitialState();
    }
  }
}

enum ReserveEventType { stop, getActive, getValue }

class ReserveEvent<T> {
  final ReserveEventType event;
  final T data;

  ReserveEvent(this.event, {this.data});
}

class FinishReserveState extends BaseState {
  final Reserve reserve;

  FinishReserveState({this.reserve});

  @override
  String toString() => 'state-finish-reserve';
}

class NoReservesState extends BaseState {
  @override
  String toString() => 'state-no-reserves';
}
