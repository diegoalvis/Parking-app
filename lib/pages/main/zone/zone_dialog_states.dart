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
  String msg;
  ErrorReserveState(this.msg);
  @override
  String toString() => "ErrorReserve";
}

class LoadedState extends BaseState{
  final ZoneState state;
  final Vehicle vehicle;
  final bool disability;

  LoadedState(this.state, this.vehicle, this.disability);

  @override
  String toString() => "ZoneDialogLoaded";
}

class TimeOutState extends BaseState{
  @override
  String toString() => "ZoneDialogTimeOut";
}

class HolyDayState extends BaseState{
  @override
  String toString() => "HolyDayState";
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

class NoVehicleState extends BaseState{
  @override
  String toString() => "NoVehicleState";
}
