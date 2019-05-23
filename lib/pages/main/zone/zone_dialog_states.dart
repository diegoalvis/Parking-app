import 'package:oneparking_citizen/data/models/event.dart';
import 'package:oneparking_citizen/data/models/vehicle.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:oneparking_citizen/util/state-util.dart';

class LoadingReserveState extends BaseState{
  @override
  String toString() => "loadingReserve";
}

class SuccessReserveState extends BaseState{
  @override
  String toString() => "SuccessReserve";
}

class ErrorReserveState extends BaseState{
  @override
  String toString() => "ErrorReserve";
}

class LoadedState extends BaseState{
  final ZoneState state;
  final Vehicle vehicle;

  LoadedState(this.state, this.vehicle);

  @override
  String toString() => "ZoneDialogLoaded";
}

class TimeOutState extends BaseState{
  @override
  String toString() => "ZoneDialogTimeOut";
}


class EventState extends BaseState{
  final Event event;
  EventState(this.event);

  @override
  String toString() => "ZoneDialogEvent";
}


class ZoneDialogError extends BaseState{
  @override
  String toString() => "ZoneDialogError";
}
